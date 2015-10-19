package com.flashvisions.client.mobile.android.red5.red5rools.net
{
	public final class NetConnectionCodes
	{
		/** 
		 * "status"	The connection was closed successfully.	
		 */
		public static const CONNECT_CLOSED:String = "NetConnection.Connect.Closed"; 	
		
		/**			
		 * "error"	The connection attempt failed.
		 */ 
		public static const CONNECT_FAILED:String = "NetConnection.Connect.Failed"		
		
		/**
		 * "status"	The connection attempt succeeded.
		 */ 
		public static const CONNECT_SUCCESS:String = "NetConnection.Connect.Success";		
		
		/**
		 * "error"	The connection attempt did not have permission to access the application.			
		 */
		public static const CONNECT_REJECTED:String = "NetConnection.Connect.Rejected";		
				
		/** 
		 * "error"	The application name specified during connect is invalid.
		 */
		public static const CONNECT_INVALIDAPP:String = "NetConnection.Connect.InvalidApp";	

		/** 
		 * "error"	The connection has been idle for too long.
		 */
		
		public static const CONNECT_IDLE_TIME_OUT:String = "NetConnection.Connect.IdleTimeOut";
		
		
		
		
		/** 
		 * "error"	The connection timedout before getting connected
		 */
		public static const CONNECT_TIME_OUT:String = "NetConnection.Connect.TimeOut";
		
		
		
		
		public static const CONNECT_IO_ERROR:String = "NetConnection.Connect.IOError";
		
		
		
		
		public static const CONNECT_ASYNC_ERROR:String = "NetConnection.Connect.AsyncError";
		
		
		
		
		public static const CONNECT_SECURITY_ERROR:String = "NetConnection.Connect.SecurityError";
		
		
		
		public static const CONNECT_DISPOSE:String = "NetConnection.Dispose";
	}
}