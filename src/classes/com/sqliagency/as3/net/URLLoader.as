package com.sqliagency.as3.net
{	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import com.sqliagency.as3.core.IEventListener;
	import com.sqliagency.as3.core.IDisposable;
	
	/**
	 * URLLoader avec gestion du timeout
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 * @created 30/05/2009
	 * @modified 20/09/2009
	 * 
	 */
	public class URLLoader extends flash.net.URLLoader implements IEventListener, IDisposable
	{	
		private var _isLoading:Boolean;
		private var _requestTimeout:int;
		private var _timeoutTimer:Timer;
		private var _url:String;
		
		/**
		 * Constructeur
		 */
		public function URLLoader()
		{
			super();
			_isLoading = false;
			_requestTimeout = 1000;
			_timeoutTimer = new Timer(_requestTimeout, 1);
			addEventListeners();
		}
		
		override public function load(request:URLRequest):void
		{
			if (!request || isLoading) return;
			
			_isLoading = true;
			bytesLoaded = 0;
			bytesTotal = 0;
			data = null;
			_timeoutTimer.reset();
			_timeoutTimer.delay = requestTimeout;
			_timeoutTimer.start();
			_url = request.url;
			super.load(request);
		}
		
		
		override public function close():void
		{
			try
			{
				super.close();
			}
			catch (err:Error)
			{
			}
		}
		
		public function get isLoading():Boolean {
			return _isLoading;
		}
		
		public function get requestTimeout():int {
			return _requestTimeout;
		}
		
		public function set requestTimeout(value:int):void {
			_requestTimeout = value;
		}
		
		private function dispactchErrorEvent(text:String):void {
			var event:ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
			event.text = text;
			dispatchEvent(event);
		}
		
		private function convertData():void {
			
			switch(dataFormat) {
				case URLLoaderDataFormat.TEXT:
				case URLLoaderDataFormat.VARIABLES:
				case URLLoaderDataFormat.BINARY:
					break;
					
				case URLLoaderDataFormat.XML:
					var xml:XML = new XML(data);
					XML.ignoreWhitespace = true;
					break;
			}
		}
		
		// -------------------------------------------- Gestion des events -------------------------------------------- //
		
		private function timeoutTimerHandler(event:TimerEvent):void {
			_isLoading = false;
			close();
			dispactchErrorEvent("Délai d'attente dépassé pour le fichier " + _url);
		}
		
		private function progressHandler(event:ProgressEvent):void {
			_timeoutTimer.stop();
		}
		
		private function completeHandler(event:Event):void {
			_isLoading = false;
			convertData();
		}
		
		private function errorHandler(event:ErrorEvent):void {
			_isLoading = false;
			_timeoutTimer.stop();
			dispactchErrorEvent(event.text);
		}
		
		// -------------------------------------------- Implémentation de IEventListener -------------------------------------------- //
		
		public function addEventListeners():void
		{
			_timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timeoutTimerHandler, false, 0, true);
			addEventListener(ProgressEvent.PROGRESS, progressHandler, false, 0, true);
			addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
			addEventListener(IOErrorEvent.IO_ERROR, errorHandler, false, 0, true);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler, false, 0, true);
		}
		
		public function removeEventListeners():void
		{
			_timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, timeoutTimerHandler, false);
			removeEventListener(ProgressEvent.PROGRESS, progressHandler, false);
			removeEventListener(Event.COMPLETE, completeHandler, false);
			removeEventListener(IOErrorEvent.IO_ERROR, errorHandler, false);
			removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler, false);
		}
		
		// -------------------------------------------- Implémentation de IDisposable -------------------------------------------- //
		
		public function dispose():void
		{
			close();
			removeEventListeners();
			_timeoutTimer = null;
			data = null;
		}
	}
}