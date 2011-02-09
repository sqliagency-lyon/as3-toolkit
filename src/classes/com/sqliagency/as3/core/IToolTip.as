package com.sqliagency.as3.core
{
	import flash.geom.Rectangle;
	
	/**
	 * IToolTip
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IToolTip extends IDisplayObject
	{
		/**
		 *  Le rectangle représentant la position et la taille de l'objet dont la tooltip est associé.
		 * @return rectangle
		 */
		function get screen():Rectangle;
		
		/**
		 * @private
		 */
		function set screen(value:Rectangle):void;
		
		/**
		 * Le texte qui apparait dans la tooltip.
		 */
		function get text():String;
		
		/**
		 *  @private
		 */
		function set text(value:String):void;
	}
}