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
	public class HomeScreenMediator extends Mediator implements IMediator 
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(HomeScreenMediator);
		}
		
		
		public static const NAME:String = "HomeScreenMediator";
		
		private var _component:HomeScreen;
		private var _cookie:Cookie;
		
		private var _dataProxy:DataProxy;
		
		
		
		
		public function HomeScreenMediator(viewComponent:Object=null) 
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
			this._component = this.viewComponent as HomeScreen;
						
			this._dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			this._cookie = this._dataProxy.cookie;	
			
			
			this._component.txtHost.text = this._cookie.host;
			this._component.txtPort.text = this._cookie.port;
			this._component.txtApp.text = this._cookie.app;
		}
		
		
		
		
		override public function onRemove():void 
		{
			
		}		
	}

}