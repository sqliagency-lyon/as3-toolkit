package com.sqliagency.as3.errors
{

	/**
	 * ClassNotFoundError
	 * Lancé lorsqu'une classe n'est pas trouvé.
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ClassNotFoundError extends Error
	{
		/**
		 * Constructeur.
		 * @param message
		 */
		public function ClassNotFoundError(message:String="")
		{
			super(message);
		}
	}
}