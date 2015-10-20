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
	
	public class BandwidthTestCommand extends SimpleCommand implements ICommand
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(BandwidthTestCommand);
		}
		
		
		private var messsageLogger:MessageLogger;
		private var connection:SmartConnection;
		
		private var checks:Vector.<IConnectionCheck>;
		
		
		/* INTERFACE org.puremvc.as3.interfaces.ICommand */
		
		override public function execute(notification:INotification):void 
		{	
			logger.info("Starting bwtest");
			
			
			var dataProxy:DataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			connection = notification.getBody() as SmartConnection;
			
			checks = new Vector.<IConnectionCheck>();
			messsageLogger = dataProxy.messageLogger;
			initListeners(connection);
			
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage("Initializing BWCHECK for {0}", [connection.url]));
			doUploadCheck();
		}

		
		
		
		private function doUploadCheck():void
		{
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage("Initializing upload test for {0}", [connection.url]));
			
			var check:IConnectionCheck = new ClientServerBandwidth();
			checks.push(check);
			
			check.connection = connection.netconnection;
			initCheckListeners(check);
			
			check.start();
		}
		
		
		
		
		private function doDownloadCheck():void
		{
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage("Initializing download test for {0}", [connection.url]));
			
			var check:IConnectionCheck = new ServerClientBandwidth();
			checks.push(check);
			
			check.connection = connection.netconnection;
			initCheckListeners(check);
			
			check.start();
		}
		
		
		
		
		private function initCheckListeners(check:IConnectionCheck):void
		{
			check.addEventListener(BandwidthDetectEvent.DETECT_STATUS, onBwCheckStatus);
			check.addEventListener(BandwidthDetectEvent.DETECT_COMPLETE, onBwCheckComplete);
			check.addEventListener(BandwidthDetectEvent.DETECT_FAILED, onBwCheckFailed);
		}
		
		
		
		
		private function deInitCheckListeners(check:IConnectionCheck):void
		{
			if(check.hasEventListener(BandwidthDetectEvent.DETECT_STATUS))
			check.removeEventListener(BandwidthDetectEvent.DETECT_STATUS, onBwCheckStatus);
			
			if(check.hasEventListener(BandwidthDetectEvent.DETECT_COMPLETE))
			check.removeEventListener(BandwidthDetectEvent.DETECT_COMPLETE, onBwCheckComplete);
			
			if(check.hasEventListener(BandwidthDetectEvent.DETECT_FAILED))
			check.removeEventListener(BandwidthDetectEvent.DETECT_FAILED, onBwCheckFailed);
		}
		
		
		
		
		
		private function onBwCheckFailed(e:BandwidthDetectEvent):void 
		{
			var check:IConnectionCheck = e.target as IConnectionCheck;
			var type:String = (check.type == BWCheckType.CLIENT_SERVER)?"UPLOAD":"DOWNLOAD";
			
			logger.info("onBwCheckFailed {0}", [JSON.stringify(e.info)]);
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage(type + " Check failed for {0}", [connection.url]));
			
			deInitCheckListeners(check);
		}
		
		
		
		
		
		private function onBwCheckComplete(e:BandwidthDetectEvent):void 
		{
			var check:IConnectionCheck = e.target as IConnectionCheck;
			var type:String = (check.type == BWCheckType.CLIENT_SERVER)?"UPLOAD":"DOWNLOAD";
			
			logger.info("onBwCheckComplete {0}", [JSON.stringify(e.info)]);
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage(type + " BWCheck complete {0}", [JSON.stringify(e.info)]));
			
			deInitCheckListeners(check);
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage(type + "=================================================", []));
			
			if (check.type == BWCheckType.CLIENT_SERVER) 
			{
				logger.info("client server complete");
				doDownloadCheck();
			}
			else
			{
				logger.info("server client complete");
				
				cleanUpUsedChecks();
				facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage("TEST COMPLETE", []));
				facade.sendNotification(ApplicationFacade.TEST_COMPLETE);
			}
		}
		
		
		
		
		
		private function onBwCheckStatus(e:BandwidthDetectEvent):void 
		{
			var check:IConnectionCheck = e.target as IConnectionCheck;
			var type:String = (check.type == BWCheckType.CLIENT_SERVER)?"UPLOAD":"DOWNLOAD";
			
			logger.info("onBwCheckStatus {0}", [JSON.stringify(e.info)]);
			facade.sendNotification(ApplicationFacade.LOG, messsageLogger.formatMessage(type + " BWCheck status {0}", [JSON.stringify(e.info)]));
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
		
		
		
		
		
		private function cleanUpUsedChecks():void
		{
			for (var i:uint = 0; i < checks.length; i++)
			{
				var index:uint = i;
				var check:IConnectionCheck = checks[index] as IConnectionCheck;
				
				checks.splice(index, 1);
				i--;
				
				try
				{
					deInitCheckListeners(check);
					check = null;
				}
				catch(e:Error)
				{
					CONFIG::LOGGING
					{
						logger.warn("Problem disposing checks " + checks + " " + e.message);
					}
				}
			}
			
			checks.length = 0;
		}
		
		
		
		
		
		private function onConnectionDispose(e:ConnectionEvent):void 
		{
			logger.info("onConnectionDispose {0}", [e.target]); 
			deInitListeners(e.target as SmartConnection);
			
			cleanUpUsedChecks();
		}
		

		
		
		private function onConnectionClosed(e:ConnectionEvent):void 
		{
			logger.info("onConnectionClosed {0}", [e.target]); 
		}
		
		
	}
}