package models
{
	import flash.display.Sprite;
	
	public class Tile extends Sprite
	{
		public var X:int;
		public var Y:int;
		public var hasPlant:Boolean;
		public var sprite:Img;
		
		public function Tile(x:int, y:int, sprite:Img, hasPlant:Boolean = false)
		{
			super();
			
			this.X = x;
			this.Y = y;
			this.hasPlant = hasPlant;
			this.sprite = sprite;
			
			if (this.hasPlant)
				this.addChild(sprite.getBitmap());//0xffffffff));
			else
			{
				sprite.graphics.clear();
				sprite.drawPlaceholder(100,50,0,0.5);
				this.addChild(sprite);
			}
		}
		
		public function selected():void
		{
			if (this.hasPlant)
			{
				
			}
			else
			{
				this.removeChildAt(0);
				sprite.graphics.clear();
				sprite.drawPlaceholder(100,50,0,0.8);
				this.addChild(sprite);
			}
		}
		
		public function deselected():void
		{
			if (this.hasPlant)
			{
				
			}
			else
			{	this.removeChildAt(0);
				sprite.graphics.clear();
				sprite.drawPlaceholder(100,50,0,0.5);
				this.addChild(sprite);
			}			
		}
	}
}