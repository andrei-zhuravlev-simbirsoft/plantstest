package
{
	import models.Img;
	import models.Plant;
	import models.Tile;

	public class AppState
	{
		public static var herbarium:Array = new Array(); // All available plant types
		public static var field:Array = new Array(); // field data
		public static var states:Array = new Array(); // plant grow states
		
		public function AppState()
		{
		}
		
		public static function getPlantIdByName(name:String):int
		{
			for each (var p:Plant in AppState.herbarium)
			{
				if (p.Name == name)
					return p.Id;
			}
			
			return -1;
		}
		
		/***
		 * This methods force loading sprites for all Plants on current field
		 **/
		public static function getSpritesForPlants():void
		{
			for each (var h:Plant in AppState.field)
			{
				h.getSprite();
			}
		}
		
		/***
		 * returns tile object located in grid(x,y)
		 * */
		public static function getPlantImgAtCoords(x:int, y:int):Tile
		{
			for each (var p:Plant in AppState.field)
			{
				if (p.X == x && p.Y == y)
				{
					//trace("PLANT - X:"+x.toString()+" Y:"+y.toString());
					return new Tile(x,y,p.getSprite(),true);
				}
			}
			//trace("HOLDER - X:"+x.toString()+" Y:"+y.toString());
			return new Tile(x,y,new Img(),false);
		}
	}
}