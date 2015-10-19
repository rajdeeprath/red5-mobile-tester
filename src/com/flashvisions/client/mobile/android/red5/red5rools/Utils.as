package com.flashvisions.client.mobile.android.red5.red5rools 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.model.ConnectionConfig;
	/**
	 * ...
	 * @author ...
	 */
	public class Utils 
	{
		
		public function Utils() 
		{
			
		}
		
		
		public static function getConnectionURL(config:ConnectionConfig):String
		{
			var url:String = null;
			
			
			if(config.port == "" || config.port == null)
			url = config.protocol + "://" + config.host + "/" + config.app;
			else
			url = config.protocol + "://" + config.host + ":" + config.port + "/" + config.app;
			
			return url;
		}
		
	}

}