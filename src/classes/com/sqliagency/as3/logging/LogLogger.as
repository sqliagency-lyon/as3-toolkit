package com.sqliagency.as3.logging {
	
	import flash.events.EventDispatcher;
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 * @created 01/06/2009
	 */
	public class LogLogger extends EventDispatcher implements ILogger 
	{
		private var _category:String;
		private var _methodName:String;
		
		public function LogLogger(category:String) 
		{
			super();
			_category = category;
		}
		
		public function get category():String 
		{
			return _category;
		}
		
		public function get methodName():String 
		{
			return _methodName;
		}
		
		public function log(level:int, msg:String, ... rest):void 
		{
			// we don't want to allow people to log messages at the 
			// Log.Level.ALL level, so throw a RTE if they do
			if (level < LogEventLevel.DEBUG) 
			{
				throw new ArgumentError("Logging : log messages at the LogEventLevel.ALL level aren't allowed");
			}
				
			internalLog(level, msg, rest);
		}
		
		public function debug(msg:String, ... rest):void 
		{
			internalLog(LogEventLevel.DEBUG, msg, rest);
		}
		
		public function error(msg:String, ... rest):void 
		{
			internalLog(LogEventLevel.ERROR, msg, rest);
		}
		
		public function fatal(msg:String, ... rest):void 
		{
			internalLog(LogEventLevel.FATAL, msg, rest);
		}
	
		public function info(msg:String, ... rest):void 
		{
			internalLog(LogEventLevel.INFO, msg, rest);
		}

		public function warn(msg:String, ... rest):void 
		{
			internalLog(LogEventLevel.WARN, msg, rest);
		}
		
		private function internalLog(level:int, msg:String, rest:Array):void 
		{
			if (hasEventListener(LogEvent.LOG)) 
			{
				// replace all of the parameters in the msg string
				if (rest) 
				{
					for (var i:int = 0; i < rest.length; i++) 
					{
						msg = msg.replace(new RegExp("\\{"+i+"\\}", "g"), rest[i]);
					}
				}
				setMethodName();
				dispatchEvent(new LogEvent(msg, level));
			}
		}
		
		private function setMethodName():void 
		{
			var stackTrace:String;
			
			try 
			{
				throw new Error("");
			}
			catch (err:Error)
			{
				stackTrace = err.getStackTrace();
			}
			
			var value:String = String(stackTrace.split("\tat ")[4]).replace("::", ".").replace(category, "");
			var startIndex:int = 1;
			var endIndex:int = value.indexOf("()");
			
			_methodName = (endIndex > startIndex) ? value.substring(startIndex, endIndex) : "$init";
		}
	}
}