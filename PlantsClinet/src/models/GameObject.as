package models
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	

	public class GameObject //extends MovieClip
	{
		public var Id:int;
		public var X:int;
		public var Y:int;
		
		public var Image:Bitmap;
		
		public function GameObject()
		{
		}
		
		public function setImage(bmp:Bitmap):void
		{
			
		}
		
		public function getBitmapData():BitmapData
		{
			return null;
		}
	}
}