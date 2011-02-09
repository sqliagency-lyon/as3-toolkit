package com.sqliagency.as3.skins
{
	import com.sqliagency.as3.core.IDisposable;
	import com.sqliagency.as3.core.IResizable;
	import com.sqliagency.as3.core.ISkinnable;
	
	import flash.display.InteractiveObject;

	/**
	 * ISkin
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface ISkin extends IDisposable
	{
		//function get target():ISkinnable;
		//function set target(value:ISkinnable):void;
		
		function get state():String;
		function set state(value:String):void;
		
		function getSkinElement(skinName:String):InteractiveObject;
		
		function invalidateDisplayList():void;
	}
}