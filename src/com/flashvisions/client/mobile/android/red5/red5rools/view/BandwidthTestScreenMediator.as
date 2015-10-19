package com.flashvisions.client.mobile.android.red5.red5rools.view 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.Application;
	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import com.flashvisions.client.mobile.android.red5.red5rools.model.DataProxy;
	import com.flashvisions.client.mobile.android.red5.red5rools.net.SmartConnection;
	import com.flashvisions.client.mobile.android.red5.red5rools.Screens;
	import com.flashvisions.client.mobile.android.red5.red5rools.Utils;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.events.Event;
	
	
	import com.flashvisions.client.mobile.android.red5.red5rools.model.ConnectionConfig;
	import com.flashvisions.client.mobile.android.red5.red5rools.net.ConnectionProvider;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.screens.*;
	import feathers.controls.Button;
	
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
	
	/**
	 * ...
	 * @author ...
	 */
	public class BandwidthTestScreenMediator extends Mediator implements IMediator 
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(BandwidthTestScreenMediator);
		}
		
		
		public static const NAME:String = "BandwidthTestScreenMediator";
		
		private var _component:BandwidthTestScreen;
		private var _dataProxy:DataProxy;
		private var _provider:ConnectionProvider;
		
		
		private var _connection:SmartConnection;
		
		
		public function BandwidthTestScreenMediator(viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			
		}
		
		
		
		/* INTERFACE org.puremvc.as3.interfaces.IMediator */
		

		
		override public function getMediatorName():String 
		{
			return NAME;
		}
		
		override public function getViewComponent():Object 
		{
			return this.viewComponent;
		}
		
		override public function setViewComponent(viewComponent:Object):void 
		{
			this.viewComponent = viewComponent;
		}
		
		override public function listNotificationInterests():Array 
		{
			return [ApplicationFacade.TEST_COMPLETE, ApplicationFacade.LOG, ApplicationFacade.TEST_START, ApplicationFacade.CONNECTION_SUCCESS, ApplicationFacade.CONNECTION_CLOSED, ApplicationFacade.CONNECTION_TIMEOUT, ApplicationFacade.CONNECTION_ERROR, ApplicationFacade.CONNECTION_LOST];
		}
		
		
		
		
		override public function handleNotification(notification:INotification):void 
		{
			logger.info("Notification {0} ", [notification.getName()]);
			
			switch(notification.getName())
			{
				case ApplicationFacade.CONNECTION_SUCCESS:
				_connection = notification.getBody() as SmartConnection;
				// init bw test
				facade.sendNotification(ApplicationFacade.BANDWIDTH_TEST, _connection);
				break;
				
				
				case ApplicationFacade.CONNECTION_CLOSED:
				_connection = notification.getBody() as SmartConnection;
				_connection.dispose();
				_connection = null;
				break;
				
				
				case ApplicationFacade.CONNECTION_ERROR:
				_connection = notification.getBody() as SmartConnection;
				break;
				
				
				case ApplicationFacade.CONNECTION_TIMEOUT:
				_connection = notification.getBody() as SmartConnection;
				break;
				
				
				
				case ApplicationFacade.CONNECTION_LOST:
				_connection = notification.getBody() as SmartConnection;
				break;
				
				
				
				case ApplicationFacade.TEST_START:
				_connection = notification.getBody() as SmartConnection;
				break;
				
				
				
				case ApplicationFacade.TEST_COMPLETE:
				this._component.btnRunTest.isEnabled = true;
				break;
				
				
				case ApplicationFacade.LOG:
				_component.txtOutput.text += notification.getBody() as String;
				_component.txtOutput.text += "\n\n";
				break;
			}
		}
		
		
		override public function onRegister():void 
		{
			this._dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			this._provider = this._dataProxy.connectionProvider;
			
			
			this._component = this.viewComponent as BandwidthTestScreen;
			this._component.btnRunTest.addEventListener(Event.TRIGGERED, onRunTest);
		}
		
		
		
		override public function onRemove():void 
		{
			this._component.removeEventListener(Event.TRIGGERED, onRunTest);
			
			this._provider.purgeConnections();
			
			this._dataProxy.connectionProvider.purgeConnections();
			this._dataProxy = null;
		}
		
		
		
		
		private function onRunTest(e:Event):void
		{
			this._component.btnRunTest.isEnabled = false;
			
			var config:ConnectionConfig = _component.connectionConfig;
			var url:String = Utils.getConnectionURL(config);
			var connection:SmartConnection = this._provider.newConnection();
			connection.url = url;
			
			facade.sendNotification(ApplicationFacade.CONNECTION_TEST, connection);
		}
		
	}

}