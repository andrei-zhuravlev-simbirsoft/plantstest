package models
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import models.*;
	import game.BitmapCache;
	
	public class Plant extends GameObject
	{
		public var Name:String;
		public var State:PlantState;
		
		private var mCache:BitmapCache = BitmapCache.instance;
		
		public function Plant(xml:XML=null)
		{
			super();
			
			if (xml != null)
				this.fromXML(xml);
		}
		
		public function fromXML(plant_node:XML):void
		{	
			this.Name = plant_node.localName();
			
			super.Id = plant_node.attribute("id");
			super.X = plant_node.attribute("x");
			super.Y = plant_node.attribute("y");
			
			this.State = new PlantState(plant_node.attribute("state"), super.Id); 
		}
		
		protected function checkCache(plant_id:int, state_id:int):Img
		{
			for each (var i:Img in BitmapCache.mImages)
			{
				if (i.plant_id == plant_id && i.state_id == state_id)
					return i;
			}
			
			return null;
		}
		
		public function getSprite():Img
		{
			var cached:Img = this.checkCache(AppState.getPlantIdByName(this.Name),this.State.Id);
			if (cached != null)
				return cached;
			
			return new Img(AppState.getPlantIdByName(this.Name),this.State.Id);
		}
	}
}