package events
{
	import flash.events.Event;
	
	public class SpriteLoadedEvent extends Event
	{
		public static var TYPE:String = "SpriteLoader";
		
		// from Img
		private var mPlant_id:int;
		private var mState_id:int;
		
		public function SpriteLoadedEvent(pid:int, sid:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(SpriteLoadedEvent.TYPE, bubbles, cancelable);
			
			this.mPlant_id = pid;
			this.mState_id = sid;
		}
		
		public function get plant_id():int
		{
			return this.mPlant_id;
		}
		
		public function get state_id():int
		{
			return this.mState_id;
		}

	}
}