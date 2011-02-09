package com.sqliagency.as3.reflect
{
	import com.sqliagency.as3.collections.DictionaryMap;
	import com.sqliagency.as3.collections.IMap;

	public class Metadata
	{
		public var name:String;
		public var args:IMap;
		public var assignedTo:IMetadataAware;
		
		public function Metadata()
		{
			args = new DictionaryMap();
		}
	}
}