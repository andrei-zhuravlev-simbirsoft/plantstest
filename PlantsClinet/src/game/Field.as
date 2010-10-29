package game
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.*;
	import flash.utils.flash_proxy;
	
	import models.*;
	
	public class Field extends Sprite
	{
		
		// Constants:
		public static const SCR_WIDTH:int = 1024;
		public static const SCR_HEIGHT:int = 768;
		public static const CELL_SIZE:int = 100;
		public static const DECAY:Number = 0.9;
		public static const MAP_W:int = 10;
		public static const MAP_H:int = 10;
		
		// Public Properties:		
		
		
		// Private Properties:
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		
		/* Размер карты */
		private var _mapWidth:int = MAP_W * CELL_SIZE;
		private var _mapHeight:int = MAP_H * CELL_SIZE;
		
		private var _bmp:Bitmap; // Игровая сетка
		
		// Initialization:
		public function Field(width:int,height:int,startx:int,starty:int)
		{
			grid(width,height,startx,starty);
			
			//addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function onTileRollOver(event:MouseEvent):void
		{
			(event.target as Tile).selected();
		}
		
		private function onTileRollOut(event:MouseEvent):void
		{
			(event.target as Tile).deselected();
		}
		
		private function onTileClick(event:MouseEvent):void
		{
			var t:Tile = (event.currentTarget as Tile);
			var s:String = "Tile X-"+t.X.toString()+" Y-"+t.Y.toString()+" isPlant-"+t.hasPlant.toString();
			ExternalInterface.call("alert",s);
			trace(s);
		}
		
		// Public Methods:
		
		public function hScroll(val:Number):void
		{
			_speedX += val;
		}
		
		public function vScroll(val:Number):void
		{
			_speedY += val;
		}
		
		public function get mapWidth():int
		{
			return _mapWidth;
		}
		
		public function get mapHeight():int
		{
			return _mapHeight;
		}
				
//		private function enterFrameHandler(e:Event):void
//		{			
//			/* Прибавляем скорость к положению карты */
//			x += int(_speedX);
//			y += int(_speedY);
//			
//			/* Горизонтальная прокрутка */
//			if (x > 0) // Выезд за левый край
//			{
//				x = 0;
//				_speedX = 0;
//			}
//			else if (x < -_mapWidth + SCR_WIDTH) // Выезд за правый край
//			{
//				x = -_mapWidth + SCR_WIDTH;
//				_speedX = 0;
//			}
//			
//			/* Вертикальная прокрутка */
//			if (y > 0) // Выезд за верхний край
//			{
//				y = 0;
//				_speedY = 0;
//			}
//			else if (y < -_mapHeight + SCR_HEIGHT) // Выезд за нижний край
//			{
//				y = -_mapHeight + SCR_HEIGHT;
//				_speedY = 0;
//			}			
//			
//			/* Применяем торможение к скорости */
//			_speedX *= DECAY;
//			_speedY *= DECAY;
//		}
		
		private function grid(w:int, h:int, startx:int, starty:int):void
		{
			var px:int = startx;
			var py:int = starty;
			var pheight:int = 0;
			var pwidth:int = 0;
			var firstpheight:int=0;
			var firstpy:int = 0;
			
			for (var j:int = 0; j < h; j++)
			{
				for (var i:int = 0; i < w; i++)	
				{
					var obj:Tile = AppState.getPlantImgAtCoords(i,j);
					obj.addEventListener(MouseEvent.ROLL_OVER,onTileRollOver);
					obj.addEventListener(MouseEvent.ROLL_OUT,onTileRollOut);
					obj.addEventListener(MouseEvent.CLICK,onTileClick);
					if (pheight == 0 && pwidth == 0)
					{
						obj.x = px;
						obj.y = py;
						firstpheight = obj.height;
						firstpy = obj.y;
					}
					else
					{
						obj.x = px-(obj.width / 2);
						obj.y = py+(pheight+25-obj.height);
					}
					
					px = obj.x;
					py = obj.y
					pheight = obj.height;
					pwidth = obj.width;
					trace("Draw at X:"+px.toString()+" Y:"+py.toString());
					this.addChild(obj);
				}
				px = startx+50*(j+1);
				py = firstpy+(firstpheight+25-AppState.getPlantImgAtCoords(0,j+1).height);
				pheight = 0;
				pwidth = 0;
			}
		}
	}
	
}