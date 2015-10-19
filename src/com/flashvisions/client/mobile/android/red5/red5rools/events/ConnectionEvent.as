package com.flashvisions.client.mobile.android.red5.red5rools.events
{	
	import com.flashvisions.client.mobile.android.red5.red5rools.net.ConnectionInfo;
	import flash.events.Event;
	

	public class ConnectionEvent extends Event
	{

		public static const CONNECTION_SUCCESS:String 		= "CONNECTION_SUCCESS";

		public static const CONNECTION_TIMEOUT:String 		= "CONNECTION_TIMEOUT";
		
		public static const CONNECTION_ERROR:String 		= "CONNECTION_ERROR";

		public static const CONNECTION_CLOSED:String 		= "CONNECTION_CLOSED";
		
		public static const CONNECTION_LOST:String 			= "CONNECTION_LOST";
		
		public static const CONNECTION_ASYNC_ERROR:String 	= "ASYNC_ERROR";

		public static const CONNECTION_ABORT:String 	= "CONNECTION_ABORT";
		
		
		
		/**
		 * Stores additional info on the connection event 
		 */
		public var data:ConnectionInfo = null;
		
		
		/**
		 * Constructor
		 *  
		 * @param type
		 * @param data
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function ConnectionEvent(type:String, data:ConnectionInfo = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		
		
		/**
		 * @private
		 * @return Event
		 * 
		 */		
		public override function clone():Event
		{
			return new ConnectionEvent(type, data, bubbles, cancelable);
		}
	}
}