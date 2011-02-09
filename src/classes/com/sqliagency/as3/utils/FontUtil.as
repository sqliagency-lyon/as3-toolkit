package com.sqliagency.as3.utils {
	
	import flash.text.Font;
	
	/**
	 * Classe utilitaire pour les polices (fonts).
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 * @created 28/11/2009
	 * 
	 */
	public class FontUtil {
		
		/**
		 * Récupèrer la liste des fonts embarqués ou non
		 * @param	embed
		 * @return collection de fonts
		 */
		public static function browse(embed:Boolean):Array {
			return Font.enumerateFonts(embed).sortOn("fontName");
		}
	}	
}