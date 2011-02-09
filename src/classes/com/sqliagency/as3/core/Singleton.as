package com.sqliagency.as3.core
{	
	public class Singleton
	{
		private static var classMap:Object = {};
		
		public static function registerClass(interfaceName:String, clazz:Class):void
		{
			var c:Class = classMap[interfaceName];
			if (!c)
				classMap[interfaceName] = clazz;
		}
		
		public static function getInstance(interfaceName:String):Object
		{
			var c:Class = classMap[interfaceName];
			
			if (!c)
			{
				throw new Error("No class registered for interface '" + interfaceName + "'.");
			}
			
			return c["getInstance"]();
		}
	}
}