package com.flashvisions.client.mobile.android.red5.red5rools.view.screens 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.screens.base.Red5TestScreen;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.SharedObjectTestScreenMediator;
	import feathers.controls.Button;
	import feathers.controls.IScreen;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollText;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleButton;
	import feathers.core.ITextEditor;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
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
	public class SharedObjectTestScreen extends Red5TestScreen implements IScreen
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(SharedObjectTestScreen);
		}
		
		public var btnConnect:ToggleButton;
		
		public var btnGetSo:Button;
		public var txtSoName:TextInput;
		
		public var btnSendText:Button;
		public var txtSoMethod:TextInput;
		public var txtSoData:TextInput;
		public var lblSoData:Label;
		public var lblSoMethod:Label;
		
		public var txtOutput:ScrollText;
		
		private var containerGroup1:LayoutGroup;
		private var containerGroup2:LayoutGroup;
		private var containerGroup21:LayoutGroup;
		private var containerGroup211:LayoutGroup;
		private var containerGroup212:LayoutGroup;
		
		public function SharedObjectTestScreen() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		
		private function onAddedToStage(e:Event):void
		{
			logger.info("onAddedToStage " + this);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			ApplicationFacade.getInstance().registerMediator(new SharedObjectTestScreenMediator(this));
		}
		
		
		 
		private function onRemovedFromStage(e:Event):void
		{
			logger.info("onRemovedFromStage " + this);
			
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			ApplicationFacade.getInstance().removeMediator(SharedObjectTestScreenMediator.NAME);
		}
		
		
		
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			
			// set title
			this.title = "SHARED OBJECT TEST";
			
			
			
			// set layout
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 40;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			this.layout = layout;
			
			
			var rowLayoutData:VerticalLayoutData = new VerticalLayoutData();
			rowLayoutData.percentWidth = 90;
			
			
			
			btnConnect = new ToggleButton();
			btnConnect.label = "CONNECT";
			btnConnect.layoutData = rowLayoutData;
			btnConnect.addEventListener(Event.TRIGGERED, onConnect);
			addChild(btnConnect);
			
			
			
			{
				
				var containerGroup1LayoutData:HorizontalLayoutData = new HorizontalLayoutData();
				containerGroup1LayoutData.percentWidth = 50;	
				containerGroup1LayoutData.percentHeight = 100;	
				
				
				var soConnectorlayout:HorizontalLayout = new HorizontalLayout();
				soConnectorlayout.gap = 10;
				soConnectorlayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
				soConnectorlayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
				
				
				containerGroup1 = new LayoutGroup();
				containerGroup1.layout = soConnectorlayout;
				containerGroup1.layoutData = rowLayoutData;
				addChild(containerGroup1);
				
				
				
				txtSoName = new TextInput();
				txtSoName.prompt = "SO Name";
				txtSoName.layoutData = containerGroup1LayoutData;
				containerGroup1.addChild(txtSoName);
				
				
				btnGetSo = new Button();
				btnGetSo.label = "GET SO";
				btnGetSo.layoutData = containerGroup1LayoutData;
				containerGroup1.addChild(btnGetSo);
			}
			
			
			
			{
				var innerRowLayoutData:VerticalLayoutData = new VerticalLayoutData();
				innerRowLayoutData.percentWidth = 100;
				
			
				var soTranmitlayout:VerticalLayout = new VerticalLayout();
				soTranmitlayout.gap = 10;
				soTranmitlayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
				soTranmitlayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
				
				
				containerGroup2 = new LayoutGroup();
				containerGroup2.layout = soTranmitlayout;
				containerGroup2.layoutData = rowLayoutData;
				addChild(containerGroup2);
				
				
				var containerGroup21Layout:HorizontalLayout = new HorizontalLayout();
				containerGroup21Layout.gap = 10;
				
				containerGroup21 = new LayoutGroup();
				containerGroup21.layout = containerGroup21Layout;
				containerGroup21.layoutData = innerRowLayoutData;
				containerGroup2.addChild(containerGroup21);
				
				
				var containerGroup211LayoutData:HorizontalLayoutData = new HorizontalLayoutData();
				containerGroup211LayoutData.percentWidth = 30;

				var containerGroup211Layout:VerticalLayout = new VerticalLayout();
				containerGroup211 = new LayoutGroup();
				containerGroup211.layout = containerGroup211Layout;
				containerGroup211.layoutData = containerGroup211LayoutData;
				containerGroup21.addChild(containerGroup211);
				
				
				
				
				lblSoMethod = new Label();
				lblSoMethod.text = "METHOD";
				lblSoMethod.layoutData = innerRowLayoutData;
				containerGroup211.addChild(lblSoMethod);
				
				
				txtSoMethod = new TextInput();
				txtSoMethod.prompt = "";
				txtSoMethod.layoutData = innerRowLayoutData;
				containerGroup211.addChild(txtSoMethod);
				
				
				
				var containerGroup212LayoutData:HorizontalLayoutData = new HorizontalLayoutData();
				containerGroup212LayoutData.percentWidth = 70;
				
				
				var containerGroup212Layout:VerticalLayout = new VerticalLayout();
				containerGroup212 = new LayoutGroup();
				containerGroup212.layout = containerGroup212Layout;
				containerGroup212.layoutData = containerGroup212LayoutData;
				containerGroup21.addChild(containerGroup212);
				
				
				lblSoData = new Label();
				lblSoData.text = "DATA";
				lblSoData.layoutData = innerRowLayoutData;
				containerGroup212.addChild(lblSoData);
				
				
				txtSoData = new TextInput();
				txtSoData.prompt = "";
				txtSoData.layoutData = innerRowLayoutData;
				containerGroup212.addChild(txtSoData);
				
				
				
				btnSendText = new Button();
				btnSendText.label = "SEND DATA";
				btnSendText.layoutData = innerRowLayoutData;
				containerGroup2.addChild(btnSendText);				
			}
			
			
			
			var fillLayoutData:VerticalLayoutData = new VerticalLayoutData();
			fillLayoutData.percentHeight = 90;
			fillLayoutData.percentWidth = 90;
			
			
			
			txtOutput = new ScrollText();
			txtOutput.backgroundColor = 0x000000;
			txtOutput.background = true;
			txtOutput.layoutData = fillLayoutData;
			txtOutput.textFormat = new TextFormat("Helvetica", 14, 0xffffff);
			addChild(txtOutput);
		}
		
		
		
		override public function dispose():void 
		{
			logger.info("disposing screen " + this);
			
			btnConnect.removeEventListener(Event.TRIGGERED, onConnect);
			removeChild(btnConnect);
			
			
			containerGroup1.removeChild(txtSoName);
			containerGroup1.removeChild(btnGetSo);
			removeChild(containerGroup1);
			
			
			containerGroup211.removeChild(lblSoMethod)
			containerGroup211.removeChild(txtSoMethod)
			containerGroup21.removeChild(containerGroup211);
			
			
			containerGroup212.removeChild(lblSoData)
			containerGroup212.removeChild(txtSoData)
			containerGroup21.removeChild(containerGroup212);
			
			
			containerGroup2.removeChild(containerGroup21);
			containerGroup2.removeChild(btnSendText);
			removeChild(containerGroup2);
			
			
			super.dispose();
		}
		
		
		
		private function onConnect(e:Event):void
		{
			
		}
	}

}