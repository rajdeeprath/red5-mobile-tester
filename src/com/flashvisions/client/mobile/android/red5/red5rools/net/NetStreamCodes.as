package com.flashvisions.client.mobile.android.red5.red5rools.net
{
	public final class NetStreamCodes
	{
		
		/**	
		 * Actual stream data being received on the subscribing stream object
		 */
		public static const NETSTREAM_INFO_DATA:String	  		= "NetStream.Info.Data";
		
		
		
		/**	
		 * Actual stream data not being received on the subscribing stream object
		 */
		public static const NETSTREAM_INFO_NO_DATA:String	  		= "NetStream.Info.No.Data";
		
		
		
		/**	
		 * "status"	
		 * Data is not being received quickly enough to fill the buffer.
		 */
		
		public static const NETSTREAM_BUFFER_EMPTY:String	  		= "NetStream.Buffer.Empty";
		
		
		/**	
		 * "status"	
		 * Improper stream name or stream name already in use
		 */
		
		public static const NETSTREAM_BADNAME:String	  			= "NetStream.Publish.BadName";
		
		
		/**	
		 * "status"	
		 * stream not publishing for long time  / publisher is not transmitting
		 */
		
		public static const NETSTREAM_PUBLISH_IDLE:String	  		= "NetStream.Publish.Idle";
		
		
		/**	
		 * "status"	
		 * stream is publishing / transmitting data
		 */
		
		public static const NETSTREAM_PUBLISH:String	  			= "NetStream.Publish.Start";
		
		
		/**	
		 * "status"	
		 * stream is stopped publishing / transmitting data
		 */
		public static const NETSTREAM_UNPUBLISH:String	  			= "NetStream.Unpublish.Success";
		
		
		
		/**	
		 * "status"	
		 * The buffer is full and the stream will begin playing.
		 */ 
		public static const NETSTREAM_BUFFER_FULL:String 			= "NetStream.Buffer.Full";
		
		/** 
		 * "status"	
		 * Data has finished streaming, and the remaining buffer will be emptied.
		 */
		public static const NETSTREAM_BUFFER_FLUSH:String 			= "NetStream.Buffer.Flush";
		
		
		/** 
		 * "error"	
		 */
		public static const NETSTREAM_FAILED:String 				= "NetStream.Failed"; 
		
		/** 
		 * "status"
		 * 	Playback has started
		 */
		public static const NETSTREAM_PLAY_START:String				= "NetStream.Play.Start";
		
		/** 
		 * "status"
		 * 	Playback has stopped.
		 */
		public static const NETSTREAM_PLAY_STOP:String				= "NetStream.Play.Stop";
		
		
		/** "error"	An error has occurred in playback for a reason 
		 *  playback error
		 */
		public static const NETSTREAM_PLAY_FAILED:String			= "NetStream.Play.Failed";
		
		
		/** 
		 * "error"	
		 * The stream passed to the play() method can't be found.  
		 */
		public static const NETSTREAM_PLAY_STREAMNOTFOUND:String	= "NetStream.Play.StreamNotFound";
		
		
		
		/** 
		 * "status"	
		 */ 
		public static const NETSTREAM_PLAY_RESET:String				= "NetStream.Play.Reset";
		
		
		/** 
		 * "warning"	
		 * The client does not have sufficient bandwidth to play the data.
		 */
		public static const NETSTREAM_PLAY_INSUFFICIENTBW:String	= "NetStream.Play.InsufficientBW";
		
		
		/** 
		 * "status"	
		 * The stream is paused.
		 */
		public static const NETSTREAM_PAUSE_NOTIFY:String			= "NetStream.Pause.Notify"; 

		/** 
		 * "status"	
		 * The initial publish to a stream is sent to all subscribers.
		 */
		public static const NETSTREAM_PLAY_PUBLISH_NOTIFY:String	= "NetStream.Play.PublishNotify"; 

		/** 
		 * "status"	
		 * An unpublish from a stream is sent to all subscribers.
		 */
		public static const NETSTREAM_PLAY_UNPUBLISH_NOTIFY:String	= "NetStream.Play.UnpublishNotify"; 
		
		/** 
		 * "status"	
		 * The stream is resumed.
		 */
		public static const NETSTREAM_UNPAUSE_NOTIFY:String			= "NetStream.Unpause.Notify";
	}
}