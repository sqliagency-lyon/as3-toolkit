package com.sqliagency.as3.resources
{
	import com.sqliagency.as3.core.Singleton;
	
	import flash.errors.IllegalOperationError;
	
	/**
	 * ResourceManager
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ResourceManager
	{
		private static var _impl:IResourceManager;
		
		public static function getInstance():IResourceManager
		{
			if (!_impl)
			{
				try
				{	
					_impl = IResourceManager(Singleton.getInstance("com.sqliagency.as3.resources::IResourceManager"));
				}
				catch (err:Error)
				{
					_impl = null;
				}
			}
			
			return _impl;
		}
		
		private static function get impl():IResourceManager
		{
			return (_impl) ? _impl : ResourceManager.getInstance();
		}
		
		/**
		 * Constructeur.
		 */
		public function ResourceManager()
		{
			throw new IllegalOperationError("ResourceManager must not be instantiated.");
		}
		
		public function addResourceBundle(resourceBundle:IResourceBundle):void
		{
			if (impl)
				impl.addResourceBundle(resourceBundle);
		}
		
		public function getString(bundleName:String, resourceName:String, parameters:Array = null, locale:String = ""):String
		{
			return (impl) ? impl.getString(bundleName, resourceName, parameters, locale) : "";
		}
		
		public function getStringArray(bundleName:String, resourceName:String, locale:String = ""):Array
		{
			return (impl) ? impl.getStringArray(bundleName, resourceName, locale) : [];
		}
		
		public function getLocales():Array
		{
			return (impl) ? impl.getLocales() : [];
		}
	}
}