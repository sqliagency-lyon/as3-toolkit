package com.sqliagency.as3.layout 
{
	import com.sqliagency.as3.core.IChildList;
	import com.sqliagency.as3.core.IDisposable;
	
	/**
	 * ILayout
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface ILayout extends IDisposable
	{
		function get target():IChildList;
		function set target(value:IChildList):void;
		function apply():void;
	}
}