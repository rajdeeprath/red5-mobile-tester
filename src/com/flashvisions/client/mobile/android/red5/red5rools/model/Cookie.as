package com.flashvisions.client.mobile.android.red5.red5rools.model 
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author ...
	 */
	public class Cookie 
	{
		private var _sharedObject:SharedObject;
		
		private var _host:String;
		private var _port:String;
		private var _app:String;
		
		public function Cookie() 
		{
			_sharedObject = SharedObject.getLocal("red5tools");
		}
		
		
		public function get host():String 
		{
			_host = _sharedObject.data["host"] as String;
			return _host;
		}
		
		
		public function set host(value:String):void 
		{
			_host = value;
			_sharedObject.data["host"] = _host;
		}
		
		
		public function get port():String 
		{
			_port = _sharedObject.data["port"] as String;
			return _port;
		}
		
		
		public function set port(value:String):void 
		{
			_port = value;
			_sharedObject.data["port"] = _port;
		}
		
		
		
		public function get app():String 
		{
			_app = _sharedObject.data["app"] as String;
			return _app;
		}
		
		
		
		public function set app(value:String):void 
		{
			_app = value;
			_sharedObject.data["app"] = _app;
		}
		
		
		public function save():void
		{
			_sharedObject.flush();
		}
	}

}