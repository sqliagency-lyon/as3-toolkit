package com.sqliagency.as3.utils
{

	/**
	 * StringUtil
	 * Classe utilitaire pour les chaines de caractères.
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class StringUtil
	{
		/**
		 * Enlève tout espace blanc en début et en fin de chaine de caractères.
		 * @param value
		 * @return la chaine de caractère formatée
		 */
		public static function trim(value:String):String
		{
			if (!value)
			{
				return "";
			}
			
			var pattern:RegExp=/^\s+|\s+$/g;

			var result:String = value.replace(pattern, "");
			
			return result;
		}

		/**
		 * Transforme une chaine de caractères en Boolean.
		 *
		 * @param value Une chaine de caractères
		 * @return vrai ou faux ou null
		 */
		public static function toBoolean(value:String):Object
		{
			if (!value)
				return null;

			var result:Object=false;

			value=value.toLowerCase();

			if (value == "true" || value == "yes" || value == "1")
			{
				result=true;
			}
			else if (value == "false" || value == "no" || value == "0")
			{
				result=false;
			}

			return result;
		}

		/**
		 * Transforme une chaine de caractères de types paramètres (ex :"id=7&rub=8&open=true") en objet.
		 *
		 * @param value la chaine de caractère.
		 * @return objet formaté
		 */
		public static function toObject(value:String):Object
		{
			if (!value)
				return null;

			var object:Object=new Object();
			var varsArray:Array=value.split("&");

			for each (var value:String in varsArray)
			{
				var index:int=value.indexOf("=");
				var propName:String=value.substr(0, index);
				var propValueString:String=value.substr(index + 1);
				object[propName]=Number(propValueString) || toBoolean(propValueString) || propValueString;
			}

			return object;
		}

		public static function isEmpty(value:String):Boolean
		{
			return (value == null || trim(value) == "");
		}
		
		public static function replaceArguments(phrase:String, params:Array):String {
			for (var i:int = 0; i < params.length; i++) {
				var repl:Object = params[i];
				phrase = phrase.replace("{" + i + "}", repl);
			}
			
			return phrase;
		}
	}
}