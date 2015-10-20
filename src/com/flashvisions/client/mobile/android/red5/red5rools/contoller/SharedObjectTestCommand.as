package com.flashvisions.client.mobile.android.red5.red5rools.contoller
{

	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import com.flashvisions.client.mobile.android.red5.red5rools.events.ConnectionEvent;
	import com.flashvisions.client.mobile.android.red5.red5rools.MessageLogger;
	import com.flashvisions.client.mobile.android.red5.red5rools.model.ConnectionConfig;
	import com.flashvisions.client.mobile.android.red5.red5rools.model.DataProxy;
	import com.flashvisions.client.mobile.android.red5.red5rools.net.ConnectionProvider;
	import com.flashvisions.client.mobile.android.red5.red5rools.net.SmartConnection;
	import com.flashvisions.client.mobile.android.red5.red5rools.Utils;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;
	import flash.net.Responder;
	import flash.net.SharedObject;
	import flash.utils.getTimer;
	import org.red5.flash.bwcheck.BWCheckType;
	import org.red5.flash.bwcheck.ClientServerBandwidth;
	import org.red5.flash.bwcheck.events.BandwidthDetectEvent;
	import org.red5.flash.bwcheck.interfaces.IConnectionCheck;
	import org.red5.flash.bwcheck.ServerClientBandwidth;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	
	CONFIG::LOGGING
	{
		import org.as3commons.logging.setup.LevelTargetSetup;
		import org.as3commons.logging.setup.LogSetupLevel;
	
	
		import org.as3commons.logging.api.ILogger;
		import org.as3commons.logging.api.LOGGER_FACTORY;
		import org.as3commons.logging.api.LoggerFactory;
		import org.as3commons.logging.api.getLogger;
		import org.as3commons.logging.setup.SimpleTargetSetup;
	}
	
	public dynamic class SharedObjectTestCommand extends SimpleCommand implements ICommand
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(SharedObjectTestCommand);
		}
		
		
		private var messsageLogger:MessageLogger;
		private var connection:SmartConnection;
		
		private var so:SharedObject;
		private var soName:String;
		private var handler:String;
		
		
		/* INTERFACE org.puremvc.as3.interfaces.ICommand */
		
		override public function execute(notification:INotification):void 
		{	
			logger.info("Starting soTest");
			
			
			var dataProxy:DataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			var testData:Object = notification.getBody() as Object;
			
			connection = testData.connection as SmartConnection;
			soName = testData.soname;
			handler = testData.handler;
			
			messsageLogger = dataProxy.messageLogger;
			initListeners(connection);
			
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage("Initializing SharedObject {0} for {1}", [soName, connection.url]));
			initSharedObject(connection);
			
			
			this[handler] = function(message:String):void {
			logger.info("receiving data {0} on method {1}", [message, handler]); 
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage("SharedObject Data Received {0} for {1}", [message, soName]));
			}
		}
		
		
		
		
		private function initSharedObject(connection:SmartConnection):void
		{
			so = SharedObject.getRemote(soName, connection.url);
			initSoListeners(so);
			
			so.client = this;
			so.connect(connection.netconnection);
		}
		
		
		
		
		private function initSoListeners(so:SharedObject):void
		{
			so.addEventListener(NetStatusEvent.NET_STATUS, onSoNetStatus);
			so.addEventListener(SyncEvent.SYNC, onSoSync);
			so.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onSoAsyncError);
		}
		

		
		
		private function deInitSoListeners(so:SharedObject):void
		{
			if(so.hasEventListener(NetStatusEvent.NET_STATUS))
			so.removeEventListener(NetStatusEvent.NET_STATUS, onSoNetStatus);
			
			if(so.hasEventListener(SyncEvent.SYNC))
			so.removeEventListener(SyncEvent.SYNC, onSoSync);
			
			if(so.hasEventListener(AsyncErrorEvent.ASYNC_ERROR))
			so.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onSoAsyncError);
		}
		
		
		
		
		private function initListeners(connection:SmartConnection):void
		{
			connection.addEventListener(ConnectionEvent.CONNECTION_CLOSED, onConnectionClosed);
			connection.addEventListener(ConnectionEvent.CONNECTION_DISPOSE, onConnectionDispose);
		}
		
		
		
		
		
		private function deInitListeners(connection:SmartConnection):void
		{				
			if(connection.hasEventListener(ConnectionEvent.CONNECTION_CLOSED))
			connection.removeEventListener(ConnectionEvent.CONNECTION_CLOSED, onConnectionClosed);
						
			if(connection.hasEventListener(ConnectionEvent.CONNECTION_DISPOSE))
			connection.removeEventListener(ConnectionEvent.CONNECTION_DISPOSE, onConnectionDispose);
		}
		
		
		
		
		
		private function onConnectionDispose(e:ConnectionEvent):void 
		{
			logger.info("onConnectionDispose {0}", [e.target]); 
			
			deInitListeners(e.target as SmartConnection);
			
			so.close();
			deInitSoListeners(so);
		}
		

		
		
		private function onConnectionClosed(e:ConnectionEvent):void 
		{
			logger.info("onConnectionClosed {0}", [e.target]); 
			
			so.close();
			deInitSoListeners(so);
		}
		
		
		
		
		private function onSoAsyncError(e:AsyncErrorEvent):void 
		{
			logger.info("onSoAsyncError {0}", [e.target]); 
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage("SharedObject Async error {0} for {1}", [e.text, soName]));
		}
		
		
		
		
		
		private function onSoSync(e:SyncEvent):void 
		{
			logger.info("onSoSync {0}", [e.target]); 
			facade.sendNotification(ApplicationFacade.SHARED_OBJECT, e.target as SharedObject);
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage("SharedObject Sync type {0} for {1}", [e.type, soName]));
		}
		
		
		
		
		
		private function onSoNetStatus(e:NetStatusEvent):void 
		{
			logger.info("onSoNetStatus {0} code {1}", [e.target, e.info.code]); 
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage("SharedObject NetStatus {0} for {1}", [e.info.code, soName]));
		}
		
	}
}