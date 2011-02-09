package com.sqliagency.as3.utils
{

	/**
	 * NumberUtil
	 * Classe Utilitaire pour les nombres.
	 * @author Nicolas CHENG (sqliagency)
	 *
	 */
	public class NumberUtil
	{
		/**
		 * Arrondi au plus près un nombre.
		 * @param  number             	Le nombre à arrondir.
		 * @param  nRoundToInterval		L'interval où le nombre sera arrondi au plus près.
		 * @return                   	Le nombre arrondi.
		 */
		public static function round(nNumber:Number, nRoundToInterval:Number=1):Number
		{
			// Return the result
			return Math.round(nNumber / nRoundToInterval) * nRoundToInterval;
		}


		/**
		 * Arrondi au plus bas un nombre.
		 * @param  number             	Le nombre à arrondir.
		 * @param  nRoundToInterval		L'interval où le nombre sera arrondi au plus bas.
		 * @return                   	Le nombre arrondi.
		 */
		public static function floor(nNumber:Number, nRoundToInterval:Number=1):Number
		{
			// Return the result
			return Math.floor(nNumber / nRoundToInterval) * nRoundToInterval;
		}

		/**
		 * Arrondi au plus haut un nombre.
		 * @param  number             	Le nombre à arrondir.
		 * @param  nRoundToInterval		L'interval où le nombre sera arrondi au plus haut.
		 * @return                   	Le nombre arrondi.
		 */
		public static function ceil(nNumber:Number, nRoundToInterval:Number=1):Number
		{
			// Return the result
			return Math.ceil(nNumber / nRoundToInterval) * nRoundToInterval;
		}
		
		/**
		 * Donne le max
		 * @param
		 * @return
		 */
		public static function max(...args):Number
		{
			var n:Number = Number.MIN_VALUE;
			
			for (var i:int = 0; i < args.length; i++)
			{
				if (args[i] > n)
					n = args[i];
			}
			
			return n;
		}
	}
}