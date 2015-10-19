package com.flashvisions.client.mobile.android.red5.red5rools
{
	import flash.display.Stage;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import com.flashvisions.client.mobile.android.red5.red5rools.contoller.*;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		public static const STARTUP:String  = "STARTUP";
		public static const READY:String  = "READY";
		public static const FAULT:String  = "FAULT";
		
		public static const CONNECTION_TEST:String  = "CONNECTION_TEST";
		public static const PORT_TEST:String  = "PORT_TEST";
		
		public static const TEST_START:String  = "TEST_START";
		public static const TEST_COMPLETE:String  = "TEST_COMPLETE";
		
		public static const LOG:String  = "LOG";
		
		
		public static const CONNECTION_SUCCESS:String  = "CONNECTION_SUCCESS";
		public static const CONNECTION_ERROR:String  = "CONNECTION_ERROR";
		public static const CONNECTION_TIMEOUT:String  = "CONNECTION_TIMEOUT";
		public static const CONNECTION_LOST:String  = "CONNECTION_LOST";
		public static const CONNECTION_CLOSED:String  = "CONNECTION_CLOSED";
		
		
		
		public function ApplicationFacade()
		{
			super();
		}
		
		
		
		
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance() : ApplicationFacade {
			if ( instance == null ) instance = new ApplicationFacade( );
			return instance as ApplicationFacade;
		}
		
		
		
		
		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController( ) : void 
		{
			super.initializeController();
			
			this.registerCommand(STARTUP,StartupCommand);
			this.registerCommand(CONNECTION_TEST, SimpleConnectionTestCommand);
		}
		
		
		
		
		
		public function startup( application:Object ):void
		{
			sendNotification( STARTUP, application);
		}
	}
}