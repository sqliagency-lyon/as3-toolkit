package com.sqliagency.as3.logging.targets {
	
	import com.sqliagency.as3.core.core_internal;
	import com.sqliagency.as3.logging.AbstractTarget;
	import com.sqliagency.as3.logging.ILogger;
	import com.sqliagency.as3.logging.LogEvent;
	
	use namespace core_internal;
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 * @created 01/06/2009
	 */
	public class LineFormattedTarget extends AbstractTarget 
	{
		public var fieldSeparator:String = " ";
		public var includeCategory:Boolean;
		public var includeDate:Boolean;
		public var includeLevel:Boolean;
		public var includeTime:Boolean;
		public var includeMethodName:Boolean;
		
		public function LineFormattedTarget() 
		{
			super();

			includeTime = false;
			includeDate = false;
			includeCategory = false;
			includeLevel = false;
			includeMethodName = false;
		}
		
		/**
		 *  This method handles a <code>LogEvent</code> from an associated logger.
		 *  A target uses this method to translate the event into the appropriate format for transmission, storage, or display.
		 *  This method is called only if the event's level is in range of the target's level.
		 * 
		 *  @param event The <code>LogEvent</code> handled by this method.
		 */
		override public function logEvent(event:LogEvent):void 
		{
			var date:String = ""
			if (includeDate || includeTime) 
			{
				var d:Date = new Date();
				if (includeDate) 
				{
					date = Number(d.getMonth() + 1).toString() + "/" +
						   d.getDate().toString() + "/" + 
						   d.getFullYear() + fieldSeparator;
				}
				
				if (includeTime) 
				{
					date += padTime(d.getHours()) + ":" +
							padTime(d.getMinutes()) + ":" +
							padTime(d.getSeconds()) + "." +
							padTime(d.getMilliseconds(), true) + fieldSeparator;
				}
			}
			
			var level:String = "";
			if (includeLevel) 
			{
				level = "[" + LogEvent.getLevelString(event.level) + "]" + fieldSeparator;
			}

			var category:String = includeCategory ? ILogger(event.target).category + fieldSeparator : "";

			var methodName:String = "";
			if (includeMethodName) 
			{
				methodName = "[" + ILogger(event.target).methodName + "]" + fieldSeparator;
			}
			
			internalLog(date + level + category + methodName + event.message);
		}
    
		/**
		 *  @private
		 */
		private function padTime(num:Number, millis:Boolean = false):String 
		{
			if (millis) 
			{
				if (num < 10)
					return "00" + num.toString();
				else if (num < 100)
					return "0" + num.toString();
				else 
					return num.toString();
			}
			else 
			{
				return num > 9 ? num.toString() : "0" + num.toString();
			}
		}
		
		core_internal function internalLog(message:String):void {
			// override this method to perform the redirection to the desired output
		}
	}
}