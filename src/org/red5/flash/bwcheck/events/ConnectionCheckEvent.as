package org.red5.flash.bwcheck.events
{
	import flash.events.Event;
	
	import org.red5.flash.bwcheck.interfaces.IConnectionCheck;

	public class ConnectionCheckEvent extends BandwidthDetectEvent
	{
		private var _check:IConnectionCheck;
		
		
		public function get check():IConnectionCheck
		{
			return _check;
		}
		
		
		
		public function ConnectionCheckEvent(event:BandwidthDetectEvent)
		{
			this._check = event.target as IConnectionCheck;
			super(event.type, event.info);
		}
		
		
		
		
		public override function clone():Event
		{
			return new ConnectionCheckEvent(new BandwidthDetectEvent(type, info));
		}
	}
}