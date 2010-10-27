package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Matrix;
	
	import game.*;
	
	import models.*;
	
	import skins.*;
	
	import utils.*;
	
	//[SWF(widthPercent="1024" , heightPercent="768")]
	public class PlantsClinet extends MovieClip 
	{
		private var mLoader:DataLoader = new DataLoader();
		private var mSpriteLoader:SpriteLoader = new SpriteLoader();
		private var mCache:BitmapCache = BitmapCache.instance;
		
		public function PlantsClinet() 
		{			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			mLoader.addEventListener("StateLoaded",onStateLoaded);
			mLoader.addEventListener("HerbariumLoaded",onHerbariumLoaded);
			mCache.addEventListener("AllSpritesLoaded",onAllSpritesLoaded);
			
			mLoader.getHerbarium();
			
			this.addButtons();
		}
		
		private function addButtons():void
		{
			var turnButton:IntButton = new IntButton("TURN");
			turnButton.x = 0;
			turnButton.y = 0;
			turnButton.addEventListener(MouseEvent.CLICK,onTurn);
			addChild(turnButton);

			var seedButton:IntButton = new IntButton("SEED");
			seedButton.x = 100;
			seedButton.y = 0;
			//seedButton.addEventListener(MouseEvent.CLICK,onTurn);
			addChild(seedButton);

			var digButton:IntButton = new IntButton("DIG");
			digButton.x = 200;
			digButton.y = 0;
			//digButton.addEventListener(MouseEvent.CLICK,onTurn);
			addChild(digButton);
			
		}
		
		private function cleanupScene():void
		{
			if(this.numChildren!=0)
			{
				var i:int = this.numChildren;
				while(i --)
				{
					this.removeChildAt(i);
				}
			}
		}
		
		private function onStateLoaded(event:Event):void
		{	
			// Here we have Herbarium & Initial State
			this.cleanupScene();
			
			this.addButtons();
			
			// force loading all sprites
			AppState.getSpritesForPlants();
		}
		
		private function onHerbariumLoaded(event:Event):void
		{
			trace("herbarium loaded");
			mLoader.getCurrentField();
		}
		
		private function onAllSpritesLoaded(event:Event):void
		{
			var i:int = 0;
			for each (var h:Plant in AppState.field)
			{
				var plant:Bitmap = h.getSprite().getBitmap();
				plant.x = i+(plant.width / 2);
				plant.y = i+(plant.height-50);
				this.addChild(plant);
				i+=50;
			}
		}
		
		private function onTurn(event:Event):void
		{
			trace("turn");
			mLoader.nextTurn();
		}

		private function onSeed(event:Event):void
		{
			trace("seed");
		}

		private function onDig(event:Event):void
		{
			trace("dig");
		}

		
	}
}
