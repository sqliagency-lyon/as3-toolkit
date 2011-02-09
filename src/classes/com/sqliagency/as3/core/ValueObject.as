package com.sqliagency.as3.core
{
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ValueObject
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ValueObject implements IComparable, ICloneable, IEquals
	{
		/**
		 * Constructeur.
		 */
		public function ValueObject()
		{
			if (Object(this).constructor === ValueObject)
			{
				throw new IllegalOperationError("ValueObject must not be directly instantiated.");
			}
		}
		
		public function valueOf():Object
		{
			// ABSTRACT Method
			throw new IllegalOperationError("Opération illégale.");
			return null;
		}
		
		public function clone():*
		{
			var generator:Class = ApplicationGlobals.topLevelApplication.loaderInfo.applicationDomain.getDefinition(qualifiedClassName) as Class;
						
			return new ClassFactory(generator, valueOf()).newInstance();
		}
		
		public function equals(value:IComparable):Boolean
		{
			var result:Boolean = getQualifiedClassName(value) == getQualifiedClassName(this);
			
			if (result)
			{
				var thisObject:Object = valueOf();
				var object:Object = value.valueOf();
				
				for (var p:* in object)
				{
					if (thisObject[p] != object[p])
					{
						result = false;
						break;
					}
				}
			}
			
			return result;
		}
		
		public function copy(value:*):Boolean
		{
			var result:Boolean = getQualifiedClassName(value) == getQualifiedClassName(this);
			
			if (result)
			{
				var thisObject:Object = valueOf();
				var object:Object = (value as ValueObject).valueOf();
				
				for (var p:* in object)
				{
					thisObject[p] = object[p];
				}
			}
			
			return result;
		}
		
		private function get qualifiedClassName ():String
		{
			return getQualifiedClassName(this);
		}
		
		private function get className ():String
		{
			var pattern:RegExp = /.*::/;
			
			return qualifiedClassName.replace(pattern, "");
		}
		
		public function toString ():String
		{	
			var properties:String = "";
			
			var object:Object = valueOf();
				
			for (var p:* in object)
			{
				properties += "\n\t" + p + " = " + object[p];
			}
			
			return "[object " + className + "]" + properties;
		}
	}
}