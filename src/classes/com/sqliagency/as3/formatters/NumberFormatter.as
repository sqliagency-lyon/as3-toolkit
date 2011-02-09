package com.sqliagency.as3.formatters
{
	/**
	 * Classe pour formatter des nombres en une chaine de caractères.
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class NumberFormatter 
	{
		/**
		 * Ajoute un zéro pour tout nombre inférieur à 10.
		 * Exemple : 8 devient 08.
		 * @param n nombre.
		 * @return chaine de caractère du nombre formaté.
		 */
		public static function addLeadingZero(n:Number):String
		{
			var s:String = String(n);
			
			if (0 <= n && n <= 9)
			{
				s = "0" + s;
			}
			
			return s;
		}
	}
}