package com.sqliagency.as3.rpc {

	import flash.events.EventDispatcher;
	import flash.events.Event;

	import com.sqliagency.as3.rpc.events.AbstractEvent;
	import com.sqliagency.as3.rpc.events.FaultEvent;
	import com.sqliagency.as3.rpc.events.ResultEvent;

	public class AbstractInvoker extends EventDispatcher {
		
		private var _result:Object;
		private var token:AsyncToken;
		
		public function get lastResult():Object {
			return _result;
		}

		public function clearResult():void {
			_result = null;
		}
		
		protected function invoke(parameters:Object):AsyncToken {
			token = new AsyncToken(parameters);
			internalSend(parameters);
			return token;
		}
		
		protected function internalSend(parameters:Object):void {
		}
	
		protected function dispatchRpcEvent(event:AbstractEvent):void {
			event.callTokenResponders();
			
			if (!event.isDefaultPrevented()) {
				dispatchEvent(event);
			}
		}

		protected function resultHandler(object:Object):void {
			_result = object;
			
			var resultEvent:ResultEvent = new ResultEvent(ResultEvent.RESULT, _result, token);
			dispatchRpcEvent(resultEvent);
		}

		protected function faultHandler(object:Object):void {
			var fault:Fault = new Fault(object.code, object.description, object.details);
			var faultEvent:FaultEvent = new FaultEvent(FaultEvent.FAULT, fault, token);
			dispatchRpcEvent(faultEvent);
		}
	}
}