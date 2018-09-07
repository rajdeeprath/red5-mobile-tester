package com.flashvisions.client.mobile.android.red5.red5rools.view.screens 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.PortTestScreenMediator;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.screens.base.Red5TestScreen;
	import feathers.controls.Button;
	import feathers.controls.IScreen;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollPolicy;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import starling.events.Event;
	
	
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
	public class PortTestScreen extends Red5TestScreen implements IScreen 
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(PortTestScreen);
		}
		
		
		public var btnRunTest:Button;
		public var list:List;
		
		
		
		
		public function PortTestScreen() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		
		private function onAddedToStage(e:Event):void
		{
			logger.info("onAddedToStage " + this);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			ApplicationFacade.getInstance().registerMediator(new PortTestScreenMediator(this));
		}
		
		
		 
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			logger.info("onRemovedFromStage " + this);
			ApplicationFacade.getInstance().removeMediator(PortTestScreenMediator.NAME);
		}
		
		
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			
			// set title
			this.title = "PORT TEST";
			
			
			
			// set layout
			
			var rowLayoutData:VerticalLayoutData = new VerticalLayoutData();
			rowLayoutData.percentWidth = 90;
			
			
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 40;
			layout.horizontalAlign = HorizontalAlign.CENTER;
			layout.verticalAlign = VerticalAlign.MIDDLE;
			this.layout = layout;
			
			
			var masterLayoutData:VerticalLayoutData = new VerticalLayoutData();
			masterLayoutData.percentHeight = 90;
			masterLayoutData.percentWidth = 90;

			
			
			btnRunTest = new Button();
			btnRunTest.label = "RUN TEST";
			btnRunTest.layoutData = rowLayoutData;
			btnRunTest.addEventListener(Event.TRIGGERED, onRunTest);
			addChild(btnRunTest);
			
			
			list = new List();
			list.layoutData = masterLayoutData;
			list.horizontalScrollPolicy = ScrollPolicy.OFF;
			list.padding = 20;
			
			addChild(list);
		}
		
		
		
		
		override public function dispose():void 
		{
			logger.info("disposing screen " + this);
			
			btnRunTest.removeEventListener(Event.TRIGGERED, onRunTest);
			removeChild(btnRunTest);
			
			removeChild(list);
			
			super.dispose();
		}
		
		
		
		
		private function onRunTest(e:Event):void
		{
			
		}
		
		
		
		public function getScreenId():String
		{
			return this.screenID;
		}
	}

}