package com.sqliagency.as3.core 
{
	import flash.ui.ContextMenu;
	
	[Event(name = "click", 				type = "flash.events.MouseEvent")]
	[Event(name = "doubleClick", 		type = "flash.events.MouseEvent")]
	[Event(name = "focusIn", 			type = "flash.events.FocusEvent")]
	[Event(name = "focusOut", 			type = "flash.events.FocusEvent")]
	[Event(name = "keyDown", 			type = "flash.events.KeyboardEvent")]
	[Event(name = "keyFocusChange", 	type = "flash.events.FocusEvent")]
	[Event(name = "keyUp", 				type = "flash.events.KeyboardEvent")]
	[Event(name = "mouseDown", 			type = "flash.events.MouseEvent")]
	[Event(name = "mouseFocusChange", 	type = "flash.events.FocusEvent")]
	[Event(name = "mouseMove", 			type = "flash.events.MouseEvent")]
	[Event(name = "mouseOut", 			type = "flash.events.MouseEvent")]
	[Event(name = "mouseOver", 			type = "flash.events.MouseEvent")]
	[Event(name = "mouseUp", 			type = "flash.events.MouseEvent")]
	[Event(name = "mouseWheel", 		type = "flash.events.MouseEvent")]
	[Event(name = "rollOut", 			type = "flash.events.MouseEvent")]
	[Event(name = "rollOver", 			type = "flash.events.MouseEvent")]
	[Event(name = "tabChildrenChange", 	type = "flash.events.Event")]
	[Event(name = "tabEnabledChange", 	type = "flash.events.Event")]
	[Event(name = "tabIndexChange", 	type = "flash.events.Event")]
	
	/**
	 * IInteractiveObject
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IInteractiveObject extends IDisplayObject
	{
		function get contextMenu():ContextMenu;
		function set contextMenu(ValueObject:ContextMenu):void;
		
		function get doubleClickEnabled():Boolean;
		function set doubleClickEnabled(value:Boolean):void;
		
		function get focusRect():Object;
		function set focusRect(value:Object):void;
		
		function get mouseEnabled():Boolean;
		function set mouseEnabled(value:Boolean):void;
		
		function get tabEnabled():Boolean;
		function set tabEnabled(value:Boolean):void;
		
		function get tabIndex():int;
		function set tabIndex(value:int):void;
	}
}