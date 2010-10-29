package models
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import models.*;
	import game.BitmapCache;
	import events.SpriteLoadedEvent;
	
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
		
		public function getSprite():Img
		{
			var cached:Img = mCache.checkCache(AppState.getPlantIdByName(this.Name),this.State.Id);
			if (cached != null)
			{
				return cached;
			}
			
			return new Img(AppState.getPlantIdByName(this.Name),this.State.Id);
		}
	}
}