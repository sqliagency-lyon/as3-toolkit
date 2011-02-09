package com.sqliagency.as3.logging.targets
{
	import com.sqliagency.as3.core.core_internal;
	
	import nl.demonsters.debugger.MonsterDebugger;

	use namespace core_internal;
	
	/**
	 * MonsterTarget
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class MonsterTarget extends LineFormattedTarget
	{
		override core_internal function internalLog(message:String):void 
		{
			MonsterDebugger.trace(new Object(), message);
		}
	}
}