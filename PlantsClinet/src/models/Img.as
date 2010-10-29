package models
{
	import events.SpriteLoadedEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	
	import game.BitmapCache;
	
	import utils.*;
	
	public class Img extends Sprite
	{
		public var plant_id:int;
		public var state_id:int;
		
		private var mLoader:Loader = new Loader();
		private var mSpriteLoaded:Boolean = false;
		
		private var mCache:BitmapCache = BitmapCache.instance;
		
		public function Img(plant_id:int = -1, state_id:int = -1)
		{
			super();
			
			if (plant_id > 0 && state_id > 0) // image will be loaded
			{
				this.plant_id = plant_id;
				this.state_id = state_id;
			
				mLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
				mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSuccess);
			
				this.getImage(this.plant_id,this.state_id);
			
				mCache.addImage(this);
			}
			else // placeholder sprite
			{
				//this.drawPlaceholder(50,);
			}
		}
		
		public function drawPlaceholder(sizex:int,sizey:int,color:int,alpha:Number=1):void
		{			
			this.graphics.clear();
			this.graphics.beginFill(color,alpha);
			this.graphics.lineStyle(0,0,alpha);
			//this.graphics.drawRect(0,0,sizex,sizey);
			this.graphics.moveTo(sizex*0.5,0);
			this.graphics.lineTo(0,sizey*0.5);
			this.graphics.lineTo(sizex*0.5,sizey);
			this.graphics.lineTo(sizex,sizey*0.5);
			this.graphics.lineTo(sizex*0.5,0);
		}
		
		private function getImage(plant_id:int=-1, state_id:int=-1):Object
		{	
			var _sprite:Img = mCache.checkCache(plant_id, state_id);
			if (_sprite != null)
			{
				this.mSpriteLoaded = true;
				return _sprite;
			}
			
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
		
		/*protected function checkCache(plant_id:int, state_id:int):Img
		{
			for each (var i:Img in BitmapCache.mImages)
			{
				if (i.plant_id == plant_id && i.state_id == state_id)
					return i;
			}
			
			return null;
		}*/
		
		public function get isLoaded():Boolean
		{
			return this.mSpriteLoaded;
		}
		
		public function getBitmap(fillcolor:int=0x00000000):Bitmap
		{	
			if (this.isLoaded)
			{
				var bd:BitmapData = new BitmapData(this.width, this.height, true, fillcolor);
				bd.draw(this);
				return new Bitmap(bd);
			}
			
			return null;
		}
		
		private function onError(event:Event):void
		{
			this.mSpriteLoaded = true; //FIXME
		}
		
		private function onSuccess(event:Event):void
		{
			if (this.isLoaded)
				return;
			
			var info:LoaderInfo = LoaderInfo(this.mLoader.contentLoaderInfo);
			var pattern:RegExp = /image\//
			
			if (info.contentType.match(pattern)) // image is loaded
			{
				this.mSpriteLoaded = true;
				//trace("sprite pid: "+this.plant_id+", sid: "+this.state_id+" loaded");
				
				//mCache.addImage(this);
				this.addChild(this.mLoader);
				mCache.dispatchEvent(new SpriteLoadedEvent(this.plant_id, this.state_id, true));
			}
		}
	}
}