package com.sqliagency.as3.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * Classe utilitaire pour la manipulation des bitmaps
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class GraphicsUtil 
	{
		/**
		 * Dessine un arc de cercle.
		 * 
		 * @param graphics		la surface à dessiner
		 * @param x				abscisse
		 * @param y				ordonnée
		 * @param startAngle	angle de départ (radian)
		 * @param endAngle		angle de fin (radian)
		 * @param radius		rayon
		 * @param direction		direction (Trigonométrique ou non)
		 */
		public static function drawArc(graphics:Graphics, x:Number, y:Number, startAngle:Number, endAngle:Number, radius:Number, direction:Boolean=false):void {
			var diff:Number = Math.abs(endAngle-startAngle);
			var divs:Number = Math.floor(diff/(Math.PI/4))+1;
			var span:Number = (direction ? -1 : 1) * diff/(2*divs);
			var rc:Number = radius/Math.cos(span);
			
			graphics.moveTo(x+Math.cos(startAngle)*radius, y+Math.sin(startAngle)*radius);
			
			for (var i:int=0; i < divs; ++i) {
				endAngle = startAngle+span; startAngle = endAngle+span;
				graphics.curveTo(
					x+Math.cos(endAngle)*rc,
					y+Math.sin(endAngle)*rc,
					x+Math.cos(startAngle)*radius,
					y+Math.sin(startAngle)*radius
				);
			}
		}
		
		/**
         * Metod for drawing dashed (and dotted) lines.
         *
         * @author  Ric Ewing (ric@formequalsfunction.com) - version 1.2 - 5.3.2002
         *
         * @param    startx beginning of dashed line (x)
         * @param    starty beginning of dashed line (y)
         * @param    endx end of dashed line (x)
         * @param    endy end of dashed line (y)
         * @param    length length of dash
         * @param    gap length of gap between dashes
         */
        public static function dashTo (_graphics:Graphics, startx:Number, starty:Number, endx:Number, endy:Number, length:Number, gap:Number) : void
        {
            // init vars
            var seglength:Number;
            var deltax:Number;
            var deltay:Number;
            var segs:int;
            var cx:Number;
            var cy:Number;
           
            // calculate the legnth of a segment
            seglength = length + gap;
           
            // calculate the length of the dashed line
            deltax = endx - startx;
            deltay = endy - starty;
            var delta:Number = Math.sqrt((deltax * deltax) + (deltay * deltay));
           
            // calculate the number of segments needed
            segs = Math.floor(Math.abs(delta / seglength));
           
            // get the angle of the line in radians
            var radians:Number = Math.atan2(deltay,deltax);
           
            // start the line here
            cx = startx;
            cy = starty;
           
            // add these to cx, cy to get next seg start
            deltax = Math.cos(radians)*seglength;
            deltay = Math.sin(radians)*seglength;
           
            // loop through each seg
            for (var n:int = 0; n < segs; n++)
            {
                _graphics.moveTo(cx,cy);
                _graphics.lineTo(cx+Math.cos(radians)*length,cy+Math.sin(radians)*length);
                cx += deltax;
                cy += deltay;
            }
           
            // handle last segment as it is likely to be partial
            _graphics.moveTo(cx,cy);
            delta = Math.sqrt((endx-cx)*(endx-cx)+(endy-cy)*(endy-cy));
           
            if (delta > length)
            {
                // segment ends in the gap, so draw a full dash
                _graphics.lineTo(cx+Math.cos(radians)*length,cy+Math.sin(radians)*length);
            }
            else if (delta > 0)
            {
                // segment is shorter than dash so only draw what is needed
                _graphics.lineTo(cx+Math.cos(radians)*delta,cy+Math.sin(radians)*delta);
            }
           
            // move the pen to the end position
            _graphics.moveTo(endx, endy);
        }
		
		public static function flipHorizontal(dsp:DisplayObject):void
		{
			var matrix:Matrix = dsp.transform.matrix;
			matrix.a=-1;
			matrix.tx = dsp.width + dsp.x;
			dsp.transform.matrix=matrix;
		}
		
		public static function flipVertical(dsp:DisplayObject):void
		{
			var matrix:Matrix = dsp.transform.matrix;
			matrix.d=-1;
			matrix.ty=dsp.height+dsp.y;
			dsp.transform.matrix=matrix;
		}
	}
}