package com.flashvisions.client.mobile.android.red5.red5rools.model 
{
	/**
	 * ...
	 * @author ...
	 */
	public class ConnectionConfig 
	{
		public var host:String;
		
		public var port:String;
		
		public var app:String;
		
		public var protocol:String;
		
		
		public function ConnectionConfig(host:String, port:String, app:String, protocol:String = "rtmp")
		{
			this.host = host;
			this.port = port;
			this.app = app;
			this.protocol = protocol;
		}
	}

}