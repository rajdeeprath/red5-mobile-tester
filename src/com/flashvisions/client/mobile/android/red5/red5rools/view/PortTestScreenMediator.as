package com.flashvisions.client.mobile.android.red5.red5rools.view 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.Application;
	import com.flashvisions.client.mobile.android.red5.red5rools.Ports;
	import com.flashvisions.client.mobile.android.red5.red5rools.Protocols;
	import com.flashvisions.client.mobile.android.red5.red5rools.Screens;
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
			return [];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			
		}
		
		override public function onRegister():void 
		{
			this._component = this.viewComponent as PortTestScreen;
			this._component.btnRunTest.addEventListener(Event.TRIGGERED, onRunTest);
			
			
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
			
			
			this._component.list.dataProvider = collection;
			this._component.list.itemRendererProperties.labelField = 'label';
			this._component.list.itemRendererProperties.accessoryLabelField = 'status';
		}
		
		
		override public function onRemove():void 
		{
			
		}
		
		
		private function onRunTest(e:Event):void
		{
			this._component.btnRunTest.isEnabled = false;
			
			// start test here
		}
		
	}

}