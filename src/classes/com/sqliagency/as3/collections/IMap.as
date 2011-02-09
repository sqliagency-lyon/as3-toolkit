package com.sqliagency.as3.collections
{
	/**
	 * IMap
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IMap
	{
		function clear():void;
		function containsKey(key:*):Boolean;
		function containsValue(value:*):Boolean;
		function getValue(key:*):*;
		function isEmpty():Boolean;
		function put(key:*, value:*):*;
		function putAll(source:IMap):void;
		function remove(key:*):*;
		function size():int;
		function values():Array;
		function keys():Array;
	}
}