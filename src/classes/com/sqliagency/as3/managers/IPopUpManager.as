package com.sqliagency.as3.managers
{
	import com.sqliagency.as3.core.IPopUp;
	import com.sqliagency.as3.core.IUIComponent;
	
	import flash.display.DisplayObject;

	/**
	 * IPopUpManager
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IPopUpManager
	{
		function createPopUp(parent:DisplayObject,
							 className:Class,
							 modal:Boolean = false):IPopUp;
		
		function addPopUp(window:IPopUp,
						  parent:DisplayObject,
						  modal:Boolean = false):void;
		
		function centerPopUp(popUp:IPopUp):void;
		function removePopUp(popUp:IPopUp):void;
		function bringToFront(popUp:IPopUp):void;
		function getLastModalPopUpIndex():int;
	}
}