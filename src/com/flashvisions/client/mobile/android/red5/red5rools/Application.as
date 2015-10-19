package com.flashvisions.client.mobile.android.red5.red5rools 
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	CONFIG::LOGGING
	{
		import org.as3commons.logging.setup.LevelTargetSetup;
		import org.as3commons.logging.setup.LogSetupLevel;
	
	
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
	public class Application extends Sprite 
	{
		
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(Application);
		}
		
		
		
		
		public function Application() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		private function onAdded(e:Event):void
		{
			ApplicationFacade.getInstance().startup(this);
		}
		
	}

}