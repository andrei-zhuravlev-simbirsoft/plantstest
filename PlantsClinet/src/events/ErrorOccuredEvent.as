package events
{
	import flash.events.Event;
	
	public class ErrorOccuredEvent extends Event
	{
		public static var TYPE:String = "ErrorOccured";
		
		private var mId:int;
		private var mMessage:String;
		
		public function ErrorOccuredEvent(id:int, msg:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(ErrorOccuredEvent.TYPE, bubbles, cancelable);
			
			this.mId = id;
			this.mMessage = msg;
		}
		
		public function get Id():int
		{
			return this.mId;
		}
		
		public function get Message():String
		{
			return this.mMessage;
		}
		
	}
}