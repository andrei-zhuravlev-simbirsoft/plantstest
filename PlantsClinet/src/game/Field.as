/*------------------------------------------------------------
* @author: Anton Karlov (http://www.ant-karlov.ru)
* @desc: Игровая карта.
*----------------------------------------------------------*/
package game
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.*;
	import flash.utils.flash_proxy;
	
	public class Field extends Sprite
	{
		
		// Constants:
		public static const SCR_WIDTH:int = 550;
		public static const SCR_HEIGHT:int = 400;
		public static const CELL_SIZE:int = 100;
		public static const DECAY:Number = .9;
		public static const MAP_W:int = 20;
		public static const MAP_H:int = 20;
		
		// Public Properties:		
		
		
		// Private Properties:
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		
		/* Размер карты */
		private var _mapWidth:int = MAP_W * CELL_SIZE;
		private var _mapHeight:int = MAP_H * CELL_SIZE;
		
		private var _bmp:BitmapData; // Игровая сетка
		
		// Initialization:
		public function Field(field_bmp:BitmapData)
		{
			/* Создаем игровую сетку */
			this._bmp = field_bmp;
			
			grid(MAP_W, MAP_H);
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
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
		
		/*public function addParticle(ax:int, ay:int):void
		{
			/* Создание нового партикла */
		/*	var p:Particle = new Particle();
			p.x = (Math.random() * 10 - 5) + ax;
			p.y = (Math.random() * 10 - 5) + ay;
			addChild(p);
			p.addEventListener(Event.ENTER_FRAME, particleLifeHandler);
		}*/
		
		// Protected Methods:
		
		private function particleLifeHandler(e:Event):void
		{
			var mc:MovieClip = MovieClip(e.target);
			if (mc.currentFrame == mc.totalFrames)
			{
				mc.removeEventListener(Event.ENTER_FRAME, particleLifeHandler);
				removeChild(mc);
				mc = null;
			}			
		}
		
		private function enterFrameHandler(e:Event):void
		{			
			/* Прибавляем скорость к положению карты */
			x += int(_speedX);
			y += int(_speedY);
			
			/* Горизонтальная прокрутка */
			if (x > 0) // Выезд за левый край
			{
				x = 0;
				_speedX = 0;
			}
			else if (x < -_mapWidth + SCR_WIDTH) // Выезд за правый край
			{
				x = -_mapWidth + SCR_WIDTH;
				_speedX = 0;
			}
			
			/* Вертикальная прокрутка */
			if (y > 0) // Выезд за верхний край
			{
				y = 0;
				_speedY = 0;
			}
			else if (y < -_mapHeight + SCR_HEIGHT) // Выезд за нижний край
			{
				y = -_mapHeight + SCR_HEIGHT;
				_speedY = 0;
			}			
			
			/* Применяем торможение к скорости */
			_speedX *= DECAY;
			_speedY *= DECAY;
		}
		
		private function grid(w:int, h:int):void
		{
			addChild(new Bitmap(this._bmp));
		}
	}
	
}