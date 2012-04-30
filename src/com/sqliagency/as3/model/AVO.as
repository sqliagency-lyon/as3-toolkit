package com.sqliagency.as3.model
{
	public class AVO
	{
		/**
		 * AVO
		 * @author djim
		 */
		
		/**
		 * __construct
		 *  @param obj Target object
		 */		
		public function AVO(obj:Object = null)
		{
			var val:Object;
			for (var key:String in obj) 
			{
				val = obj[key];
				
				this[key] = val;
			}
		}
	}
}