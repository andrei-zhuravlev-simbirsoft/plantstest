package models
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import models.*;
	
	public class Plant extends GameObject
	{
		public var Name:String;
		public var State:PlantState;
		
		public function Plant(xml:XML=null)
		{
			super();
			
			if (xml != null)
				this.fromXML(xml);
		}
		
		public function fromXML(plant_node:XML):void
		{	
			this.Name = plant_node.localName();
			this.State = new PlantState(); //TODO: to be implemented
			
			super.Id = plant_node.attribute("id");
			super.X = plant_node.attribute("x");
			super.Y = plant_node.attribute("y");
		}
		
		public function getSprite():Img
		{
			return new Img(AppState.getPlantIdByName(this.Name),this.State.Id);
		}
	}
}