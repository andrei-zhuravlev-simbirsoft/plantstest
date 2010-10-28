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
	[SWF(width="1024" , height="768")]
	public class PlantsClinet extends MovieClip 
	{
		private var mLoader:DataLoader = new DataLoader();
		private var mSpriteLoader:SpriteLoader = new SpriteLoader();
		private var mCache:BitmapCache = BitmapCache.instance;
		
		public function PlantsClinet() 
		{			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			mLoader.addEventListener("StateLoaded",onStateUpdated);
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
		
		private function onStateUpdated(event:Event):void
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
			this.cleanupScene();
			var f:Field = new Field(Config.GridSizeX,Config.GridSizeY,450,100);
			this.addButtons();
			//var f:Field = new Field(5,4,400,100);
			this.addChild(f);
			/*ar i:int = 0;
			var px:int = 400;
			var py:int = 200;
			var pheight:int = 0;
			var pwidth:int = 0;
			for each (var h:Plant in AppState.field)
			{
				var plant:Bitmap = h.getSprite().getBitmap();//0xffffffff);
				if (pheight == 0 && pwidth == 0)
				{
					plant.x = px;
					plant.y = py;
				}
				else
				{
					plant.x = px-(plant.width / 2);
					if (pheight <= plant.height)
						plant.y = py+(pheight+25-plant.height);
					else
						plant.y = py+(pheight+25-plant.height);//-50;
				}


				this.addChild(plant);
				px = plant.x;
				py = plant.y
				pheight = plant.height;
				pwidth = plant.width;
			}
			var z:Img = new Img();
			z.x=300;
			z.y=400;
			z.addEventListener(MouseEvent.ROLL_OVER,onROver);
			z.addEventListener(MouseEvent.ROLL_OUT,onROut);
			this.addChild(z);*/
		}
		
		private function onROver(event:MouseEvent):void
		{
			(event.target as Img).drawPlaceholder(50,0,0.5);
		}
		
		private function onROut(event:MouseEvent):void
		{
			(event.target as Img).drawPlaceholder(50,0x00ff0000,0);
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
