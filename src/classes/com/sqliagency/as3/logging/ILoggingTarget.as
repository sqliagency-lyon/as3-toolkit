package com.sqliagency.as3.logging {
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 * @created 01/06/2009
	 */
	public interface ILoggingTarget {
		
		function get filters():Array;
		function set filters(value:Array):void;
		function get level():int;
		function set level(value:int):void;
		function addLogger(logger:ILogger):void;
		function removeLogger(logger:ILogger):void;
	}	
}