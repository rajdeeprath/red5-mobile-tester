package com.flashvisions.client.mobile.android.red5.red5rools.view 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.Application;
	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import com.flashvisions.client.mobile.android.red5.red5rools.model.DataProxy;
	import com.flashvisions.client.mobile.android.red5.red5rools.Ports;
	import com.flashvisions.client.mobile.android.red5.red5rools.Protocols;
	import com.flashvisions.client.mobile.android.red5.red5rools.Screens;
	import com.flashvisions.client.mobile.android.red5.red5rools.Utils;
	import feathers.data.ListCollection;
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
	public class PortTestScreenMediator extends Mediator implements IMediator 
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(PortTestScreenMediator);
		}
		
		
		public static const NAME:String = "PortTestScreenMediator";
		
		private var _component:PortTestScreen;
		private var collection:ListCollection;
		
		private var _dataProxy:DataProxy;
		private var _provider:ConnectionProvider;
		
		private var connections:Vector.<SmartConnection>;
		
		public function PortTestScreenMediator(viewComponent:Object=null) 
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
			return [ApplicationFacade.TEST_START, ApplicationFacade.CONNECTION_SUCCESS, ApplicationFacade.CONNECTION_CLOSED, ApplicationFacade.CONNECTION_TIMEOUT, ApplicationFacade.CONNECTION_ERROR, ApplicationFacade.CONNECTION_LOST];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			var connection:SmartConnection;
			
			logger.info("Notification {0} : Data {1}", [notification.getName(), notification.getBody()]);
			
			
			switch(notification.getName())
			{
				case ApplicationFacade.CONNECTION_SUCCESS:
				case ApplicationFacade.CONNECTION_CLOSED:
				case ApplicationFacade.CONNECTION_ERROR:
				case ApplicationFacade.CONNECTION_TIMEOUT:
				case ApplicationFacade.CONNECTION_LOST:
				connection = notification.getBody() as SmartConnection;
				updateListStatus(connection, notification.getName());
				
				testNextPendingConnection();
				break;
				
				
				
				case ApplicationFacade.TEST_START:
				connection = notification.getBody() as SmartConnection;
				updateListStatus(connection, notification.getName());
				break;
			}
		}
		
		
		
		
		private function updateListStatus(connection:SmartConnection, notification:String):void
		{
			var protocol:String;
			var port:String;
				
			for (var i:uint = 0; i < this.collection.length; i++)
			{
				var obj:Object = this.collection.getItemAt(i);
				protocol = obj.protocol;
				port = obj.port;
				
				
				
				if (connection.port == port && connection.protocol == protocol)
				{
					var status:String;
					
					
					switch(notification)
					{
						case ApplicationFacade.CONNECTION_SUCCESS:
						status = "SUCCESS";
						break;


						case ApplicationFacade.CONNECTION_CLOSED:
						if(connection.wasConnected)
						status = "INTERRUPTED";
						break;


						case ApplicationFacade.CONNECTION_ERROR:
						status = "ERROR";
						break;


						case ApplicationFacade.CONNECTION_TIMEOUT:
						status = "TIMEOUT";
						break;



						case ApplicationFacade.TEST_START:
						status = "CONNECTING";
						break;
					}
					
					
					this.collection.getItemAt(i).status = status;
					this.collection.updateItemAt(i);
				}
			}
		}
		
		
		
		
		override public function onRegister():void 
		{
			this._component = this.viewComponent as PortTestScreen;
			this._component.btnRunTest.addEventListener(Event.TRIGGERED, onRunTest);
			
			
			this._dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			this._provider = this._dataProxy.connectionProvider;
			
			
			// init data
			this.collection = new ListCollection();
			
			collection.addItem( { 'label': 'RTMP @ Default	', 'status': 'UNKNOWN', 'port': Ports._default, 'protocol': Protocols.RTMP});
			collection.addItem( { 'label': 'RTMP @ 1935		' , 'status': 'UNKNOWN', 'port': Ports._1935, 'protocol': Protocols.RTMP } );
			collection.addItem( { 'label': 'RTMP @ 443		' , 'status': 'UNKNOWN', 'port': Ports._443, 'protocol': Protocols.RTMP } );
			collection.addItem( { 'label': 'RTMP @ 80		' , 'status': 'UNKNOWN', 'port': Ports._80, 'protocol': Protocols.RTMP } );
			collection.addItem( { 'label': 'RTMP @ 8080		' , 'status': 'UNKNOWN', 'port': Ports._8080, 'protocol': Protocols.RTMP } );
			collection.addItem( { 'label': 'RTMPT @ Default	' , 'status': 'UNKNOWN', 'port': Ports._default, 'protocol': Protocols.RTMPT } );
			collection.addItem( { 'label': 'RTMPT @ 1935	' , 'status': 'UNKNOWN', 'port': Ports._1935, 'protocol': Protocols.RTMPT } );
			collection.addItem( { 'label': 'RTMPT @ 443		' , 'status': 'UNKNOWN', 'port': Ports._443, 'protocol': Protocols.RTMPT } );
			collection.addItem( { 'label': 'RTMPT @ 80		' , 'status': 'UNKNOWN', 'port': Ports._80, 'protocol': Protocols.RTMPT } );
			collection.addItem( { 'label': 'RTMPT @ 8080	' , 'status': 'UNKNOWN', 'port': Ports._8080, 'protocol': Protocols.RTMPT } );
			collection.addItem( { 'label': 'RTMPT @ 5080	' , 'status': 'UNKNOWN', 'port': Ports._5080, 'protocol': Protocols.RTMPT } );
			
			
			this.connections = new Vector.<SmartConnection>();
			
			this._component.list.dataProvider = collection;
			this._component.list.itemRendererProperties.labelField = 'label';
			this._component.list.itemRendererProperties.accessoryLabelField = 'status';
		}
		
		
		override public function onRemove():void 
		{
			this._component.btnRunTest.removeEventListener(Event.TRIGGERED, onRunTest);
			
			this.connections.length = 0;
			
			this.collection.removeAll();
			this.collection = null;
			
			this._provider.purgeConnections();
		}
		
		
		private function onRunTest(e:Event):void
		{
			this._component.btnRunTest.isEnabled = false;
			this.connections = buildConnections();
			this.testNextPendingConnection();
		}
		
		
		
		private function testNextPendingConnection():void
		{
			if (this.connections.length > 0)
			{
				var connection:SmartConnection = this.connections.pop();
				facade.sendNotification(ApplicationFacade.PORT_TEST, connection);
			}
			else 
			{
				logger.info("No more connections to test");	
			}
		}
		
		
		
		private function buildConnections():Vector.<SmartConnection>
		{
			var config:ConnectionConfig = _component.connectionConfig;
			var connections:Vector.<SmartConnection> = new Vector.<SmartConnection>();
			
			for (var i:uint = 0; i < this.collection.length; i++)
			{
				var obj:Object = this.collection.getItemAt(i);
				var connection:SmartConnection = this._provider.newConnection();
				
				config.protocol = obj.protocol;
				config.port = obj.port;
				
				connection.url = Utils.getConnectionURL(config);
				logger.info("building connection for : ", [connection.url]);
				
				connections.push(connection);
			}
			
			
			return connections.reverse();
		}
		
	}

}