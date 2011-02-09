package com.sqliagency.as3.rpc.amf {

	import flash.events.Event;
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;

	import com.sqliagency.as3.rpc.events.*;
	import com.sqliagency.as3.rpc.AbstractInvoker;
	import com.sqliagency.as3.rpc.AsyncToken;
	
	public class AMFService extends AbstractInvoker {
		
		private var _id:String;
		private var _gateway:String;
		private var _resultFunction:Function;
		private var _faultFunction:Function;
		private var _errorFunction:Function;
		
		private var netConnection:NetConnection;
		private var responder:Responder;
		private var methodToCall:String;
		
		public function AMFService(id:String, gateway:String=null):void {
			_id = id;
			this.gateway = gateway;
			
			netConnection = new NetConnection();
			responder = new Responder(resultHandler, faultHandler);
			
			netConnection.objectEncoding = ObjectEncoding.AMF3;
			
			netConnection.addEventListener(NetStatusEvent.NET_STATUS, errorHandler, false, 0, true);
			netConnection.addEventListener(IOErrorEvent.IO_ERROR, errorHandler, false, 0, true);
			netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler, false, 0, true);
			netConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, errorHandler, false, 0, true);
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get gateway():String {
			return _gateway;
		}
		
		public function set gateway(value:String):void {
			_gateway = value;
		}
		
		public function set resultFunction(value:Function):void {
			_resultFunction = value;
			
			if (value != null) {
				addEventListener(ResultEvent.RESULT, _resultFunction, false, 0, true);
			}
			else {
				removeEventListener(ResultEvent.RESULT, _resultFunction, false);
			}
		}
		
		public function set faultFunction(value:Function):void {
			_faultFunction = value;
			
			if (value != null) {
				addEventListener(FaultEvent.FAULT, _faultFunction, false, 0, true);
			}
			else {
				removeEventListener(FaultEvent.FAULT, _faultFunction, false);
			}
		}
		
		public function set errorFunction(value:Function):void {
			_errorFunction = value;
		}
		
		public function send(request:AMFRequest):AsyncToken {
			methodToCall = request.methodName;
			return invoke(request.parameters);
		}
		
		override protected function internalSend(parameters:Object):void {
			if (!netConnection.connected && gateway != null)
				netConnection.connect(gateway);
				
			netConnection.call(methodToCall, responder, parameters);
		}
		
		protected function errorHandler(event:Event):void {
			if (_errorFunction != null)
				_errorFunction(event);
			else
				trace(event);
		}
		
		public function destroy():void {
			resultFunction = null;
			faultFunction = null;
			errorFunction = null;
			netConnection.removeEventListener(NetStatusEvent.NET_STATUS, errorHandler, false);
			netConnection.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler, false);
			netConnection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler, false);
			netConnection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, errorHandler, false);
			netConnection = null;
			responder = null;
			clearResult();
		}
	}
}