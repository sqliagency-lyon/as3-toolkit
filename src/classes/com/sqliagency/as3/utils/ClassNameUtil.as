package com.sqliagency.as3.utils
{
	import flash.utils.clearInterval;
	import flash.utils.getQualifiedClassName;

	/**
	 * ClassNameUtil
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ClassNameUtil {
		
		/**
		 * Trouve le nom de classe d'un objet.
		 * @param value
		 * @return le nom de la classe.
		 */
		public static function getQualifiedClassName(value:*):String {
			return flash.utils.getQualifiedClassName(value);
		}
		
		public static function getShortQualifiedClassName(value:*):String {
			var split:Array = ClassNameUtil.getQualifiedClassName(value).split("::");
			
			if (split.length == 2) {
				return split[1];
			} else {
				return split[0];
			}
		}
	}
}