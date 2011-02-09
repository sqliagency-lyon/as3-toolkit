package com.sqliagency.as3.reflect
{
	import com.sqliagency.as3.collections.ArrayList;
	import com.sqliagency.as3.collections.IList;

	/**
	 * Method
	 * 
	 * <method name="stopDrag" declaredBy="flash.display::Sprite" returnType="void"/>
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class Method
	{
		public var name:String;
		public var declaredBy:String;
		public var returnType:String;
		public var parameters:IList;
		
		public function Method()
		{
			parameters = new ArrayList();
		}
	}
}