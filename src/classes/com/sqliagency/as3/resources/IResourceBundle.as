package com.sqliagency.as3.resources 
{
	/**
	 * IResourceBundle
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IResourceBundle
	{
		function get bundleName():String;
 	 	function get content():Object;
 	 	function get locale():String;
	}
}