package {
	import events.ErrorOccuredEvent;
	
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
	import flash.text.TextField;
	
	import game.*;
	
	import models.*;
	
	import skins.*;
	
	import utils.*;
	
	//[SWF(widthPercent="1024" , heightPercent="768")]
	[SWF(width="1024" , height="768")]
	public class PlantsClinet extends MovieClip 
	{
		private static var MODE_VIEW:String = "view";
		private static var MODE_SEED:String = "seed";
		private static var MODE_DIG:String = "dig";
		private static var MODE_ERR:String = "error";
		
		private var mLoader:DataLoader = new DataLoader();
		private var mSpriteLoader:SpriteLoader = new SpriteLoader();
		private var mCache:BitmapCache = BitmapCache.instance;
		private var mMode:String = PlantsClinet.MODE_VIEW;
		
		private var mGameGrid:Field;
		
		public function PlantsClinet() 
		{			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			mLoader.addEventListener("StateLoaded",onStateUpdated);
			mLoader.addEventListener("HerbariumLoaded",onHerbariumLoaded);
			mLoader.addEventListener(ErrorOccuredEvent.TYPE,onError);
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
			seedButton.addEventListener(MouseEvent.CLICK,onSeed);
			addChild(seedButton);

			var digButton:IntButton = new IntButton("DIG");
			digButton.x = 200;
			digButton.y = 0;
			digButton.addEventListener(MouseEvent.CLICK,onDig);
			addChild(digButton);
			
		}
		
		private function showMessage(message:String, color:Number = 0xffffffff):void
		{
			this.removeMessage();
			
			var textLabel:TextField = new TextField();
			textLabel.text = message;
			textLabel.x = 300;
			textLabel.y = 0;
			textLabel.scaleX = 2;
			textLabel.scaleY = 2;
			textLabel.selectable = false;
			textLabel.width = 500;
			textLabel.name = "Message";
			this.addChild(textLabel)
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
			// force loading all new sprites
			AppState.getSpritesForPlants();
			
			if (mCache.isAllLoaded) // all bitmaps are loaded. can draw
			{
				this.draw(450,100);
			}
		}
		
		private function draw(initXCoord:int, initYCoord:int):void
		{
			this.cleanupScene();
			this.mGameGrid= new Field(Config.GridSizeX,Config.GridSizeY,initXCoord,initYCoord);
			this.addButtons();
			this.mMode = PlantsClinet.MODE_VIEW;
			this.addChild(this.mGameGrid);
		}
		
		private function onHerbariumLoaded(event:Event):void
		{
			trace("herbarium loaded");
			mLoader.getCurrentField();
		}
		
		private function onAllSpritesLoaded(event:Event):void
		{	
			this.draw(450,100);
			/*this.cleanupScene();
			this.mGameGrid = new Field(Config.GridSizeX,Config.GridSizeY,450,100);
			this.addButtons();
			this.addChild(this.mGameGrid);*/
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
		
		private function onError(event:ErrorOccuredEvent):void
		{
			var id:int = event.Id;
			var msg:String = event.Message;
			
			this.showMessage("Error("+id.toString()+"): "+msg);
		}
		
		private function removeMessage():void
		{
			var msg:DisplayObject = this.getChildByName("Message"); 
			if (msg != null)
			{
				this.removeChild(msg);
			}
		}
		
		private function onTurn(event:Event):void
		{
			trace("turn");
			this.removeMessage();
			mLoader.nextTurn();
		}

		private function onSeed(event:Event):void
		{
			trace("seed");
			this.mMode = PlantsClinet.MODE_SEED;
			//this.removeMessage();
			this.showMessage("Select empty tile to seed");

		}

		private function onDig(event:Event):void
		{
			trace("dig");
			this.mMode = PlantsClinet.MODE_DIG;
			//this.removeMessage();
			this.showMessage("Select plant to dig");
			
			this.mLoader.digPlant(100,100);
		}
	}
}
