package com.sqliagency.as3.core
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * IChildList
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IChildList
	{
		function get numChildren():int;
		function addChild(child:DisplayObject):DisplayObject;
		function addChildAt(child:DisplayObject, index:int):DisplayObject;
		function contains(child:DisplayObject):Boolean;
		function getChildAt(index:int):DisplayObject;
		function getChildByName(name:String):DisplayObject;
		function getChildIndex(child:DisplayObject):int;
		function getObjectsUnderPoint(point:Point):Array;
		function removeChild(child:DisplayObject):DisplayObject;
		function removeChildAt(index:int):DisplayObject;
		function setChildIndex(child:DisplayObject, newIndex:int):void;
	}
}