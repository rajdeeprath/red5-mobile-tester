package com.flashvisions.client.mobile.android.red5.red5rools.view 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.Application;
	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import com.flashvisions.client.mobile.android.red5.red5rools.model.Cookie;
	import com.flashvisions.client.mobile.android.red5.red5rools.model.DataProxy;
	import com.flashvisions.client.mobile.android.red5.red5rools.Screens;
	import com.flashvisions.client.mobile.android.red5.red5rools.Utils;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.events.Event;
	
	
	import com.flashvisions.client.mobile.android.red5.red5rools.model.ConnectionConfig;
	import com.flashvisions.client.mobile.android.red5.red5rools.net.ConnectionProvider;
	import com.flashvisions.client.mobile.android.red5.red5rools.net.SmartConnection;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.screens.*;
	import feathers.controls.Button;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.motion.Fade;
	import feathers.motion.Slide;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.MetalWorksMobileTheme;
	
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
	public class ConnectionTestScreenMediator extends Mediator implements IMediator 
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(ConnectionTestScreenMediator);
		}
		
		
		public static const NAME:String = "ConnectionTestScreenMediator";
		
		private var _component:ConnectionTestScreen;
		private var _connection:SmartConnection;
		
		private var _dataProxy:DataProxy;
		private var _provider:ConnectionProvider;
		
		
		public function ConnectionTestScreenMediator(viewComponent:Object=null) 
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
			return [ApplicationFacade.LOG, ApplicationFacade.TEST_START, ApplicationFacade.CONNECTION_SUCCESS, ApplicationFacade.CONNECTION_CLOSED, ApplicationFacade.CONNECTION_TIMEOUT, ApplicationFacade.CONNECTION_ERROR, ApplicationFacade.CONNECTION_LOST];
		}
		
		
		
		
		override public function handleNotification(notification:INotification):void 
		{
			switch(notification.getName())
			{
				case ApplicationFacade.CONNECTION_SUCCESS:
				_connection = notification.getBody() as SmartConnection;
				_component.btnTestConnection.label = "DISCONNECT";
				break;
				
				
				case ApplicationFacade.CONNECTION_CLOSED:
				_connection = notification.getBody() as SmartConnection;
				_connection.dispose();
				_connection = null;
				
				_component.btnTestConnection.label = "CONNECT";
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
				
				
				
				case ApplicationFacade.LOG:
				_component.txtOutput.text += notification.getBody() as String;
				_component.txtOutput.text += "\n\n";
				
				_component.txtOutput.validate();
				_component.txtOutput.scrollToPosition(0, _component.txtOutput.maxVerticalScrollPosition, 0.2);
				break;
			}
		}
		
		
		
		
		override public function onRegister():void 
		{
			this._component = this.viewComponent as ConnectionTestScreen;
			this._component.btnTestConnection.addEventListener(Event.TRIGGERED, onRunTest);
			this._component.btnTestConnection.isToggle = false;
			
			this._dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			this._provider = this._dataProxy.connectionProvider;
		}
		
		
		
		
		override public function onRemove():void 
		{
			this._component.btnTestConnection.removeEventListener(Event.TRIGGERED, onRunTest);
			this._provider.purgeConnections();
			
			this._connection = null;
			
			this._dataProxy.connectionProvider.purgeConnections();
			this._dataProxy = null;
		}
		
		
		
		
		private function onRunTest(e:Event):void
		{
			var config:ConnectionConfig = _component.connectionConfig;
			
			
			if (_connection && _connection.isConnected)
			{
				_connection.close();
			}
			
			else
			{
				var url:String = Utils.getConnectionURL(config);
				var connection:SmartConnection = this._provider.newConnection();
				
				connection.url = url;
				facade.sendNotification(ApplicationFacade.CONNECTION_TEST, connection);
			}
		}
		
	}

}