package com.sqliagency.as3.core
{
	import flash.events.IEventDispatcher;

	/**
	 * ISkinnable
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface ISkinnable extends IEventDispatcher
	{
		function get skinClass():Class;
		function set skinClass(value:Class):void;
		function get state():String;
		function set state(value:String):void;
		function invalidateDisplayList():void;
	}
}