package com.flashvisions.client.mobile.android.red5.red5rools.net 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.events.ConnectionEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class SmartConnection extends EventDispatcher
	{
		private var _nc:NetConnection;
		private var _protocol:String;
		private var _port:String;
		private var _url:String;
		
		
		private var _wasConnected:Boolean;
		private var _isConnected:Boolean;
		private var _isConnecting:Boolean;
		
		private var _connectionTimer:uint;
		private var _client:Object;
		
		private var _resource:URL;
		
		
		public function SmartConnection() 
		{
			_nc = new NetConnection();
		}
		
		
		
		
		
		protected function _initHandlers():void
		{
			if(!_nc.hasEventListener(NetStatusEvent.NET_STATUS))
			_nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			
			if(!_nc.hasEventListener(AsyncErrorEvent.ASYNC_ERROR))
			_nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			
			if(!_nc.hasEventListener(IOErrorEvent.IO_ERROR))
			_nc.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			if(!_nc.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
			_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
			
		
		
		
		
		protected function _deInitHandlers():void
		{
			if(_nc.hasEventListener(NetStatusEvent.NET_STATUS))
			_nc.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			
			if(_nc.hasEventListener(AsyncErrorEvent.ASYNC_ERROR))
			_nc.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			
			if(_nc.hasEventListener(IOErrorEvent.IO_ERROR))
			_nc.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			if(_nc.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
			_nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		
		
		
		public function get netconnection():NetConnection
		{
			return _nc;
		}
		
		
		
		
		public function close():void
		{
			if(_isConnecting){
			var info:ConnectionInfo = new ConnectionInfo();
			info.status = NetConnectionCodes.CONNECT_TIME_OUT;
			info.endpoint = url;
			info.timestamp = parseInt(new Date().valueOf().toString());
			dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_ABORT, info));
			}
			
			
			_isConnected = false;
			_wasConnected = false;
			_isConnecting = false;
			
			_unmonitortimeout();
			
			
			if(_nc)
			_nc.close();
		}
		
		
		
		
		
		public function dispose():void
		{
			try
			{
				this.close();
				_deInitHandlers();
			}
			catch (e:Error) 
			{
				// NO OP - IGNORE
			}
			finally 
			{
				var info:ConnectionInfo = new ConnectionInfo();
				info.status = NetConnectionCodes.CONNECT_DISPOSE;
				info.endpoint = url;
				info.timestamp = parseInt(new Date().valueOf().toString());
				dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_DISPOSE, info));
				
				_nc = null;	
			}
		}
		
		
		
		
		
		
		public function connect(command:String = null):void
		{
			if (command) 
			url = command;
			
			if (_client)
			_nc.client = _client;
			
			
			_initHandlers();
			_nc.connect(_url);
			
			_isConnecting = true;
			_connectionTimer = setTimeout(monitortimeout, 5000);
		}
		
		
		
		
		
		
		
		private function _unmonitortimeout():void 
		{
			_isConnecting = false;
			clearTimeout(_connectionTimer);
		}
		
		
		
		
		
		
		private function monitortimeout():void 
		{
			if (_nc.connected)
			{
				_unmonitortimeout();
			}
			else 
			{
				var info:ConnectionInfo = new ConnectionInfo();
				info.status = NetConnectionCodes.CONNECT_TIME_OUT;
				info.endpoint = _nc.uri;
				info.timestamp = parseInt(new Date().valueOf().toString());
				dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_TIMEOUT, info));
			}
		}
		
		
		
		
		
		
		
		public function get url():String 
		{
			return _url;
		}
		
		
		
		
		
		
		
		public function set url(value:String):void 
		{
			_resource = new URL(value);
			_protocol = _resource.protocol;
			_port = _resource.port;
			_url = _resource.rawUrl;
		}
		
		
		
		
		
		public function get protocol():String 
		{
			return _protocol;
		}
		
		
		
		
		public function get wasConnected():Boolean 
		{
			return _wasConnected;
		}
		
		
		
		
		public function get isConnected():Boolean 
		{
			return _isConnected;
		}
		
		
		
		
		
		public function get client():Object 
		{
			return _client;
		}
		
		
		
		
		
		public function set client(value:Object):void 
		{
			_client = value;
		}
		
		
		
		
		
		
		public function get port():String 
		{
			return _port;
		}
		
		
		
		
		
		
		public function get isConnecting():Boolean 
		{
			return _isConnecting;
		}
		
		
		
		
		
		private function onSecurityError(e:SecurityErrorEvent):void 
		{
			var info:ConnectionInfo = new ConnectionInfo();
			info.infoString = e.text;
			info.status = NetConnectionCodes.CONNECT_SECURITY_ERROR;
			info.endpoint = url;
			info.timestamp = parseInt(new Date().valueOf().toString());
			
			dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_ERROR, info));
		}
		
		
		
		
		
		
		
		private function onIOError(e:IOErrorEvent):void 
		{
			var info:ConnectionInfo = new ConnectionInfo();
			info.infoString = e.text;
			info.status = NetConnectionCodes.CONNECT_IO_ERROR;
			info.endpoint = url;
			info.timestamp = parseInt(new Date().valueOf().toString());
			
			dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_ERROR, info));
		}
		
		
		
		
		
		
		
		private function onAsyncError(e:AsyncErrorEvent):void 
		{
			var info:ConnectionInfo = new ConnectionInfo();
			info.infoString = e.text;
			info.status = NetConnectionCodes.CONNECT_ASYNC_ERROR;
			info.endpoint = url;
			info.timestamp = parseInt(new Date().valueOf().toString());
			
			dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_ERROR, info));
			
		}
		
		
		
		
		
		
		
		
		private function onNetStatus(ns:NetStatusEvent):void 
		{
			_unmonitortimeout();
			
			var connection:NetConnection = ns.target as NetConnection;
			var info:ConnectionInfo = new ConnectionInfo();
			info.status = ns.info.code;
			info.endpoint = connection.uri;
			info.timestamp = parseInt(new Date().valueOf().toString());
			
			
			switch(ns.info.code)
			{
				case NetConnectionCodes.CONNECT_SUCCESS:
				_isConnected = true;
				_wasConnected = true;
				dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_SUCCESS, info));
				break;
				
				case NetConnectionCodes.CONNECT_CLOSED:
				if(_wasConnected)
				dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_LOST, info));
				else
				dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_CLOSED, info));
				_isConnected = false;
				break;
				
				case NetConnectionCodes.CONNECT_INVALIDAPP:
				case NetConnectionCodes.CONNECT_REJECTED:
				dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_ERROR, info));
				_isConnected = false;
				break;
				
				case NetConnectionCodes.CONNECT_FAILED:
				dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_ERROR, info));
				_isConnected = false;
				break;
				
				case NetConnectionCodes.CONNECT_IDLE_TIME_OUT:
				dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_ERROR, info));
				_isConnected = false;
				break;
			}
		}
	}

}