package com.sqliagency.as3.modules
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;

	[Event(name="complete")]
	[Event(name="unload")]
	
	/**
	 * IModuleInfo
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IModuleInfo extends IEventDispatcher
	{
		/**
		 * Url du module.
		 */
		function get url():String;
		
		/**
		 * Le module est chargé et stocké en mémoire.
		 */
		function get ready():Boolean;

		/**
		 * Crée une instance du module.
		 */
		function create():Object;
		
		/**
		 * Charge le module.
		 */
		function load():void;
		
		/**
		 * Stop le chargement du module.
		 */
		function close():void;
		
		/**
		 * Décharge et supprime en mémoire le module.
		 */
		function unload():void;
	}
}