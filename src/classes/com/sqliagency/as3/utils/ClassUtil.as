package com.sqliagency.as3.utils
{
	import com.sqliagency.as3.collections.DictionaryMap;
	import com.sqliagency.as3.collections.IMap;
	import com.sqliagency.as3.errors.ClassNotFoundError;
	import com.sqliagency.as3.reflect.ClassInfo;
	
	import flash.system.ApplicationDomain;
	import flash.utils.getQualifiedClassName;

	/**
	 * ClassUtil
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ClassUtil
	{
		private static const PACKAGE_CLASS_SEPARATOR:String="::";

		/**
		 * Obtient la définition d'une classe.
		 * @param name
		 * @param applicationDomain
		 * @return 
		 * @throws ClassNotFoundError
		 */
		public static function forName(name:String, applicationDomain:ApplicationDomain=null):Class
		{
			applicationDomain=(applicationDomain == null) ? ApplicationDomain.currentDomain : applicationDomain;
			var result:Class;

			while (!applicationDomain.hasDefinition(name))
			{
				if (applicationDomain.parentDomain)
				{
					applicationDomain=applicationDomain.parentDomain;
				}
				else
				{
					break;
				}
			}

			try
			{
				result=applicationDomain.getDefinition(name) as Class;
			}
			catch (err:ReferenceError)
			{
				throw new ClassNotFoundError("A class with the name '" + name + "' could not be found.");
				return null;
			}
			
			return result;
		}

		
		/**
		 * Trouve le nom de classe d'un objet.
		 * @param value
		 * @param replaceColons
		 * @return 
		 */
		public static function getQualifiedClassName(value:*, replaceColons:Boolean=false):String
		{
			var name:String = ClassNameUtil.getQualifiedClassName(value);
			
			if (replaceColons)
			{
				name = name.replace(PACKAGE_CLASS_SEPARATOR, ".");
			}
			
			return name;
		}
		
		/**
		 * Obtient les informations d'une classe.
		 * @param value
		 * @return 
		 */
		public static function getClassInfo(value:Object):ClassInfo
		{
			var className:String = getQualifiedClassName(value, false);
			return ClassInfo.forInstance(className, value);
		}
	}
}