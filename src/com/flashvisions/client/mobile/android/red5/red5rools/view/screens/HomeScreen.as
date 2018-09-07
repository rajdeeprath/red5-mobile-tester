package com.flashvisions.client.mobile.android.red5.red5rools.view.screens 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import com.flashvisions.client.mobile.android.red5.red5rools.Screens;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.HomeScreenMediator;
	import feathers.controls.Button;
	import feathers.controls.IScreen;
	import feathers.controls.LayoutGroup;
	import feathers.controls.PanelScreen;
	import feathers.controls.TextInput;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.system.Capabilities;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	CONFIG::LOGGING
	{
		import org.as3commons.logging.api.ILogger;
		import org.as3commons.logging.api.LOGGER_FACTORY;
		import org.as3commons.logging.api.LoggerFactory;
		import org.as3commons.logging.api.getLogger;
		import org.as3commons.logging.setup.SimpleTargetSetup;
		import org.as3commons.logging.setup.target.TraceTarget;
	}
	
	/**
	 * ...
	 * @author ...
	 */
	public class HomeScreen extends PanelScreen implements IScreen
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(HomeScreen);
		}
		
		[Embed(source = "../../../../../../../../../assets/image.png")]
		private static const Red5Logo:Class;
		private var bmp:Bitmap;
		private var image:Image;
		
		
		public var txtHost:TextInput;
		public var txtPort:TextInput;
		public var txtApp:TextInput;
		
		
		public var btnConnectionTest:Button;
		public var btnPortTest:Button;
		public var btnBandwidthTest:Button;
		public var btnSoTest:Button;
		public var btnRemotingTest:Button;
		public var btnVideoTest:Button;
		
		private var imageLayoutContainer:LayoutGroup;
		
		
		public function HomeScreen() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		private function onAddedToStage(e:Event):void
		{
			logger.info("onAddedToStage " + this);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			ApplicationFacade.getInstance().registerMediator(new HomeScreenMediator(this));
		}
		
		
		 
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			logger.info("onRemovedFromStage " + this);
			ApplicationFacade.getInstance().removeMediator(HomeScreenMediator.NAME);
		}
		
		
		
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			// set title
			this.title = "Red5 TOOLS";
			
			
			
			// set layout
			
			var rowLayoutData:VerticalLayoutData = new VerticalLayoutData();
			rowLayoutData.percentWidth = 90;
			
			
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 10;
			layout.horizontalAlign = HorizontalAlign.CENTER;
			layout.verticalAlign = VerticalAlign.MIDDLE;
			this.layout = layout;
			
			
			//add children	
			
			var imageLayout:VerticalLayout = new VerticalLayout();
			imageLayout.paddingBottom = 20;
			
			imageLayoutContainer = new LayoutGroup();
			imageLayoutContainer.layout = imageLayout;
			addChild(imageLayoutContainer);
			
			bmp = new Red5Logo();
			image = new Image(Texture.fromBitmap(bmp));
			imageLayoutContainer.addChild(image);
			
			
			var layout1:HorizontalLayout = new HorizontalLayout();
			layout1.gap = 10;
			
			var txtHostPortLayoutData:HorizontalLayoutData = new HorizontalLayoutData();
			txtHostPortLayoutData.percentWidth = 50;
			
			
			var containerGroup1:LayoutGroup = new LayoutGroup();
			containerGroup1.layoutData = rowLayoutData;
			containerGroup1.layout = layout1;
			this.addChild( containerGroup1 );
			
			
			
			txtHost = new TextInput();
			txtHost.prompt = "HOST";
			txtHost.layoutData  = txtHostPortLayoutData;
			containerGroup1.addChild(txtHost);
			
			
			
			txtPort = new TextInput();
			txtPort.prompt = "PORT";
			txtPort.layoutData  = txtHostPortLayoutData;
			containerGroup1.addChild(txtPort);
			
			
			
			txtApp = new TextInput();
			txtApp.prompt = "APP";
			txtApp.layoutData = rowLayoutData;
			addChild(txtApp);
			
			
			
			btnConnectionTest = new Button();
			btnConnectionTest.label = "CONNECTION TEST";
			btnConnectionTest.addEventListener(Event.TRIGGERED, onSimpleConnectionTest);
			btnConnectionTest.layoutData = rowLayoutData;
			addChild(btnConnectionTest);
			
			
			
			btnPortTest = new Button();
			btnPortTest.label = "PORT TEST";
			btnPortTest.addEventListener(Event.TRIGGERED, onPortTest);
			btnPortTest.layoutData = rowLayoutData;
			addChild(btnPortTest);
			
			
			
			btnBandwidthTest = new Button();
			btnBandwidthTest.label = "BANDWIDTH TEST";
			btnBandwidthTest.addEventListener(Event.TRIGGERED, onBandwidthTest);
			btnBandwidthTest.layoutData = rowLayoutData;
			addChild(btnBandwidthTest);
			
			
			
			btnSoTest = new Button();
			btnSoTest.label = "SHAREDOBJECT TEST";
			btnSoTest.addEventListener(Event.TRIGGERED, onSOTest);
			btnSoTest.layoutData = rowLayoutData;
			addChild(btnSoTest);
			
			
			
			btnRemotingTest = new Button();
			btnRemotingTest.label = "REMOTING TEST";
			btnRemotingTest.layoutData = rowLayoutData;
			btnRemotingTest.isEnabled = false;
			addChild(btnRemotingTest);
			
			
			
			btnVideoTest = new Button();
			btnVideoTest.label = "VIDEO TEST";
			btnVideoTest.isEnabled = false;
			btnVideoTest.layoutData = rowLayoutData;
			addChild(btnVideoTest);
			
			
			
			this.backButtonHandler = function():void {
				
				NativeApplication.nativeApplication.exit();
			}
			
		}
		
		
		override public function dispose():void 
		{
			removeChild(btnConnectionTest);
			
			removeChild(btnPortTest);
			
			removeChild(btnBandwidthTest);
			
			removeChild(btnSoTest);
			
			removeChild(btnRemotingTest);
			
			removeChild(btnVideoTest);
			
			imageLayoutContainer.removeChild(image);
			removeChild(imageLayoutContainer);
			
			super.dispose();
		}

		
		
		private function onSimpleConnectionTest(e:Event):void
		{
			var serverObject:Object = new Object();
			serverObject.host = txtHost.text;
			serverObject.port = txtPort.text;
			serverObject.app = txtApp.text;
			serverObject.screen = Screens.CONNECTION_TEST;
			
			if (serverObject.host != null && serverObject.host != "" && serverObject.app != null && serverObject.app != "")
			{
				this.dispatchEventWith(Event.SELECT, false, serverObject);
			}
		}
		
		
		
		private function onPortTest(e:Event):void
		{
			var serverObject:Object = new Object();
			serverObject.host = txtHost.text;
			serverObject.port = txtPort.text;
			serverObject.app = txtApp.text;
			serverObject.screen = Screens.PORT_TEST;
			
			if (serverObject.host != null && serverObject.host != "" && serverObject.app != null && serverObject.app != "")
			{
				this.dispatchEventWith(Event.SELECT, false, serverObject);
			}
		}
		
		
		
		private function onBandwidthTest(e:Event):void
		{
			var serverObject:Object = new Object();
			serverObject.host = txtHost.text;
			serverObject.port = txtPort.text;
			serverObject.app = txtApp.text;
			serverObject.screen = Screens.BANDWIDTH_TEST;
			
			if (serverObject.host != null && serverObject.host != "" && serverObject.app != null && serverObject.app != "")
			{
				this.dispatchEventWith(Event.SELECT, false, serverObject);
			}
		}
		
		
		
		private function onSOTest(e:Event):void
		{
			var serverObject:Object = new Object();
			serverObject.host = txtHost.text;
			serverObject.port = txtPort.text;
			serverObject.app = txtApp.text;
			serverObject.screen = Screens.SO_TEST;
			
			if (serverObject.host != null && serverObject.host != "" && serverObject.app != null && serverObject.app != "")
			{
				this.dispatchEventWith(Event.SELECT, false, serverObject);
			}
		}
		
		
		
		public function getScreenId():String
		{
			return this.screenID;
		}
	}

}