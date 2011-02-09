package com.sqliagency.as3.loaders
{
	/**
	 * IFileExtensionParser
	 * @author Nicolas CHENG
	 */
	public interface IFileExtensionParser
	{
		function getFileExtension(name:String):String;
		function getFileType(name:String):String;
	}
}