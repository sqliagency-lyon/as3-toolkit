package com.sqliagency.as3.logging.targets 
{
	
	import com.sqliagency.as3.core.core_internal;
	use namespace core_internal;
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 * @created 01/06/2009
	 */ 
	public class TraceTarget extends LineFormattedTarget 
	{		
		override core_internal function internalLog(message:String):void 
		{
			trace(message);
		}
	}
}