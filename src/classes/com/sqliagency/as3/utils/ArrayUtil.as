package com.sqliagency.as3.utils
{
	
	/**
	 * Utilitaire de centralisation de fonctions pour la gestion des tableaux
	 */
	public class ArrayUtil
	{
		/**
		 * Mélange un tableau
		 * 
		 * @param 	tab Le tableau à mélanger
		 * @param	startIndex Indice de départ
		 * @param	endIndex Indice de fin
		 * 
		 * @return	Le tableau mélangé
		 */
		public static function shuffle(tab:Array, startIndex:int = 0, endIndex:int = 0):Array
		{
			if (endIndex == 0) {
				
				endIndex = tab.length - 1;
			}
			
			for (var i:int = endIndex; i > startIndex; i--)
			{
				var randomNumber:int = Math.floor(Math.random() * endIndex) + startIndex;
				
				var tmp:* = tab[i];
				tab[i] = tab[randomNumber];
				
				tab[randomNumber] = tmp;
			}
			
			return tab;
		}
		
		/**
		 * Transforme un objet en tableau
		 * @param obj Objet à transformer en tableau
		 */
		public static function toArray(obj:Object):Array
		{
			if (!obj) 
				return [];
			else if (obj is Array)
				return obj as Array;
			else
				return [ obj ];
		}
		
		/**
		 * Recherche de l'élément d'un tableau
		 * @param item Elément recherché
		 * @param source Tableau où s'effectue la recherche
		 * @return L'index de l'élément dans le tableau (ou -1 si l'élément ne figure pas dans le tableau)
		 */
		public static function getItemIndex(item:Object, source:Array):int
		{
			var n:int = source.length;
			
			for (var i:int = 0; i < n; i++)
			{
				if (source[i] === item)
					return i;
			}
			
			return -1;
		}
		
		/**
		 * Duplique un tableau
		 * @param source Tableau à dupliquer
		 * @return Un tableau
		 */
		public static function clone(source:Array):Array
		{
			return source.concat();
		}
		
		/**
		 * Mélange aléatoirement un tableau
		 * @param value Tableau à mélanger
		 */
		public static function random (value:Array):void
		{
			value.sort(randomSort);
		}
		
		/**
		 * @private
		 */
		private static function randomSort (elementA:Object, elementB:Object):Number
		{
			return (Math.random() > 0.5) ? 1 : -1;
		}
	}
}