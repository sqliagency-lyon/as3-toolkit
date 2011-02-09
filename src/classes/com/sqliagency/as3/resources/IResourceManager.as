package com.sqliagency.as3.resources 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * IResourceManager
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IResourceManager
	{
		function addResourceBundle(resourceBundle:IResourceBundle):void;
		function getString(bundleName:String, resourceName:String, parameters:Array = null, locale:String = ""):String;
		function getStringArray(bundleName:String, resourceName:String, locale:String = ""):Array;
		function getLocales():Array;
	}
}