package
{
	import models.Plant;

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
	}
}