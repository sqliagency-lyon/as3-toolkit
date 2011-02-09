package com.sqliagency.as3.events 
{
	import flash.events.Event;
	
	/**
	 * UIEvent
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class UIEvent extends Event 
	{
		public static const INITIALIZED:String = "uiInitialized";
		public static const DISPOSED:String = "uiDisposed";
		
		public function UIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		override public function clone():Event 
		{ 
			return new UIEvent(type, bubbles, cancelable);
		}
		
		override public function toString():String 
		{ 
			return formatToString("UIEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}