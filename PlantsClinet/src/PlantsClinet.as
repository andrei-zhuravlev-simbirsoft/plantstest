package {
	import events.ErrorOccuredEvent;
	import events.TileSelectedEvent;
	
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
	
	//[SWF(widthPercent="100%" , heightPercent="100%")]
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
		private var mSelectedPlantId:int = -1;
		
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
		
		private function plantSelectionMenu(X:int,Y:int):void
		{
			var menu:Sprite = new Sprite();
			menu.graphics.clear();
			menu.graphics.beginFill(0xffaaaaaa);
			menu.graphics.lineStyle(2,0,1);
			menu.graphics.drawRect(X,Y,200,150);
			menu.name = "PlantSelect";
			
			var cnt:int = 0;
			for each (var p:Plant in AppState.herbarium)
			{
				var textLabel:TextField = new TextField();
				textLabel.text = p.Name;;
				textLabel.x = 0;
				textLabel.y = 0;
				textLabel.scaleX = 2;
				textLabel.scaleY = 2;
			
				var box:Sprite = new Sprite();
				box.x = X+10;
				box.y = Y+40*cnt;
				box.name = p.Id.toString();
				box.addEventListener(MouseEvent.ROLL_OVER,
					function(e:MouseEvent):void 
					{
						var s:Sprite = e.currentTarget as Sprite;
						s.graphics.clear();
						s.graphics.lineStyle(1,0,1);
						s.graphics.drawRect(0,5,150,40);
					}
				);
				box.addEventListener(MouseEvent.ROLL_OUT,
					function(e:MouseEvent):void 
					{
						var s:Sprite = e.currentTarget as Sprite;
						s.graphics.clear();
					}
				);
				box.addEventListener(MouseEvent.CLICK,
					function(e:MouseEvent):void 
					{
						var s:Sprite = e.currentTarget as Sprite;
						
						s.dispatchEvent(new Event("PlantSelected"));
					}
				);
				box.addChild(textLabel);
				box.addEventListener("PlantSelected",onSeedPlantSelected);
				
				menu.addChild(box);
				cnt++;
			}
			
			this.addChild(menu);
		}
		
		private function showMessage(message:String, color:Number = 0xffffffff):void
		{
			this.removeChildNyName("Message");
			
			var textLabel:TextField = new TextField();
			textLabel.text = message;
			textLabel.x = 300;
			textLabel.y = 0;
			textLabel.scaleX = 2;
			textLabel.scaleY = 2;
			textLabel.selectable = false;
			textLabel.width = 500;
			textLabel.height = 20;
			textLabel.name = "Message";
			//textLabel.border = true;
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
			
			if (mCache.isAllLoaded || BitmapCache.mImages.length == 0) // all bitmaps are loaded or empty field. can draw
			{
				this.draw(450,100);
			}
		}
		
		private function draw(initXCoord:int, initYCoord:int):void
		{
			this.cleanupScene();
			this.mGameGrid= new Field(Config.GridSizeX,Config.GridSizeY,initXCoord,initYCoord);
			this.mGameGrid.addEventListener(TileSelectedEvent.TYPE, onTileSelected);
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
		}
		
		private function onError(event:ErrorOccuredEvent):void
		{
			var err:models.Error = event.error; 
			
			this.showMessage("Error("+err.id.toString()+"): "+err.message, 0x00ff0000);
			this.mMode = PlantsClinet.MODE_VIEW;
		}
		
		private function onTileSelected(event:TileSelectedEvent):void
		{
			var t:Tile = event.Tile;
			
			switch (this.mMode)
			{
				case PlantsClinet.MODE_VIEW:
					
				break;
				case PlantsClinet.MODE_SEED:
					if (!t.hasPlant && this.mSelectedPlantId > 0)
					{
						this.mLoader.seedPlant(t.X, t.Y, this.mSelectedPlantId);
						this.mSelectedPlantId = -1;
					}
					else
					{
						this.mMode = PlantsClinet.MODE_VIEW;
						this.showMessage("Tile is not empty or plant is not selected.Can't seed", 0x00ff0000);
					}
				break;
				case PlantsClinet.MODE_DIG:
					if (t.hasPlant)
						this.mLoader.digPlant(t.X, t.Y);
					else
					{
						this.mMode = PlantsClinet.MODE_VIEW;
						this.showMessage("No plant selected", 0x00ff0000);
					}
				break;
				case PlantsClinet.MODE_ERR:
				break;
			}
		}
		
		private function onSeedPlantSelected(event:Event):void
		{
			this.mSelectedPlantId = int((event.currentTarget as Sprite).name);
			this.removeChildNyName("PlantSelect");
			this.showMessage("Select empty tile to seed");
			this.mMode = PlantsClinet.MODE_SEED;
		}
		
		private function removeChildNyName(name:String):void
		{
			var msg:DisplayObject = this.getChildByName(name); 
			if (msg != null)
			{
				this.removeChild(msg);
			}
		}
		
		private function onTurn(event:Event):void
		{
			if (this.mMode != PlantsClinet.MODE_VIEW)
				return;
			
			trace("turn");
			mLoader.nextTurn();
		}

		private function onSeed(event:Event):void
		{
			if (this.mMode != PlantsClinet.MODE_VIEW)
				return;
			
			trace("seed");
			this.plantSelectionMenu(100,100);
			this.mMode = PlantsClinet.MODE_SEED;
			this.showMessage("Select plant to seed from menu");
		}

		private function onDig(event:Event):void
		{
			if (this.mMode != PlantsClinet.MODE_VIEW)
				return;
			
			trace("dig");
			this.mMode = PlantsClinet.MODE_DIG;
			this.showMessage("Select plant to dig");
		}
	}
}
