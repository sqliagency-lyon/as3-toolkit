package com.sqliagency.as3.logging
{	
	import flash.events.IEventDispatcher;
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 * @created 01/06/2009
	 * @modified 23/04/2010
	 */
	public interface ILogger extends IEventDispatcher
	{	
		function get category():String;
		function get methodName():String;
		function log(level:int, message:String, ... rest):void;
		function debug(message:String, ... rest):void;
		function error(message:String, ... rest):void;
		function fatal(message:String, ... rest):void;
		function info(message:String, ... rest):void;
		function warn(message:String, ... rest):void;
	}
}