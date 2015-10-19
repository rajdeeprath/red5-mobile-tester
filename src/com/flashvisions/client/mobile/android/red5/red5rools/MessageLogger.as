package com.flashvisions.client.mobile.android.red5.red5rools 
{
	import org.as3commons.logging.level.*;
	import org.as3commons.logging.setup.LogSetupLevel;
	import org.as3commons.logging.util.LogMessageFormatter;
	/**
	 * ...
	 * @author ...
	 */
	public class MessageLogger 
	{
		public static const DEFAULT_FORMAT: String = "--> {time} - {message}";
		private var _formatter:LogMessageFormatter;
		
		public function MessageLogger() 
		{
			_formatter = new LogMessageFormatter(DEFAULT_FORMAT);
		}
		
		public function formatMessage(message:String, parameters:Array):String
		{
			 return _formatter.format("", "", INFO, new Date().getTime(), message, parameters, "");
		}
	}

}