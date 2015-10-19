package com.flashvisions.client.mobile.android.red5.red5rools.net 
{
	import com.flashvisions.client.mobile.android.red5.red5rools.events.ConnectionEvent;
	import flash.events.EventDispatcher;
	
	CONFIG::LOGGING
	{
		import org.as3commons.logging.api.ILogger;
		import org.as3commons.logging.api.LOGGER_FACTORY;
		import org.as3commons.logging.api.LoggerFactory;
		import org.as3commons.logging.api.getLogger;
		import org.as3commons.logging.setup.SimpleTargetSetup;
		import org.as3commons.logging.setup.target.TraceTarget;
	}
	
	/**
	 * ...
	 * @author ...
	 */
	public class ConnectionProvider extends EventDispatcher 
	{
		CONFIG::LOGGING
		{
			private static const logger:ILogger = getLogger(ConnectionProvider);
		}
		
		
		private var connections:Vector.<SmartConnection>;
		
		
		
		public function ConnectionProvider() 
		{
			connections = new Vector.<SmartConnection>();
		}
		
		
		
		public function newConnection():SmartConnection
		{
			var connection:SmartConnection = new SmartConnection();
			
			connection.addEventListener(ConnectionEvent.CONNECTION_SUCCESS, onConnectionSuccess);
			connection.addEventListener(ConnectionEvent.CONNECTION_TIMEOUT, onConnectionTimeout);
			connection.addEventListener(ConnectionEvent.CONNECTION_ERROR, onConnectionError);
			connection.addEventListener(ConnectionEvent.CONNECTION_LOST, onConnectionLost);
			connection.addEventListener(ConnectionEvent.CONNECTION_CLOSED, onConnectionClosed);
			connection.addEventListener(ConnectionEvent.CONNECTION_ASYNC_ERROR, onConnectionAsyncError);
			
			connections.push(connection);
			
			return connection;
		}
		
		
		
		
		public function purgeConnections(all:Boolean = true):void
		{
			for (var i:uint = 0; i < connections.length; i++)
			{
				var index:uint = i;
				var connection:SmartConnection = connections[index] as SmartConnection;
				var purge:Boolean = (all)?true:((connection.wasConnected && !connection.isConnected)?true:false);
				
				
				if(purge)
				{
					CONFIG::LOGGING
					{
						logger.info("Purging dead connection {0}" + connection);
					}
					
					
					if(connection.hasEventListener(ConnectionEvent.CONNECTION_SUCCESS))
					connection.removeEventListener(ConnectionEvent.CONNECTION_SUCCESS, onConnectionSuccess);
					
					if(connection.hasEventListener(ConnectionEvent.CONNECTION_TIMEOUT))
					connection.removeEventListener(ConnectionEvent.CONNECTION_TIMEOUT, onConnectionTimeout);
					
					if(connection.hasEventListener(ConnectionEvent.CONNECTION_ERROR))
					connection.removeEventListener(ConnectionEvent.CONNECTION_ERROR, onConnectionError);
					
					if(connection.hasEventListener(ConnectionEvent.CONNECTION_LOST))
					connection.removeEventListener(ConnectionEvent.CONNECTION_LOST, onConnectionLost);					
					
					if(connection.hasEventListener(ConnectionEvent.CONNECTION_CLOSED))
					connection.removeEventListener(ConnectionEvent.CONNECTION_CLOSED, onConnectionClosed);
					
					if(connection.hasEventListener(ConnectionEvent.CONNECTION_ASYNC_ERROR))
					connection.removeEventListener(ConnectionEvent.CONNECTION_ASYNC_ERROR, onConnectionAsyncError);
					
					
					connections.splice(index, 1);
					i--;
					
					
					try
					{
						connection.dispose();
					}
					catch(e:Error)
					{
						CONFIG::LOGGING
						{
							logger.warn("Problem disposing connection " + connection + " " + e.message);
						}
					}
					finally
					{
						connection = null;
					}
				}
			}
		}
		
		
		
		
		/* Handlers */
		
		private function onConnectionSuccess(e:ConnectionEvent):void
		{
			
		}
		
		
		private function onConnectionTimeout(e:ConnectionEvent):void
		{
			
		}
		
		
		private function onConnectionError(e:ConnectionEvent):void
		{
			
		}
		
		
		private function onConnectionClosed(e:ConnectionEvent):void
		{
			
		}
		
		
		private function onConnectionLost(e:ConnectionEvent):void
		{
			
		}
		
		
		private function onConnectionAsyncError(e:ConnectionEvent):void
		{
			
		}
		
		
		
	}

}