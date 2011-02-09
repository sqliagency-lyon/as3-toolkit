package com.sqliagency.as3.rpc.events {

	import com.sqliagency.as3.rpc.AsyncToken;
	import flash.events.Event;

	/**
	* The base class for events that RPC services dispatch.
	*/
	public class AbstractEvent extends Event {
	
		private var _token:AsyncToken;

		/**
		* @private
		*/
		public function AbstractEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, token:AsyncToken = null) {
			super(type, bubbles, cancelable);
			_token = token;
		}

		/**
		* The token that represents the call to the method. Used in the asynchronous completion token pattern.
		*/
		public function get token():AsyncToken {
			return _token;
		}

		/**
		* Does nothing by default.
		*/
		public function callTokenResponders():void { }
	}
}