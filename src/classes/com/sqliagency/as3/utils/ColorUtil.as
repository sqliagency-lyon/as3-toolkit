package com.sqliagency.as3.utils
{
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	
	/**
	 * ColorUtil
	 * Classe utilitaire pour la gestion des couleurs.
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ColorUtil
	{
		/**
		 * Colorise.
		 * @param target objet graphique dont la couleur sera changé
		 * @param color couleur qu'on veut appliquer
		 */
		public static function setColor(target:DisplayObject, color:uint):void
		{
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.color = color;
			var transform:Transform = new Transform(target);
			transform.colorTransform = colorTransform;
		}
	}
}