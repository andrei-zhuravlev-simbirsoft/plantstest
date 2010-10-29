package events
{
	import flash.events.Event;
	
	import models.Tile;
	
	public class TileSelectedEvent extends Event
	{
		public static var TYPE:String = "TileSelected";
		
		private var mTile:models.Tile;
		
		public function TileSelectedEvent(_tile:models.Tile, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(TileSelectedEvent.TYPE, bubbles, cancelable);
			
			this.mTile = _tile;
		}
		
		public function get Tile():models.Tile
		{
			return this.mTile;
		}
	}
}