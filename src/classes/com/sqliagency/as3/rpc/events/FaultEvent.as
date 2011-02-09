package com.sqliagency.as3.rpc.events {

	import flash.events.Event;
	import com.sqliagency.as3.rpc.AsyncToken;
	import com.sqliagency.as3.rpc.Fault;

	public class FaultEvent extends AbstractEvent  {
	
		private var _fault:Fault;

		public static const FAULT:String = "fault";

		public function FaultEvent(type:String, fault:Fault = null, token:AsyncToken = null) {
			super(type, false, true, token);
			
			_fault = fault;
		}

		public function get fault():Fault {
			return _fault;
		}

		override public function clone():Event {
			return new FaultEvent(type, fault, token);
		}
		
		override public function toString():String {
			return formatToString("FaultEvent", "fault", "type", "bubbles", "cancelable", "eventPhase");
		}

		override public function callTokenResponders():void {
			if (token != null)
				token.applyFault(this);
		}
	}
}