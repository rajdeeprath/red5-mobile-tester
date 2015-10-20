package org.red5.flash.bwcheck
{
	
	import flash.net.Responder;
	
	import org.red5.flash.bwcheck.interfaces.IDetection;
	
	public class ServerClientBandwidth extends BandwidthDetection implements IDetection
	{
		private static const TYPE:uint = 0;
		
		private var _service:String = "checkBandwidth";
		private var _dirty:Boolean;
		private var info:Object = new Object();
		
		private var res:Responder;
		
		
		
		
		public function ServerClientBandwidth()
		{
			res = new Responder(onResult, onStatus);
		}
		
		
		
		
		
		public function get type():uint
		{
			return TYPE;
		}
		
		
		
		

		public function get dirty():Boolean
		{
			return _dirty;
		}
		
		
		
		

		public function set dirty(value:Boolean):void
		{
			_dirty = value;
		}
		
		
		
		

		public function onBWCheck(obj:Object):Number
		{
			return 0;
			dispatchStatus(obj);
		}
		
		
		
		
			
		public function onBWDone(...rest):void 
		{ 
			_dirty = true;
			
			var result:Object = rest[0];
			var info:Object = new Object();
			info.kbitDown = result.kbitDown;
			info.deltaDown = result.deltaDown;
			info.deltaTime = result.deltaTime;
			info.latency = result.latency;
			
			dispatchComplete(info);
		} 
		
		
		
		public function set service(service:String):void
		{
			_service = service;
		}
		
		
		public function start():void
		{
			nc.client = this;
			nc.call(_service,res);
		}
		
		
		
		private function onResult(obj:Object):void
		{
			dispatchStatus(obj);
		}
		
		
		private function onStatus(obj:Object):void
		{
			switch (obj.code)
			{
				case "NetConnection.Call.Failed":
					_dirty = true;
					dispatchFailed(obj);
					break;
			}

		}
	}
}
