package com.sqliagency.as3.loaders 
{
	import flash.events.EventDispatcher;

	/**
	 * LoadableFile
	 * @author Nicolas CHENG (sqliagency)
	 */
	internal class LoadableFile extends EventDispatcher implements ILoadableFile
	{
		// variables
		private var _url:String;
		private var _dataType:String;
		private var _useCache:Boolean;
		private var _data:*;
		private var _loader:ILoader;
		
		public function set url(value:String):void
		{
			_url = value;
		}
		
		public function set dataType(value:String):void
		{
			_dataType = value;
		}
		
		public function set useCache(value:Boolean):void
		{
			_useCache = value;
		}
		
		public function setData(value:*):void
		{
			_data = value;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get dataType():String
		{
			return _dataType;
		}
		
		public function get useCache():Boolean
		{
			return _useCache;
		}
		
		public function getData():*
		{
			return _data;
		}
		
		public function valueOf():Object
		{
			return _url;
		}
		
		public function get loader():ILoader
		{
			return _loader;
		}
		
		public function set loader(value:ILoader):void
		{
			_loader = value;			
		}
	}
}