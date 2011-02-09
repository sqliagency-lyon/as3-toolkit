package com.sqliagency.as3.managers
{
	import com.sqliagency.as3.core.IToolTip;
	
	import flash.display.DisplayObject;
	
	/**
	 * IToolTipManager
	 */
	public interface IToolTipManager
	{
		function get currentTarget():DisplayObject;
		function set currentTarget(value:DisplayObject):void;

		function get currentToolTip():IToolTip;
		function set currentToolTip(value:IToolTip):void;
		
		function get enabled():Boolean;
		function set enabled(value:Boolean):void;
		
		function get hideDelay():Number;
		function set hideDelay(value:Number):void;
		
		function get showDelay():Number;
		function set showDelay(value:Number):void;
		
		function get toolTipClass():Class;
		function set toolTipClass(value:Class):void;
		
		//function registerToolTip(target:DisplayObject, oldToolTip:String, newToolTip:String):void;
		//function sizeTip(toolTip:IToolTip):void;
		
		function showToolTip(toolTip:IToolTip):void;
		function hideToolTip(toolTip:IToolTip):void;
		
		function createToolTip(text:String, x:Number, y:Number, target:DisplayObject=null):IToolTip;
		function destroyToolTip(value:*=null):void;
	}
}