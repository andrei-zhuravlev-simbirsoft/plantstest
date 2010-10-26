package utils
{	
	import flash.net.URLRequest;
	
	public class URLBroker
	{	
		private var mCommand:String = "";
		private var mParams:Array = null;
		
		public function URLBroker(command:String = null, params:Array = null)
		{
			this.mCommand = command;
			this.mParams = params;
		}
		
		public function getURL(cmd:String = null,par:Array = null):String
		{
			var command:String;
			var params:Array;
			
			if (cmd != null)
				command = cmd;
			else
				command = this.mCommand;
			
			if (par != null)
				params = par
			else
				params = this.mParams;
			
			if (command == "")
				return Config.Server + "/";
			else if (command != "" && params == null)
				return Config.Server + "/" + command;
			else if (params == null || params.length == 0)
				return null;
			else
			{
				var url:String = Config.Server + "/" + command;
				for each (var param:String in params)
				{
					url += "/" + param;
				}
			}
			return url;
		}
		
		public function getURLRequest(cmd:String = null,par:Array = null):URLRequest
		{
			return new URLRequest(this.getURL(cmd,par));
		}
	}
}