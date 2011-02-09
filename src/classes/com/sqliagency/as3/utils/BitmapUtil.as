package com.sqliagency.as3.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * BitmapUtil
	 * Classe utilitaire pour les bitmap et bitmapdata.
	 * @authoe Nicolas CHENG (sqliagency)
	 */
	public class BitmapUtil
	{
		/**
		 * Capture une image.
		 * @param source
		 * @return image
		 */
		public static function takeSnapshot(source:IBitmapDrawable):Bitmap
		{
			var bitmapData:BitmapData;
			var bitmap:Bitmap;
			var bounds:Rectangle;
			var matrix:Matrix;
			
			if (source is BitmapData)
			{
				bounds = new Rectangle(0, 0, (source as BitmapData).width, (source as BitmapData).height);
			}
			else if (source is DisplayObject)
			{
				bounds = (source as DisplayObject).getBounds(source as DisplayObject);
			}
			else
			{
				throw new ArgumentError("La capture d'écran pour " + source + " a échoué.");
				return null;
			}
			
			bitmapData  = new BitmapData(bounds.width, bounds.height, true, 0x00000000);
			matrix = new Matrix();
			matrix.translate(-bounds.x, -bounds.y);
			bitmapData.draw(source, matrix);
			bitmap = new Bitmap(bitmapData);
			
			return bitmap;
		}
	}
}