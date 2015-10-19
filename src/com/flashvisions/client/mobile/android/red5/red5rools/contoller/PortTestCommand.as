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
	import flash.net.Responder;
	import flash.utils.getTimer;
	
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
	
	public class PortTestCommand extends SimpleCommand implements ICommand
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(PortTestCommand);
		}
		
		
		private var connections:Vector.<SmartConnection>;
		private static const BATCH_SIZE:uint = 2;
	
		
		
		
		/* INTERFACE org.puremvc.as3.interfaces.ICommand */
		
		override public function execute(notification:INotification):void 
		{	
			logger.info("Starting test");
			
			connections = notification.getBody() as Vector.<SmartConnection>;
			connections = connections.reverse();
		}

		
		
		
		
		
		private function initListeners(connection:SmartConnection):void
		{
			connection.addEventListener(ConnectionEvent.CONNECTION_SUCCESS, onConnectionSuccess);
			connection.addEventListener(ConnectionEvent.CONNECTION_ERROR, onConnectionError);
			connection.addEventListener(ConnectionEvent.CONNECTION_TIMEOUT, onConnectionTimeout);
			connection.addEventListener(ConnectionEvent.CONNECTION_LOST, onConnectionLost);
			connection.addEventListener(ConnectionEvent.CONNECTION_CLOSED, onConnectionClosed);
			connection.addEventListener(ConnectionEvent.CONNECTION_ABORT, onConnectionAbort);
		}
		
		
		
		
		
		
		
		
		private function deInitListeners(connection:SmartConnection):void
		{
			connection.removeEventListener (ConnectionEvent.CONNECTION_SUCCESS, onConnectionSuccess);
			connection.removeEventListener(ConnectionEvent.CONNECTION_ERROR, onConnectionError);
			connection.removeEventListener(ConnectionEvent.CONNECTION_TIMEOUT, onConnectionTimeout);
			connection.removeEventListener(ConnectionEvent.CONNECTION_LOST, onConnectionLost);
			connection.removeEventListener(ConnectionEvent.CONNECTION_CLOSED, onConnectionClosed);
			connection.removeEventListener(ConnectionEvent.CONNECTION_ABORT, onConnectionAbort);
		}
		
		
		
		private function onConnectionAbort(e:ConnectionEvent):void 
		{
			logger.info("onConnectionAbort {0}", [e.target]); 
			deInitListeners(e.target as SmartConnection);
		}
		
		
		
		
		
		private function onConnectionClosed(e:ConnectionEvent):void 
		{
			logger.info("onConnectionClosed {0}", [e.target]); 
			deInitListeners(e.target as SmartConnection);
			
			facade.sendNotification(ApplicationFacade.CONNECTION_CLOSED, e.target as SmartConnection);
		}
		
		
		
		
		
		private function onConnectionLost(e:ConnectionEvent):void 
		{
			logger.info("onConnectionLost {0}", [e.target]); 
			
			
			facade.sendNotification(ApplicationFacade.CONNECTION_LOST, e.target as SmartConnection);
		}
		
		
		
		
		
		private function onConnectionTimeout(e:ConnectionEvent):void 
		{
			logger.info("onConnectionTimeout {0}", [e.target]); 
			
			facade.sendNotification(ApplicationFacade.CONNECTION_TIMEOUT, e.target as SmartConnection);
		}
		
		
		
		
		
		private function onConnectionError(e:ConnectionEvent):void 
		{
			logger.info("onConnectionError {0}", [e.target]); 
			
			facade.sendNotification(ApplicationFacade.CONNECTION_ERROR, e.target as SmartConnection);
		}
		
		
		
		
		
		private function onConnectionSuccess(e:ConnectionEvent):void 
		{
			logger.info("onConnectionSuccess {0}", [e.target]); 
			
			facade.sendNotification(ApplicationFacade.CONNECTION_SUCCESS, e.target as SmartConnection);
		}
	}
}