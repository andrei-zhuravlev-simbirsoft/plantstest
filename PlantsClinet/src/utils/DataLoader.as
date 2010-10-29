package utils {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.*;
	import flash.xml.*;
	
	import models.*;
	import events.ErrorOccuredEvent;
	
	public class DataLoader extends EventDispatcher
	{    
		private var loader:URLLoader;
		private var retrievingData:Boolean = false;
		
		public static var COUNTRY:String = "country";
		public static var ERROR:String = "error";
		public static var HERBARIUM:String = "herbarium";
		//public static var IMAGE:String = "image";
		
		public var data:Object = null;

		public function DataLoader() 
		{
			loader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		public function getCurrentField():void
		{
			var request:URLRequest = new URLBroker().getURLRequest(Commands.STATE);
			
			this.request(request);
			
			trace("Loading State");
		}
		
		public function getHerbarium():void
		{
			var request:URLRequest = new URLBroker().getURLRequest(Commands.LIST);
			
			this.request(request);
			
			trace("Loading Herbarium");
		}
		
		public function nextTurn():void
		{	
			var request:URLRequest = new URLBroker().getURLRequest(Commands.TURN);
			
			this.request(request);
			
			trace("Next Turn");
		}
		
		public function seedPlant(x:int, y:int, plant_id:int):void
		{	
			var request:URLRequest = new URLBroker().getURLRequest(Commands.SEED, new Array(x, y, plant_id));
			
			this.request(request);
			
			trace("Seeding plant "+plant_id.toString()+" at:("+x.toString()+","+y.toString()+")");
		}
		
		public function digPlant(x:int, y:int):void
		{	
			var request:URLRequest = new URLBroker().getURLRequest(Commands.DIG, new Array(x, y));
			
			this.request(request);
			
			trace("Dig plant at:("+x.toString()+","+y.toString()+")");
		}

		/*public function getImage(plant_id:int=-1, state_id:int=-1):void
		{	
			var request:URLRequest;
			
			
			if (plant_id > 0 && state_id > 0)
				request = new URLBroker().getURLRequest(Commands.IMAGE, new Array(plant_id, state_id)); // get image for certain plant & state
			if (plant_id > 0 && state_id < 0)
			{
				var pars:Array = new Array();
				pars.push(plant_id)
				request = new URLBroker().getURLRequest(Commands.IMAGE, pars); // get init plant image (seed)
			} 
			if (plant_id < 0 && state_id < 0)
				request = new URLBroker().getURLRequest(Commands.IMAGE); // get background image
			
			this.request(request);
		}*/

		private function request(req:URLRequest):void
		{
			try 
			{
				req.requestHeaders.push(new URLRequestHeader("Pragma", "no-cache"));
				req.requestHeaders.push(new URLRequestHeader("Cache-Control", "no-store"));
				req.data = new URLVariables("time="+Number(new Date().getTime()))
				this.loader.load(req);
			}
			catch (error:SecurityError)
			{
				trace("A SecurityError has occurred.");
			}
			
			this.retrievingData = true;
		}
		
		private function parseData(data:XML):void
		{
			switch(data.localName())
			{
				case DataLoader.COUNTRY:
					AppState.field = new Array();
					Config.GridSizeX = int(data.field.attribute("size_x"));
					Config.GridSizeY = int(data.field.attribute("size_y"));
					for each (var p:XML in data.field.children())
					{
						AppState.field.push(new Plant(p));
					}
					trace("new State received");
					this.dispatchEvent(new Event("StateLoaded",true));
				break;
				case DataLoader.HERBARIUM:
					AppState.herbarium = new Array();
					for each (var plant:XML in data.children())
					{
						AppState.herbarium.push(new Plant(plant));
					}
					trace("new Herbarium received");
					this.dispatchEvent(new Event("HerbariumLoaded",true));
				break;				
				case DataLoader.ERROR:
					var id:int = int(data.attribute("id"));
					var msg:String = data.attribute("message").toString();
					this.dispatchEvent(new ErrorOccuredEvent(id,msg,true));
				break;
			}
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			this.retrievingData = false;
		}

		private function onLoadComplete(event:Event):void 
		{	
			try 
			{
				if (XML(loader.data) is XML) // XML Data (State or Error)
				{
					var externalXML:XML = new XML(loader.data);
					parseData(externalXML);
				}
				/*else // Image
				{
					this.data = loader.data;
					this.dispatchEvent(new Event("ImageLoaded",true));
				}*/
			} 
			catch (e:TypeError) 
			{
				trace("Could not parse the XML file.");
			}
			this.retrievingData = false;
		}

	}
}
