package game
{	
	import events.SpriteLoadedEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import models.Img;
	
	public class BitmapCache extends EventDispatcher
	{
		/*private*/public static var mImages:Array = new Array();
		private static var mInstance:BitmapCache = new BitmapCache();
		private var mIsAllLoaded:Boolean = false;
		
		public function BitmapCache()
		{
			this.addEventListener(events.SpriteLoadedEvent.TYPE, onSpriteLoaded);
		}
		
		static public function get instance():BitmapCache
		{
			return BitmapCache.mInstance;
		}
		
		public function addImage(img:Img):Boolean
		{
			if (this.checkCache(img.plant_id, img.state_id) == null)
			{			
				BitmapCache.mImages.push(img);
				trace("sprite cached");
			}
			
			return true;
		}
		
		public function checkCache(plant_id:int, state_id:int):Img
		{
			for each (var i:Img in BitmapCache.mImages)
			{
				if (i.plant_id == plant_id && i.state_id == state_id)
					return i;
			}
			
			return null;
		}
		
		public function get isAllLoaded():Boolean
		{
			return this.mIsAllLoaded;
		}
		
		private function onSpriteLoaded(event:SpriteLoadedEvent):void
		{
			// check if all sprites are already loaded
			var all_loaded:Boolean = true;
			for each (var i:Img in BitmapCache.mImages)
			{
				if (!i.isLoaded)
				{
					this.mIsAllLoaded = false;
					return;
				}
			}
			
			if (all_loaded)
			{
				this.mIsAllLoaded = true;
				this.dispatchEvent(new Event("AllSpritesLoaded",true));
			}
		}
	}
}