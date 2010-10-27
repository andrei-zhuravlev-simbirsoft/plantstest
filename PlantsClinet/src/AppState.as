package
{
	import models.Plant;
	import models.Img;

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
	}
}