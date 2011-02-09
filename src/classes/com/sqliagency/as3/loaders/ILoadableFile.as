package com.sqliagency.as3.loaders 
{
	import com.sqliagency.as3.core.IComparable;
	
	import flash.events.IEventDispatcher;

	/**
	 * ILoadableFile
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface ILoadableFile extends IEventDispatcher, IComparable
	{
		function get url():String;
		function get dataType():String;
		function get useCache():Boolean;
		function getData():*;
	}
}