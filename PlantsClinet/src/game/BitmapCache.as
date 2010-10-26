package game
{	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import models.Img;
	
	public class BitmapCache
	{
		public static var mImages:Array;
		
		public function BitmapCache()
		{
		}
		
		static public function addImage(img:Img):Boolean
		{
			for each (var i:Img in BitmapCache.mImages)
			{
				if (i.plant_id == img.plant_id && i.state_id == img.state_id)
					return false;
			}
			
			BitmapCache.mImages.push(img);
			
			return true;
		}
	}
}