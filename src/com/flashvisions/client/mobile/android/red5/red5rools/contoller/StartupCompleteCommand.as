package com.flashvisions.client.mobile.android.red5.red5rools.contoller
{
	import com.flashvisions.client.mobile.android.red5.red5rools.ApplicationFacade;
	import org.puremvc.as3.interfaces.IAsyncCommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	public class StartupCompleteCommand extends AsyncCommand implements IAsyncCommand
	{
		/* INTERFACE org.puremvc.as3.interfaces.ICommand */
		
		override public function execute(notification:INotification):void 
		{
			facade.sendNotification(ApplicationFacade.READY);
			commandComplete();
		}
	}
}