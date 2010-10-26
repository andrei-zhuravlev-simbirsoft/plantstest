package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Matrix;
	
	import game.*;
	import models.*;
	import skins.*;
	import utils.*;
	
	public class PlantsClinet extends MovieClip 
	{
		private var mLoader:DataLoader = new DataLoader();
		private var mSpriteLoader:SpriteLoader = new SpriteLoader(); 
		
		public function PlantsClinet() 
		{			
			mLoader.addEventListener("StateLoaded",onStateLoaded);
			mLoader.addEventListener("HerbariumLoaded",onHerbariumLoaded);
			
			mLoader.getHerbarium();
		}
		
		private function onStateLoaded(event:Event):void
		{	
			trace("start");
			// Here we have Herbarium & Initial State
			
		}
		
		private function onHerbariumLoaded(event:Event):void
		{
			trace("data loaded");
			mLoader.getCurrentField();
		}
	}
}
