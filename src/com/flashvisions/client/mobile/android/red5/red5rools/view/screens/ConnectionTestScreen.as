package com.flashvisions.client.mobile.android.red5.red5rools.view.screens 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.ConnectionTestScreenMediator;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.screens.base.Red5TestScreen;
	import feathers.controls.IScreen;
	import feathers.controls.PanelScreen;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleButton;
	import feathers.core.ITextEditor;
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
	public class ConnectionTestScreen extends Red5TestScreen implements IScreen
	{		
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(ConnectionTestScreen);
		}
		
		public var btnTestConnection:ToggleButton;
		public var txtOutput:TextInput;
		
		
		public function ConnectionTestScreen() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		
		
		
		private function onAddedToStage(e:Event):void
		{
			logger.info("onAddedToStage " + this);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			ApplicationFacade.getInstance().registerMediator(new ConnectionTestScreenMediator(this));
		}
		
		
		
		
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			logger.info("onRemovedFromStage " + this);
			ApplicationFacade.getInstance().removeMediator(ConnectionTestScreenMediator.NAME);
		}
		
		
		
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			// set title
			this.title = "SIMPLE CONNECTION TEST";
			
			
			
			// set layout
			
			var rowLayoutData:VerticalLayoutData = new VerticalLayoutData();
			rowLayoutData.percentWidth = 90;
			
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 40;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			this.layout = layout;

			
			
			var masterLayoutData:VerticalLayoutData = new VerticalLayoutData();
			masterLayoutData.percentHeight = 90;
			masterLayoutData.percentWidth = 90;
			
			
			
			btnTestConnection = new ToggleButton();
			btnTestConnection.label = "CONNECT";
			btnTestConnection.layoutData = rowLayoutData;
			addChild(btnTestConnection);
			
			
			
			txtOutput = new TextInput();
			txtOutput.padding = 5;
			txtOutput.isEditable = false;
			txtOutput.layoutData = masterLayoutData;
			txtOutput.textEditorFactory = function():ITextEditor
			{
				var editor:StageTextTextEditor = new StageTextTextEditor();
				editor.fontFamily = "Helvetica";
				editor.fontSize = 14;
				editor.multiline = true;
				editor.color = 0xffffff;
				return editor;
			}
			addChild(txtOutput);
			
		}
		
		
		override public function dispose():void 
		{
			logger.info("disposing screen " + this);
			
			removeChild(btnTestConnection);
			removeChild(txtOutput);
			
			super.dispose();
		}

	}

}