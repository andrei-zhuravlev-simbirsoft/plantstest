package utils
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import game.BitmapCache;
	
	import models.Img;

	public class SpriteLoader
	{
		private var mLoader:Loader = new Loader();
		
		private var mPid:int; //plant_id
		private var mSid:int; //state_id
		
		private var mCache:BitmapCache = BitmapCache.instance;
		
		public function SpriteLoader()
		{
			mLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSuccess);
		}
		
		public function getImage(plant_id:int=-1, state_id:int=-1):Object
		{	
			var _sprite:Img = checkCache(plant_id, state_id);
			if (_sprite != null)
				return _sprite;
			
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
			
			this.mLoader.load(request);
			
			return null;
		}
		
		protected function checkCache(plant_id:int, state_id:int):Img
		{
			for each (var i:Img in game.BitmapCache.mImages)
			{
				if (i.plant_id == plant_id && i.state_id == state_id)
					return i;
			}
			
			return null;
		}
		
		public function onError(event:Event):void
		{
			
		}
		
		public function onSuccess(event:Event):void
		{
			var info:LoaderInfo = LoaderInfo(this.mLoader.contentLoaderInfo);

			if (info.contentType.match(new RegExp("/image\//"))) // image is loaded
			{
				var _img:Img = new Img(this.mPid, this.mSid);
				_img.addChild(this.mLoader);
				mCache.addImage(_img);
			}
		}

	}
}