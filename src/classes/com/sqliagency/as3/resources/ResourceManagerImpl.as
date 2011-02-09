package com.sqliagency.as3.resources
{
	import com.sqliagency.as3.core.Singleton;
	import com.sqliagency.as3.resources.IResourceBundle;
	import com.sqliagency.as3.resources.IResourceManager;
	
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	public class ResourceManagerImpl implements IResourceManager
	{
		private var map:Dictionary;
		private var locales:Array;
		
		private static var instance:ResourceManagerImpl;
		
		public function ResourceManagerImpl()
		{
		}
		
		public static function getInstance():ResourceManagerImpl
		{
			if (!instance)
			{
				instance = new ResourceManagerImpl();
			}
			
			return instance;
		}
		
		public function addResourceBundle(resourceBundle:IResourceBundle):void
		{
			if (!map)
				map = new Dictionary();
			
			if (!locales)
				locales = [];
			
			map[resourceBundle.bundleName + "_" + resourceBundle.locale] = resourceBundle;
			
			if (locales.indexOf(resourceBundle.locale) < 0) 
				locales.push(resourceBundle.locale);
		}
		
		public function getString(bundleName:String, resourceName:String, parameters:Array = null, locale:String = ""):String
		{
			var str:String = "";
			
			if (!map)
			{
				return str;
			}
			
			if (!locale || locale == "")
			{
				locale = getLocales()[0];
			}
			
			var resourceBundle:IResourceBundle = map[bundleName + "_" + locale];
			
			if (resourceBundle)
			{
				str = resourceBundle.content[resourceName] as String;
			}
			
			if (!parameters)
			{
				parameters = [];
			}
			
			if (str == null) {
				trace("Warning: ResourceManager > getString('" + resourceName + "') renvoie null");
			} else {
				for (var i:int = 0; i < parameters.length; i++)
				{
					var repl:Object = parameters[i];
					str = str.replace("{" + i + "}", repl);
				}
			}
			
			return str;
		}
		
		public function getStringArray(bundleName:String, resourceName:String, locale:String = ""):Array
		{
			var arr:Array = [];
			
			if (!map)
			{
				return arr;
			}
			
			if (!locale || locale == "")
			{
				locale = getLocales()[0];
			}
			
			var resourceBundle:IResourceBundle = map[bundleName + "_" + locale];
			
			if (resourceBundle)
			{
				arr = resourceBundle.content[resourceName] as Array;
			}
			
			return arr;
		}
		
		public function getLocales():Array
		{
			return locales.concat();
		}
	}
}