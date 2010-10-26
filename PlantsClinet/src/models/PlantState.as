package models
{
	import flash.display.Bitmap;

	public class PlantState
	{
		public var Id:int;
		public var Name:String;
		public var Level:int;
		public var PlantId:int;
		//public var Image:Bitmap;
		
		public function PlantState(state_id:int, plant_id:int, name:String="not set", level:int=1)
		{
			if (state_id == 0)
				state_id = -1;
			
			this.Id = state_id;
			this.Name = name;
			this.Level = level;
			this.PlantId = plant_id;
		}
	}
}