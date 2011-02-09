package com.sqliagency.as3.preloaders
{
	/**
	 * IProgressBar
	 * Interface à implémenter pour tout composant affichant le suivi d'un (pré)chargement.
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IProgressBar 
	{
		function set bytesLoaded(value:uint):void;
		function set bytesTotal(value:uint):void;
	}
}