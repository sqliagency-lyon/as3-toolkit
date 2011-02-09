package com.sqliagency.as3.utils
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import com.sqliagency.as3.formatters.NumberFormatter;
	
	/**
	 * Classe permettant d'avoir un tableau de valeurs associées à des dates triées
	 * 
	 * Voici un exemple d'utilisation:
	 * 
	 * var _dateMap:DateMap = new DateMap();
	 * 
	 * _dateMap.push(new Date(2009, 2, 3), 80.1);		
	 * _dateMap.push(new Date(2009, 1, 14), 80.2);
	 * _dateMap.push(new Date(2008, 2, 6), 80.3);
	 * _dateMap.push(new Date(2009, 2, 4), 80.4);
	 * _dateMap.push(new Date(2009, 2, 25), 80.5);
	 * _dateMap.push(new Date(2009, 2, 24), 80.6);
	 * _dateMap.push(new Date(2009, 2, 23), 80.7);
	 * _dateMap.push(new Date(2009, 2, 10), 80.8);
	 * _dateMap.push(new Date(2009, 1, 20), 80.9);
	 * _dateMap.push(new Date(2009, 1, 1), 81);
	 * _dateMap.push(new Date(2009, 2, 3), 82);			Cette entrée écrase une entrée déjà existante pour la date du 03 mars 2009
	 * 
	 * trace (_dateMap); donne le résultat suivant :	Les entrées dates sont triées ASC
	 * 					[object DateMap]
	 * 						length = 10
	 * 						2008-03-06 => 80.3
 	 * 						2009-02-01 => 81
	 * 						2009-02-14 => 80.2
	 * 						2009-02-20 => 80.9
	 * 						2009-03-03 => 82
	 * 						2009-03-04 => 80.4
	 * 						2009-03-10 => 80.8
	 * 						2009-03-23 => 80.7
	 * 						2009-03-24 => 80.6
	 * 						2009-03-25 => 80.5
	 * 
	 * trace (_dateMap.next(new Date(2009,2,3)));		On désire obtenir la valeur contenu à la date suivante du 03 mars 2009
	 * 						80.4
	 * trace (_dataMap.next());							On désire obtenir la valeur suivante à celle précédemment obtenue
	 * 						80.8						Cette valeur corresponds à celle contenue à la date du 10 mars 2009
	 * 
	 * resetEnumeration();								Replace le curseur interne à la première valeur (à la date la plus antérieure)
	 * 
	 * trace (previous());
	 * 						undefined					Il n'y a aucune date et valeur lorsque le curseur se trouve au début du tableau
	 * 
	 * trace (_dateMap.previous(new Date(2009,2,3)));	On désire obtenir la valeur contenu à la date précédente du 03 mars 2009
	 * 						80.9 
	 * 
	 * Remarque : La recherche d'une date (la plus proche antérieurement) est fait par dichotomie
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class DateMap
	{
		protected var arrAssoc:Dictionary;
		protected var arrIndex:Array;
		protected var cursor:int;
		
		public static const IN:int = 0;
		public static const BEFORE:int = -1;
		public static const AFTER:int = 1;
		protected const NONE:int = -2;		// valeur indiquant qu'il n'existe aucun cursor pour une date donnée
		
		public function DateMap () 
		{
			arrAssoc = new Dictionary();
			arrIndex = new Array();
			cursor = -1;
		}
		
		/**
		 * Fonction qui retourne la longueur du tableau associatif
		 */
		public function get length ():int
		{
			return arrIndex.length;
		}
		
		/**
		 * Teste l'existence d'une valeur à une date donnée
		 * Note : Pour savoir si une date est ou non comprise dans l'interval des dates du tableau, il faut utiliser isOutOfRange
		 * @param date
		 * @return true ou false
		 * 
		 * @see isOutOfRange()
		 */
		public function hasValueAt (date:Date):Boolean
		{
			var strDate:String = formatDate(date);
			return (arrAssoc[strDate] != undefined);
		}
		
		/**
		 * Insertion d'une nouvelle valeur à une date donnée
		 * @param	date
		 * @param	value
		 */
		public function push (date:Date, value:*):void
		{
			var strDate:String = formatDate(date);
			
			arrAssoc[strDate] = value;
				
			if (arrIndex.indexOf(strDate) < 0)
				arrIndex.push(strDate);
		}
		
		/**
		 * Retourne une valeur à une date donnée
		 * @param	date
		 * @return valeur ou undefined
		 */
		public function getValueAt (date:Date):*
		{
			var strDate:String = formatDate(date);
			
			return arrAssoc[strDate];
		}
		
		/**
		 * Fonction qui retourne la première valeur.
		 *
		 * @return  valeur
		 */
		public function first ():*
		{
			var value:* = undefined;
			var sortedArray:Array = arrIndex.sort();
			
			if (length > 0)
			{
				cursor = 0;
				
				value = arrAssoc[sortedArray[cursor]];
			}
			
			return value;
		}
		
		/**
		 * Fonction qui retourne la dernière valeur.
		 *
		 * @return  valeur
		 */
		public function last ():*
		{
			var value:* = undefined;
			var sortedArray:Array = arrIndex.sort();
			
			if (length > 0)
			{
				cursor = length-1;
				
				value = arrAssoc[sortedArray[cursor]];
			}
			
			return value;
		}
		
		/**
		 * Fonction qui retourne la valeur suivante
		 * (optionnal) Date point de départ 
		 * @param	startDate
		 * @return  valeur ou undefined
		 * 
		 * @see resetEnumeration()
		 */
		public function next (startDate:Date=null):*
		{
			var value:*;
			var newcursor:int;
			
			if (startDate)
			{
				newcursor = getCursor(startDate);
				
				if (newcursor == NONE)
				{
					value = undefined;
				}
				else
				{
					cursor = --newcursor;
					value = getNext();
				}
			}
			else
			{
				value = getNext();
			}
			
			return value;
		}
		
		/**
		 * Fonction qui retourne la valeur précédente
		 * (optionnal) Date point de départ 
		 * @param	startDate
		 * @return  valeur ou undefined
		 * 
		 * @see resetEnumeration()
		 */
		public function previous (startDate:Date=null):*
		{
			var value:*;
			var newcursor:int;
			
			if (startDate)
			{
				newcursor = getCursor(startDate);
				
				if (newcursor == NONE)
				{
					value = undefined;
				}
				else
				{
					cursor = newcursor;
					value = getPrevious();
				}
			}
			else
			{
				value = getPrevious();
			}
			
			return value;
		}
		
		
		/**
		 * Retourne une valeur booléenne si oui ou non si il y a une valeur précédente
		 * @return true ou false
		 */
		public function hasPrevious ():Boolean
		{	
			return (cursor - 1 >= 0);
		}
		
		/**
		 * Retourne une valeur booléenne si oui ou non si il y a une valeur suivante
		 * @return true ou false
		 */
		public function hasNext ():Boolean
		{	
			return (cursor + 1 < length);
		}
		
		/**
		 * Réinitialise à la position de départ l'énumération du tableau associatif
		 */
		public function resetEnumeration ():void
		{
			cursor = -1;
		}
		
		/**
		 * @private
		 */
		private function getNext ():*
		{
			var value:*;
			var sortedArr:Array = arrIndex.sort();
			
			if (hasNext())
			{
				value = arrAssoc[sortedArr[cursor + 1]];
				cursor++;
			}
			else
			{
				value = undefined;
			}
			
			return value;
		}
		
		/**
		 * @private
		 */
		private function getPrevious ():*
		{
			var value:*;
			var sortedArr:Array = arrIndex.sort();
			
			if (hasPrevious())
			{
				value = arrAssoc[sortedArr[cursor-1]];
				cursor--;
			}
			else
			{
				value = undefined;
			}
			
			return value;
		}
		
		/**
		 * @private
		 */
		private function getCursor (date:Date):int
		{
			var sortedArray:Array = arrIndex.sort();
			
			var debut:int = 0;
			var fin:int = length;
			var milieu:int = debut + (fin - debut) / 2;
			
			var stop:Boolean = false;
			var tmp:int;
			
			if (isOutOfRange(date) != IN)
			{
				return NONE;
			}
			
			do
			{
				milieu = debut + (fin - debut) / 2;
				tmp = between(date, makeDate(sortedArray[milieu - 1]), makeDate(sortedArray[milieu]));
				
				if (tmp == 0)
				{
					stop = true;
					//trace ("tmp == 0");
				}
				else
				{
					if (tmp > 0)
					{
						//trace ("tmp == 1");
						debut = milieu + 1;
						tmp = between(date, makeDate(sortedArray[debut - 1]), makeDate(sortedArray[debut]));
						
						if (tmp == 0)
						{
							stop = true;
							milieu = debut;
						}
					}
					else
					{
						//trace ("tmp == -1");
						fin = milieu - 1;
						tmp = between(date, makeDate(sortedArray[fin - 1]), makeDate(sortedArray[fin]));
						
						if (tmp == 0)
						{
							stop = true;
							milieu = fin;
						}
					}
				}
			}
			while (!stop && debut < fin);
			
			//milieu = (hasValueAt(date)) ? milieu : milieu - 1;
			
			return milieu;
		}
		
		/**
		 * @private
		 */
		protected function formatDate(date:Date):String
		{
			var s:String = date.fullYear + "-" + NumberFormatter.addLeadingZero(date.month + 1) + "-" + NumberFormatter.addLeadingZero(date.date);
			
			return s;	// YYYY-MM-DD
		}
		
		/**
		 * @private
		 * Fonction comparant 2 dates
		 * Retourne :	 0, d1 = d2
		 * 				 1, d1 > d2
		 * 				-1, d1 < d2
		 * 
		 * @param	d1 Date, première date
		 * @param	d2 Date, deuxième date
		 * @return int, valeau comparative
		 */
		protected function compare (d1:Date, d2:Date):int
		{	
			var i:int = 0;
			
			if (d1.time > d2.time)
				i = 1;
			else if (d1.time < d2.time)
				i = -1;
				
			return i;
		}
		
		/**
		 * Retourne un entier indiquant si une date est dedans (in) ou en-dehors (avant, après)
		 * 
		 * @param	date
		 * @return 	IN, BEFORE, AFTER ou tout autre valeur si la date ne peut pas être comparé
		 */
		public function isOutOfRange (date:Date):int
		{
			if (length <= 0)
			{
				//throw new IllegalOperationError("DateMap > isOutOfRange n'est pas utilisable si il n'y a pas eu un appel précédent à push");
				return NONE;
			}
				
			var sortedArr:Array = arrIndex.sort();
			
			var firstDate:Date = makeDate(sortedArr[0]);
			var lastDate:Date = makeDate(sortedArr[length - 1]);
			
			return between(date,firstDate,lastDate);
		}
		
		/**
		 * @private
		 */
		protected function between (date:Date, firstDate:Date, lastDate:Date):int
		{
			var i:int = 0;
			
			if (compare(date, firstDate) < 0)
				i = -1;
			else if (compare(date, lastDate) > 0)
				i = 1;
			
			return i;
		}
		
		/**
		 * Retourne une date en fonction d'une chaine de caractère
		 * @param date formaté en String par exemple : '2010-03-20'
		 * @return Date une date
		 */
		public function makeDate (value:String):Date
		{
			var tmp:Array = value.split("-");
			
			return new Date(Number(tmp[0]), Number(tmp[1] - 1), Number(tmp[2]));
		}
		
		/**
		 * Représentation String de cet objet
		 */
		public function toString ():String
		{
			var s:String = "[object DateMap]\n\tlength" + " = " + length;
			
			var sortedArr:Array = arrIndex.sort();
			var value:*;
			
			
			for (var i:int = 0; i < length; i++)
			{
				s += "\n\t" + sortedArr[i] + " => " + arrAssoc[sortedArr[i]];
			}
			
			return s;
		}
	}
}