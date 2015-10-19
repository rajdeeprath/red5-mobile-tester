package com.flashvisions.client.mobile.android.red5.red5rools.view.screens 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.BandwidthTestScreenMediator;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.screens.base.Red5TestScreen;
	import feathers.controls.Button;
	import feathers.controls.IScreen;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollBar;
	import feathers.controls.ScrollText;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.core.ITextEditor;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import flash.text.TextFormat;
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
	public class BandwidthTestScreen extends Red5TestScreen implements IScreen
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(BandwidthTestScreen);
		}
		
		
		public var btnRunTest:Button;
		public var txtOutput:ScrollText;
		
		
		public function BandwidthTestScreen() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		
		private function onAddedToStage(e:Event):void
		{
			logger.info("onAddedToStage " + this);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			ApplicationFacade.getInstance().registerMediator(new BandwidthTestScreenMediator(this));
		}
		
		
		
		
		 
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			logger.info("onRemovedFromStage " + this);
			
			ApplicationFacade.getInstance().removeMediator(BandwidthTestScreenMediator.NAME);
		}
		
		
		
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			
			// set title
			this.title = "BANDWIDTH TEST";
			
			
			
			// set layout
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 40;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			this.layout = layout;
			
			
			
			var masterLayoutData:VerticalLayoutData = new VerticalLayoutData();
			masterLayoutData.percentHeight = 90;
			masterLayoutData.percentWidth = 90;
			
			
			var buttonLayoutData:VerticalLayoutData = new VerticalLayoutData();
			buttonLayoutData.percentWidth = 90;
			
			
			btnRunTest = new Button();
			btnRunTest.label = "RUN TEST";
			btnRunTest.layoutData = buttonLayoutData;
			btnRunTest.addEventListener(Event.TRIGGERED, onRunTest);
			addChild(btnRunTest);
			
			
			
			txtOutput = new ScrollText();
			txtOutput.backgroundColor = 0x000000;
			txtOutput.background = true;
			txtOutput.layoutData = masterLayoutData;
			txtOutput.textFormat = new TextFormat("Helvetica", 14, 0xffffff);
			addChild(txtOutput);
		}
		
		
		
		override public function dispose():void 
		{
			logger.info("disposing screen " + this);
			
			btnRunTest.removeEventListener(Event.TRIGGERED, onRunTest);
			removeChild(btnRunTest);
			
			removeChild(txtOutput);
			
			super.dispose();
		}
		
		
		
		
		private function onRunTest(e:Event):void
		{
			
		}
	}

}