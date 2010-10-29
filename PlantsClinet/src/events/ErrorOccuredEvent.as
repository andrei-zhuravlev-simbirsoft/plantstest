package events
{
	import flash.events.Event;
	
	import models.Error;
	
	public class ErrorOccuredEvent extends Event
	{
		public static var TYPE:String = "ErrorOccured";
		
		private var mError:models.Error;
		
		public function ErrorOccuredEvent(err:models.Error, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(ErrorOccuredEvent.TYPE, bubbles, cancelable);
			
			this.mError = err;
		}
		
		public function get error():models.Error
		{
			return this.mError;
		}
	}
}