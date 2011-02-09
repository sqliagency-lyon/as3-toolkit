package com.sqliagency.as3.rpc {
	
	public class Fault extends Error {
		
		public var content:Object;
		public var rootCause:Object;
		
		protected var _faultCode:String;
		protected var _faultString:String;
		protected var _faultDetail:String;
		
		public function Fault(faultCode:String, faultString:String, faultDetail:String = null) {
			super("faultCode:" + faultCode + " faultString:'" + faultString + "' faultDetail:'" + faultDetail + "'");
			
			this._faultCode = faultCode;
			this._faultString = faultString ? faultString : "";
			this._faultDetail = faultDetail;
		}
		
		public function get faultCode():String {
			return _faultCode;
		}

		public function get faultDetail():String {
			return _faultDetail;
		}

		public function get faultString():String {
			return _faultString;
		}
		
		public function toString():String {
			var s:String = "[RPC Fault";
			s += " faultString=\"" + faultString + "\"";
			s += " faultCode=\"" + faultCode + "\"";
			s += " faultDetail=\"" + faultDetail + "\"]";
			return s;
		}	
	}	
}