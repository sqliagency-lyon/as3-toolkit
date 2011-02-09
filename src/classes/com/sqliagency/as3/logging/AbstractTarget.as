package com.sqliagency.as3.logging {
	
	import com.sqliagency.as3.utils.UIDUtil;
	import com.sqliagency.as3.logging.errors.InvalidFilterError;
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 * @created 01/06/2009
	 */
	public class AbstractTarget implements ILoggingTarget 
	{
		private var _id:String;
		private var _filters:Array = [ "*" ];
		private var _level:int = LogEventLevel.ALL;
		private var _loggerCount:int = 0;
		
		public function AbstractTarget()
		{
			_id = UIDUtil.createUID();
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get filters():Array
		{
			return _filters;
		}

		public function set filters(value:Array):void
		{
			if (value && value.length > 0)
			{
				var filter:String;
				var index:int;
				var message:String;
				
				for (var i:uint = 0; i < value.length; i++) 
				{
					filter = value[i];
					// check for invalid characters
					if (Log.hasIllegalCharacters(filter)) 
					{
						throw new InvalidFilterError("Logging : filter has an invalid character");
					}

					index = filter.indexOf("*");
					if ((index >= 0) && (index != (filter.length -1))) 
					{
						throw new InvalidFilterError("Logging : filter hasn't the wilcard (*) correctly placed");
					}
				}
			}
			else
			{
				// if null was specified then default to all
				value = ["*"];
			}
			
			
			if (_loggerCount > 0) 
			{
				Log.removeTarget(this);
				_filters = value;
				Log.addTarget(this);
			}
			else 
			{
				_filters = value;
			}
		}
		
		public function get level():int 
		{
			return _level;
		}
		
		public function set level(value:int):void 
		{
			// A change of level may impact the target level for Log.
			Log.removeTarget(this);
			_level = value;
			Log.addTarget(this);        
		}
		
		public function addLogger(logger:ILogger):void 
		{
			if (logger) 
			{
				_loggerCount++;
				logger.addEventListener(LogEvent.LOG, logHandler, false, 0, true);
			}
		}
		
		public function removeLogger(logger:ILogger):void 
		{
			if (logger) 
			{
				_loggerCount--;
				logger.removeEventListener(LogEvent.LOG, logHandler, false);
			}
		}
		
		public function logEvent(event:LogEvent):void 
		{
			//...
		}

		private function logHandler(event:LogEvent):void 
		{
			if (event.level >= level) 
			{
				logEvent(event);
			}
		}
	}
}