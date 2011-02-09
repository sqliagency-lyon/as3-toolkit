package com.sqliagency.as3.resources
{
	/**
	 * ResourceBundle
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ResourceBundle implements IResourceBundle
	{
		private var _bundleName:String;
		private var _content:Object;
		private var _locale:String;
		
		public function ResourceBundle(name:String, locale:String)
		{
			_bundleName = name;
			_locale = locale;
			_content = new Object();
		}
		
		public function get bundleName():String
		{
			return _bundleName;
		}
		
		public function get content():Object
		{
			return _content;
		}
		
		public function get locale():String
		{
			return _locale;
		}
	}
}