package com.flashvisions.client.mobile.android.red5.red5rools.view 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.Application;
	import com.flashvisions.client.mobile.android.red5.red5rools.model.Cookie;
	import com.flashvisions.client.mobile.android.red5.red5rools.model.DataProxy;
	import com.flashvisions.client.mobile.android.red5.red5rools.Screens;
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
	public class ApplicationMediator extends Mediator implements IMediator 
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(ApplicationMediator);
		}
		
		
		public static const NAME:String = "ApplicationMediator";
		
		public var _navigator:StackScreenNavigator;
		
		public var _homeScreenItem:StackScreenNavigatorItem;
		public var _connectionTestScreen:StackScreenNavigatorItem;
		public var _portTestScreen:StackScreenNavigatorItem;
		public var _bwTestScreen:StackScreenNavigatorItem;
		public var _soTestScreen:StackScreenNavigatorItem;
		
		
		private var _component:Application;
		
		
		private var _cookie:Cookie;
		
		private var _dataProxy:DataProxy;
		
		
		
		
		public function ApplicationMediator(viewComponent:Object=null) 
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
			this._component = this.viewComponent as Application;
			
			this._dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			this._cookie = this._dataProxy.cookie;
			
			
			this.createChildren();
		}
		
		override public function onRemove():void 
		{
			
		}
		
		
		
		protected function createChildren():void
		{
			new MetalWorksMobileTheme();
			
			
			_navigator = new StackScreenNavigator();
			_navigator.pushTransition = Slide.createSlideLeftTransition();
			_navigator.popTransition = Slide.createSlideRightTransition();
			_component.addChild(_navigator);

			
			_homeScreenItem = new StackScreenNavigatorItem(HomeScreen);
			_homeScreenItem.setFunctionForPushEvent(Event.SELECT, home_optionSelectHandler);
			_navigator.addScreen(Screens.HOME, _homeScreenItem);
			
			
			_connectionTestScreen = new StackScreenNavigatorItem(ConnectionTestScreen); 
			_connectionTestScreen.addPopEvent(Event.COMPLETE);
			_navigator.addScreen(Screens.CONNECTION_TEST, _connectionTestScreen);
			
			
			_portTestScreen = new StackScreenNavigatorItem(PortTestScreen);
			_portTestScreen.addPopEvent(Event.COMPLETE);
			_navigator.addScreen(Screens.PORT_TEST, _portTestScreen);
			
			
			_bwTestScreen = new StackScreenNavigatorItem(BandwidthTestScreen);
			_bwTestScreen.addPopEvent(Event.COMPLETE);
			_navigator.addScreen(Screens.BANDWIDTH_TEST, _bwTestScreen);
			
			
			_soTestScreen = new StackScreenNavigatorItem(SharedObjectTestScreen);
			_soTestScreen.addPopEvent(Event.COMPLETE);
			_navigator.addScreen(Screens.SO_TEST, _soTestScreen);
			
			
			_navigator.rootScreenID = Screens.HOME;
		}
		
		
		
		
		
		private function home_optionSelectHandler(e:Event, data:Object):void 
		{
			logger.info("test selected {0} with settings {1}", [e.type, JSON.stringify(data)]);
			
			var screen:String = data.screen;
			var navItem:StackScreenNavigatorItem = null;
			var config:ConnectionConfig = new ConnectionConfig(data.host, data.port, data.app);
			
			this._cookie.host = config.host;
			this._cookie.port = config.port;
			this._cookie.app = config.app;
			this._cookie.save();
			
			logger.info("config {0}", [JSON.stringify(config)]);
			
			
			switch(data.screen)
			{
				case Screens.CONNECTION_TEST:
				navItem = _connectionTestScreen;
				break;
				
				case Screens.PORT_TEST:
				navItem = _portTestScreen;
				break;
				
				case Screens.BANDWIDTH_TEST:
				navItem = _bwTestScreen;
				break;
				
				case Screens.SO_TEST:
				navItem = _soTestScreen;
				break;
			}
			
			
			navItem.properties.connectionConfig = config;
			_navigator.pushScreen(screen);
		}
		
	}

}