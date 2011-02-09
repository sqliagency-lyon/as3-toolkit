package com.sqliagency.as3.core
{
	import com.sqliagency.as3.events.CloseEvent;

	[Event(name="mouseDownOutside", type="com.sqliagency.as3.events.PopupMouseEvent")]
	
	/**
	 * IPopUp
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IPopUp extends IDisplayObject, IDisposable
	{
		function close(event:CloseEvent=null):void;
	}
}