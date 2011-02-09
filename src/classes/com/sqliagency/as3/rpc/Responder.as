package com.sqliagency.as3.rpc {
	
	public class Responder implements IResponder {
		
		private var _resultHandler:Function;
		private var _faultHandler:Function;
		
		public function Responder(result:Function, fault:Function) {
			_resultHandler = result;
			_faultHandler = fault;
		}
	
		public function result(data:Object):void {
			_resultHandler(data);
		}
		
		public function fault(info:Object):void {
			_faultHandler(info);
		}
	}
}