package com.sqliagency.as3.rpc {
	
	import flash.events.EventDispatcher;
	import com.sqliagency.as3.rpc.events.ResultEvent;
	import com.sqliagency.as3.rpc.events.FaultEvent;
	
	public class AsyncToken extends EventDispatcher {
		
		private var  _parameters:Object;
		private var _responders:Array;
		private var _result:Object;
		
		public function AsyncToken(parameters:Object=null) {
			_parameters = parameters;
		}
		
		public function get parameters():Object {
			return _parameters;
		}
		
		public function set parameters(value:Object):void {
			_parameters = value;
		}
	
		public function get responders():Array {
			return _responders;
		}
		
		public function get result():Object {
			return _result;
		}
		
		public function addResponder(responder:IResponder):void {
			if (_responders == null)
				_responders = [];

			_responders.push(responder);
		}
		
		public function hasResponder():Boolean {
			return (_responders != null && _responders.length > 0);
		}
		
		public function applyFault(event:FaultEvent):void {
			if (_responders != null) {
				for (var i:uint = 0; i < _responders.length; i++) {
					var responder:IResponder = _responders[i];
					if (responder != null) {
						responder.fault(event);
					}
				}
			}
		}
		
		public function applyResult(event:ResultEvent):void {
			setResult(event.result);

			if (_responders != null) {
				for (var i:uint = 0; i < _responders.length; i++) {
					var responder:IResponder = _responders[i];
					if (responder != null) {
						responder.result(event);
					}
				}
			}
		}
		
		private function setResult(newResult:Object):void {
			if (_result !== newResult) {
				//var event:PropertyChangeEvent = PropertyChangeEvent.createUpdateEvent(this, "result", _result, newResult);
				//dispatchEvent(event);
				_result = newResult;
			}
		}
	}
}