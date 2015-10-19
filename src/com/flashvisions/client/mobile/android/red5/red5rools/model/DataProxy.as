package com.flashvisions.client.mobile.android.red5.red5rools.model 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.MessageLogger;
	import com.flashvisions.client.mobile.android.red5.red5rools.net.ConnectionProvider;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DataProxy extends Proxy implements IProxy 
	{
		public var connectionProvider:ConnectionProvider;
		public var cookie:Cookie;
		public var messageLogger:MessageLogger;
		
		public static const NAME:String = "DataProxy";
		
		
		public function DataProxy() 
		{
			super();
		}
		
		
		
		
		/* INTERFACE org.puremvc.as3.interfaces.IProxy */
		
		
		
		override public function getProxyName():String 
		{
			return NAME;
		}
		
		
		
		
		override public function onRegister():void 
		{
			messageLogger = new MessageLogger();
			connectionProvider = new ConnectionProvider();
			cookie = new Cookie();
		}
		
		
		
		
		override public function onRemove():void 
		{
			messageLogger = null;
			
			connectionProvider.purgeConnections();
			connectionProvider = null;
			
			cookie = null;
		}
		
	}

}