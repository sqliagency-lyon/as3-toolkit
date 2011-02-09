package com.sqliagency.as3.loaders
{
	import com.sqliagency.as3.core.IDisposable;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * URLLoader
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class URLLoader extends EventDispatcher implements ILoader
	{
		private var _loader:flash.net.URLLoader;
		private var _data:*;
		private var _dataFormat:String = URLLoaderDataFormat.TEXT;
		
		/**
		 * Constructeur.
		 */
		public function URLLoader()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get bytesLoaded():uint
		{
			return (_loader) ? _loader.bytesLoaded : 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get bytesTotal():uint
		{
			return (_loader) ? _loader.bytesTotal : 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get data():*
		{
			return _data;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get dataFormat():String
		{
			return _dataFormat;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set dataFormat(value:String):void
		{
			_dataFormat = value;
			
			if (_loader)
				_loader.dataFormat = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function load(url:String, context:LoaderContext=null):void
		{
			close();
			addLoader();
			
			try
			{
				_loader.load(new URLRequest(url));
			}
			catch (err:Error)
			{
				// ...
			}
		}
		
		/**
		 * Gère chargement de fichier.
		 * @param event événement dispatché.
		 */
		protected function onLoad(event:Event):void
		{
			switch(event.type)
			{
				case Event.COMPLETE:
					_data = _loader.data;
					removeLoader();
					break;
				
				case Event.OPEN:
					break;
				
				case HTTPStatusEvent.HTTP_STATUS:
					break;
				
				case IOErrorEvent.IO_ERROR:
					break;
				
				case ProgressEvent.PROGRESS:
					break;
				
				default:
					// ...
					break;
			}
			
			dispatchEvent(event);
		}
		
		/**
		 * @inheritDoc
		 */
		public function close():void
		{
			if (_loader)
			{
				try
				{
					_loader.close();
				}
				catch (err:Error)
				{
					// ...
				}
				
				removeLoader();
			}
		}
		
		/**
		 * Ajoute des listeners sur le loader interne.
		 */
		private function addLoader():void
		{
			_loader = new flash.net.URLLoader();
			_loader.dataFormat = _dataFormat;
			_loader.addEventListener(Event.COMPLETE, onLoad, false, 0, true);
			_loader.addEventListener(Event.OPEN, onLoad, false, 0, true);
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onLoad, false, 0, true);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onLoad, false, 0, true);
			_loader.addEventListener(ProgressEvent.PROGRESS, onLoad, false, 0, true);
		}
		
		/**
		 * Supprime les listeners sur le loader interne.
		 */
		private function removeLoader():void
		{
			_loader.removeEventListener(Event.COMPLETE, onLoad, false);
			_loader.removeEventListener(Event.OPEN, onLoad, false);
			_loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onLoad, false);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onLoad, false);
			_loader.removeEventListener(ProgressEvent.PROGRESS, onLoad, false);
			_loader = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			close();
			_data = null;
		}
	}
}