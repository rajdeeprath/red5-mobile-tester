package
{
	import com.flashvisions.client.mobile.android.red5.red5rools.Application;
	import feathers.controls.Button;
	import feathers.themes.BaseMetalWorksMobileTheme;
	import feathers.themes.MetalWorksMobileTheme;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import org.as3commons.logging.setup.LevelTargetSetup;
	import org.as3commons.logging.setup.LogSetupLevel;
	import starling.core.Starling;
	
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
	 * @author Krishna
	 */
	public class Main extends Sprite 
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(Main);
		}
		
		public var application:Application;
		public var starling:Starling;
		
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			
			// init logging
			initLogging();
			
			
			// Entry point	
			logger.info("Initializing starling");
			
			starling = new Starling(Application, stage, null, null, "auto", "auto");
			stage.addEventListener(Event.RESIZE, stageResized);
			starling.start();		
		}
		
		
		
		
		private function initLogging():void
		{
			CONFIG::LOGGING
			{	
				LOGGER_FACTORY.setup = new LevelTargetSetup(new TraceTarget(), LogSetupLevel.DEBUG);
				logger.info("Loggging subsystem ready");
			}
		}
		
		
		
		
		
		private function stageResized(e:Event):void
		{
			logger.info("Stage resized : resizing starling viewport");
			
			
			// set rectangle dimensions for viewPort:
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.stageWidth;
			viewPortRectangle.height = stage.stageHeight;
			
			

			// resize the viewport:
			starling.viewPort = viewPortRectangle
			
			

			// assign the new stage width and height:
			starling.stage.stageWidth = stage.stageWidth
			starling.stage.stageHeight = stage.stageHeight
		}
		
		
		
		private function deactivate(e:Event):void 
		{
			//logger.info("Exiting application");
			
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}