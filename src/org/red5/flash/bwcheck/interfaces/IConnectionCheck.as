package org.red5.flash.bwcheck.interfaces
{
	import flash.events.IEventDispatcher;
	import flash.net.NetConnection;

	public interface IConnectionCheck extends IEventDispatcher
	{
		function get type():uint;
		function get dirty():Boolean;
		
		function set service(service:String):void;
		
		function set connection(connect:NetConnection):void
		function get connection():NetConnection
			
		function start():void;
	}
}