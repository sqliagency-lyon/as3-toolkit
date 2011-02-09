package com.sqliagency.as3.rpc.amf {
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class AMFRequest {
		
		private var _methodName:String;
		private var _parameters:Object;
		
		public function AMFRequest(methodName:String="", parameters:Object=null) {
			_methodName = methodName;
			_parameters = parameters;
		}
		
		public function get methodName():String {
			return _methodName;
		}
		
		public function set methodName(value:String):void {
			_methodName = value;
		}
		
		public function get parameters():Object {
			return _parameters;
		}
		
		public function set parameters(value:Object):void {
			_parameters = value;
		}
	}
}