package models
{
	public class Error
	{
		private var mId:int;
		private var mMessage:String;
		
		public function Error(id:int, msg:String)
		{
			this.mId = id;
			this.mMessage = msg;
		}
		
		public function get id():int
		{
			return this.mId;
		}
		
		public function get message():String
		{
			return this.mMessage;
		}
	}
}