package com.sqliagency.as3.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * PopupMouseEvent
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class PopupMouseEvent extends MouseEvent
	{
		public static const MOUSE_DOWN_OUTSIDE:String = "mouseDownOutside";
		
		public function PopupMouseEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new PopupMouseEvent(type);
		}
		
		public static function createEvent(event:MouseEvent, type:String):PopupMouseEvent
		{
			var evt:PopupMouseEvent = new PopupMouseEvent(type);
			evt.altKey = event.altKey;
			evt.buttonDown = event.buttonDown;
			evt.ctrlKey = event.ctrlKey;
			evt.delta = event.delta;
			evt.localX = event.localX;
			evt.localY = event.localY;
			evt.relatedObject = event.relatedObject;
			evt.shiftKey = event.shiftKey;
			
			return evt;
		}
	}
}