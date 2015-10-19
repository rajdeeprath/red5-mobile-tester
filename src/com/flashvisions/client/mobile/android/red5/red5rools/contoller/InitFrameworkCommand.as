package com.flashvisions.client.mobile.android.red5.red5rools.contoller
{
	import com.flashvisions.client.mobile.android.red5.red5rools.Application;
	import com.flashvisions.client.mobile.android.red5.red5rools.model.DataProxy;
	import com.flashvisions.client.mobile.android.red5.red5rools.view.ApplicationMediator;
	import flash.display.Stage;
	
	import org.puremvc.as3.interfaces.IAsyncCommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	public class InitFrameworkCommand extends AsyncCommand implements IAsyncCommand
	{
		public function InitFrameworkCommand()
		{
			super();
		}
		
		/* INTERFACE org.puremvc.as3.interfaces.ICommand */
		
		override public function execute(notification:INotification):void 
		{
			var application:Application = notification.getBody() as Application;
			var stage:Stage = application.stage as Stage;
			
			facade.registerProxy(new DataProxy());
			
			facade.registerMediator(new ApplicationMediator(application));
			
			commandComplete();
		}
	}
}