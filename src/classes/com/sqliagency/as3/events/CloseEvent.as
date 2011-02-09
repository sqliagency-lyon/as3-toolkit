package com.sqliagency.as3.events
{
	import flash.events.Event;
	
	public class CloseEvent extends Event 
	{
		public static const CLOSE:String = "CloseEvent.CLOSE";
		
		private var _detail:int;
		
		public function CloseEvent(type:String, detail:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_detail = detail;
		}
		
		public function get detail():int
		{
			return _detail;
		}
		
		public override function clone():Event
		{ 
			return new CloseEvent(type, detail, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CloseEvent", "type", "detail", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}