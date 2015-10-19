package com.flashvisions.client.mobile.android.red5.red5rools.net
{
	
 
	public class ConnectionInfo
	{
		public var status:String;
		public var infoString:String;
		public var timestamp:Number;
		public var endpoint:String;
		
		public function ConnectionInfo(status:String = null)
		{
			this.status = status;
		}
	}
}