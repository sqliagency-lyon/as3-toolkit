package com.sqliagency.as3.utils
{

	import flash.display.DisplayObjectContainer;

	/**
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class DisplayObjectUtil
	{

		static public function removeAllChildren(container:DisplayObjectContainer):void
		{
			while (container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
		}
	}

}