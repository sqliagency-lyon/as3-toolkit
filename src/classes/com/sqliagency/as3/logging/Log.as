package com.sqliagency.as3.logging {
	
	import flash.utils.getQualifiedClassName;
	
	import com.sqliagency.as3.logging.errors.InvalidCategoryError;
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 * @created 01/06/2009
	 */
	public class Log {
		
		private static var NONE:int = int.MAX_VALUE;
		private static var _targetLevel:int = NONE;
		private static var _loggers:Array;
		private static var _targets:Array = [];
		
		public function Log() 
		{
		}
		
		public static function isFatal():Boolean {
			return (_targetLevel <= LogEventLevel.FATAL) ? true : false;
		}
		
		public static function isError():Boolean {
			return (_targetLevel <= LogEventLevel.ERROR) ? true : false;
		}

		public static function isWarn():Boolean {
			return (_targetLevel <= LogEventLevel.WARN) ? true : false;
		}

		public static function isInfo():Boolean {
			return (_targetLevel <= LogEventLevel.INFO) ? true : false;
		}
    
		public static function isDebug():Boolean {
			return (_targetLevel <= LogEventLevel.DEBUG) ? true : false;
		}
		
		public static function addTarget(target:ILoggingTarget):void {
			if (target) {
				var filters:Array = target.filters;
				var logger:ILogger;
				// need to find what filters this target matches and set the specified
				// target as a listener for that logger.
				for (var i:String in _loggers) {
					if (categoryMatchInFilterList(i, filters))
						target.addLogger(ILogger(_loggers[i]));
				}
				// if we found a match all is good, otherwise we need to
				// put the target in a waiting queue in the event that a logger
				// is created that this target cares about.
				_targets.push(target);
				
				if (_targetLevel == NONE)
					_targetLevel = target.level
				else if (target.level < _targetLevel)
					_targetLevel = target.level;
			}
			else	{
				throw new ArgumentError("Logging : target is invalid");
			}
		}

		public static function removeTarget(target:ILoggingTarget):void 
		{
			if (target) 
			{
				var filters:Array = target.filters;
				var logger:ILogger;
				// Disconnect this target from any matching loggers.
				for (var i:String in _loggers) {
					if (categoryMatchInFilterList(i, filters)) {
						target.removeLogger(ILogger(_loggers[i]));
					}                
				}
				// Remove the target.
				for (var j:int = 0; j<_targets.length; j++) {
					if (target == _targets[j]) {
						_targets.splice(j, 1);
						j--;
					}
				}
				resetTargetLevel();
			}
			else {
				throw new ArgumentError("Logging : target is invalid");
			}
		}
		
		public static function getLogger(object:Object):ILogger 
		{
			var category:String = getQualifiedClassName(object);
			category = category.replace("::", ".");
			
			checkCategory(category);
			if (!_loggers)
				_loggers = [];

			// get the logger for the specified category or create one if it doesn't exist
			var result:ILogger = _loggers[category];
			
			if (!result) {
				result = new LogLogger(category);
				_loggers[category] = result;
			}

			// check to see if there are any targets waiting for this logger.
			var target:ILoggingTarget;
			for (var i:int = 0; i < _targets.length; i++) 
			{
				target = ILoggingTarget(_targets[i]);
				if (categoryMatchInFilterList(category, target.filters))
					target.addLogger(result);
			}

			return result;
		}

		public static function flush():void 
		{
			_loggers = [];
			_targets = [];
			_targetLevel = NONE;
		}

		public static function hasIllegalCharacters(value:String):Boolean
		{
			return value.search(/[\[\]\~\$\^\&\\(\)\{\}\+\?\/=`!@#%,:;'"<>\s]/) != -1;
		}

		private static function categoryMatchInFilterList(category:String, filters:Array):Boolean
		{
			var result:Boolean = false;
			var filter:String;
			var index:int = -1;
			
			var subcategory:String;
			var subfilter:String;
			
			for (var i:uint = 0; i < filters.length; i++) 
			{
				filter = filters[i];
				// first check to see if we need to do a partial match
				// do we have an asterisk?
				index = filter.indexOf("*");

				if (index == 0)
					return true;

				index = (index < 0) ? category.length : index -1;

				subcategory = category.substring(0, index);
				subfilter = filter.substring(0, index);
				
				if (subcategory == subfilter)
					return true;
			}
			
			return false;
		}

		private static function checkCategory(category:String):void 
		{
			var message:String;

			if (category == null || category.length == 0) 
			{
				throw new InvalidCategoryError("Logging : category is invalid");
			}

			if (hasIllegalCharacters(category) || (category.indexOf("*") != -1)) 
			{
				throw new InvalidCategoryError("Logging : category is invalid");
			}
		}

		private static function resetTargetLevel():void 
		{
			var minLevel:int = NONE;
			for (var i:int = 0; i < _targets.length; i++) {
				if (minLevel == NONE || _targets[i].level < minLevel)
					minLevel = _targets[i].level;
			}
			
			_targetLevel = minLevel;
		}
	}
}