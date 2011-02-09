package com.sqliagency.as3.logging {
	
	import flash.events.Event;
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 * @created 01/06/2009
	 */
	public class LogEvent extends Event {
		
		public var level:int;
		public var message:String;
		
		public static const LOG:String = "log";
		
		public function LogEvent(message:String = "", level:int = 0 /* LogEventLevel.ALL */) 
		{
			super(LogEvent.LOG, false, false);
			this.message = message;
			this.level = level;
		}
		
		public static function getLevelString(value:uint):String 
		{
			var result:String = "UNKNOWN";
			
			switch (value) {
				case LogEventLevel.INFO:
					result = "INFO";
					break;

				case LogEventLevel.DEBUG:
					result = "DEBUG";
					break;

				case LogEventLevel.ERROR:
					result = "ERROR";
					break;

				case LogEventLevel.WARN:
					result = "WARN";
					break;

				case LogEventLevel.FATAL:
					result = "FATAL";
					break;

				case LogEventLevel.ALL:
					result = "ALL";
					break;
			}

			return result;
		}
		
	    override public function clone():Event 
		{
			return new LogEvent(message, level);
		}
		
		override public function toString():String 
		{ 
			return formatToString("LogEvent", "message", "level"); 
		}	
	}	
}