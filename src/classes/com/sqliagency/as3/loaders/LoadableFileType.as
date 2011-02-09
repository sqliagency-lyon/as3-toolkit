package com.sqliagency.as3.loaders 
{
	/**
	 * LoadableFileType
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class LoadableFileType 
	{
		public static const BINARY:String = "binary";
		public static const TEXT:String = "text";
		public static const VARIABLES:String = "variables";
		
		public static const SWF:String = "swf";
		public static const XML:String = "xml";
		public static const IMG:String = "img";
		
		public static const ALL:Array = [
			LoadableFileType.BINARY,
			LoadableFileType.TEXT,
			LoadableFileType.VARIABLES,
			LoadableFileType.SWF,
			LoadableFileType.XML,
			LoadableFileType.IMG
		];
	}
}