package com.sqliagency.as3.ui
{
	/**
	 * ICursorManager
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface ICursorManager
	{
		function get currentID():int;
		function showCursor():void;
		function hideCursor():void;
		function setCursor(cursorClass:Class, priority:int=2, xOffset:Number = 0, yOffset:Number = 0):void;
		function setBusyCursor():void;
		function removeBusyCursor():void;
	}
}