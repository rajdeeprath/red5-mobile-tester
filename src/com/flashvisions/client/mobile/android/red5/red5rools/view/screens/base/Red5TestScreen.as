package com.flashvisions.client.mobile.android.red5.red5rools.view.screens.base 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.model.ConnectionConfig;
	import feathers.controls.PanelScreen;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Red5TestScreen extends PanelScreen 
	{
		protected var _connectionConfig:ConnectionConfig;
		
		
		public function Red5TestScreen() 
		{
			super();
			
		}
		
		public function get connectionConfig():ConnectionConfig 
		{
			return _connectionConfig;
		}
		
		
		public function set connectionConfig(value:ConnectionConfig):void 
		{
			if (_connectionConfig == value )
			{
				return;
			}
			
			_connectionConfig = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		
		override protected function initialize():void 
		{
			super.initialize();
			
			
			
			// handlers
			this.backButtonHandler = function():void
			{
				this.dispatchEventWith(Event.COMPLETE);
			};
		}
		
	}

}