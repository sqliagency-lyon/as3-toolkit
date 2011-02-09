package com.sqliagency.as3.loaders
{
	import com.sqliagency.as3.core.IDisposable;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * Loader
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class Loader extends EventDispatcher implements ILoader
	{
		private var _loader:flash.display.Loader;
		private var _bytesLoaded:uint;
		private var _bytesTotal:uint;
		private var _data:*;
		private var _info:LoaderInfo;
		
		/**
		 * Constructeur.
		 */
		public function Loader()
		{
			super();
		}
		
		/**
		 * Informations sur le chargement
		 */
		public function get info():LoaderInfo
		{
			return _info;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get bytesLoaded():uint
		{
			return _bytesLoaded;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get bytesTotal():uint
		{
			return _bytesTotal;
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
			return "";
		}
		
		/**
		 * @inheritDoc
		 */
		public function set dataFormat(value:String):void
		{
			// ne fait rien
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
				_loader.load(new URLRequest(url), context);
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
					_data = _loader.content;
					removeLoader();
					break;
				
				case Event.INIT:
					break;
				
				case Event.OPEN:
					break;
				
				case HTTPStatusEvent.HTTP_STATUS:
					break;
				
				case IOErrorEvent.IO_ERROR:
					break;
				
				case ProgressEvent.PROGRESS:
					_bytesLoaded = (event as ProgressEvent).bytesLoaded;
					_bytesTotal = (event as ProgressEvent).bytesTotal;
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
			_loader = new flash.display.Loader();
			_info = _loader.contentLoaderInfo;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(Event.INIT, onLoad, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, onLoad, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onLoad, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoad, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoad, false, 0, true);
		}
		
		/**
		 * Supprime les listeners sur le loader interne.
		 */
		private function removeLoader():void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoad, false);
			_loader.contentLoaderInfo.removeEventListener(Event.INIT, onLoad, false);
			_loader.contentLoaderInfo.removeEventListener(Event.OPEN, onLoad, false);
			_loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onLoad, false);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoad, false);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoad, false);
			_loader = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			close();
			_info = null;
		}
	}
}