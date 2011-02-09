package com.sqliagency.as3.display 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * La classe Graphics2 est un ensemble de méthodes permettant d'"tendre les méthodes de dessin vectoriel par défaut de l'api. 
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 * @see flash.display.Graphics
	 */
	public final class Graphics2 
	{
		private var _graphics:Graphics;
		private var _x:Number;
		private var _y:Number;
		
		/**
		 * Crée un nouveau objet Graphics2.
		 * 
		 * @param	graphics
		 */
		public function Graphics2 (graphics:Graphics) 
		{
			if (!graphics)
				throw new ArgumentError("paramètre graphics invalide");
				
			_graphics = graphics;
			_x = 0;
			_y = 0;
		}
		
		public function get endPoint ():Point { return new Point(_x,_y); }
		public function get x ():Number { return _x; }
		public function get y ():Number { return _y; }
		
		/**
		 * Remplit une zone de dessin d'une image bitmap.
		 * 
		 * @param	bitmap	 Image bitmap transparente ou opaque qui contient les bits à afficher. 
		 * @param	matrix	 Objet matrix (appartenant à la classe flash.geom.Matrix), qui permet de définir les transformations du bitmap.
		 * @param	repeat	 Si la valeur est <code>true</code>, l'image bitmap se reproduit pour former un motif. Si la valeur est <code>false</code>, l'image bitmap ne se répète pas et les bords du bitmap sont utilisés pour tout remplissage qui dépasse le·bitmap. 
		 * @param	smooth	 Si la valeur est <code>false</code>, les images bitmap agrandies sont rendues en appliquant un algorithme d'approximation et ont un aspect pixélisé. Si la valeur est <code>true</code>, les images bitmap agrandies sont rendues avec un algorithme bilinéaire. Les rendus qui résultent de l’utilisation de l'algorithme d'approximation sont généralement plus rapides.
		 */
		public function beginBitmapFill (bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void 
		{
			_graphics.beginBitmapFill(bitmap, matrix, repeat, smooth);
		}
		
		/**
		 * Spécifie un remplissage simple d’une couleur utilisé par Flash Player lors des appels suivants d’autres méthodes Graphics (telles que <code>lineTo()</code> ou <code>drawCircle()</code>) associées à l’objet.
		 * 
		 * @param	color		 Couleur du remplissage (0xRRGGBB). 
		 * @param	alpha	 Valeur alpha du remplissage (de 0.0 à 1.0).
		 */
		public function beginFill (color:uint, alpha:Number = 1.0):void
		{
			_graphics.beginFill(color, alpha);
		}
		
		/**
		 * Spécifie un remplissage dégradé utilisé par Flash Player lors des appels suivants d’autres méthodes Graphics (telles que <code>lineTo()</code> ou <code>drawCircle()</code>) associées à l’objet.
		 * 
		 * @param	type							 Valeur de la classe GradientType qui spécifie le type de dégradé à utiliser : <code>GradientType.LINEAR</code> ou <code>GradientType.RADIAL</code>. 
		 * @param	colors						 Tableau de valeurs de couleurs RVB hexadécimales à utiliser pour le dégradé (par exemple, rouge correspond à 0xFF0000, bleu à 0x0000FF, etc.). Vous pouvez définir jusqu'à 15 couleurs. Pour chaque couleur, veillez à définir une valeur correspondante dans les paramètres alpha et de rapport.				
		 * @param	alphas						 Un tableau de valeurs alpha pour les couleurs correspondantes du tableau de couleurs ; les valeurs valides vont de 0 à 1. Si la valeur est inférieure à 0, la valeur par défaut est de 0. Si la valeur est supérieure à 1, la valeur par défaut est de 1.
		 * @param	ratios						 Tableau de taux de distribution des couleurs ; les valeurs valides sont comprises entre 0 et 255. Cette valeur définit le pourcentage de la largeur où la couleur est échantillonnée sur 100 %. La valeur 0 représente la position de gauche dans la zone de dégradés, tandis que 255 représente la position de droite.
		 * @param	matrix						 Matrice de transformation définie par la classe flash.geom.Matrix. La classe flash.geom.Matrix inclut une méthode <code>createGradientBox()</code>, qui permet de configurer facilement la matrice en vue de son utilisation avec la méthode <code>beginGradientFill()</code>.
		 * @param	spreadMethod			 Valeur de la classe SpreadMethod qui spécifie la méthode d’étalement à utiliser : <code>SpreadMethod.PAD</code>, <code>SpreadMethod.REFLECT</code> ou <code>SpreadMethod.REPEAT</code>. 
		 * @param	interpolationMethod	 Valeur de la classe InterpolationMethod qui spécifie la valeur à utiliser : <code>InterpolationMethod.linearRGB</code> ou <code>InterpolationMethod.RGB</code>.
		 * @param	focalPointRatio			 Nombre qui contrôle l'emplacement du point focal du dégradé. La valeur 0 signifie que le point focal est au centre. La valeur 1 signifie que le point focal est au bord du cercle du dégradé. La valeur -1 signifie que le point focal est sur l'autre bord du cercle du dégradé. Toute valeur inférieure à -1 ou supérieure à 1 est arrondie à -1 ou 1.	
		 */
		public function beginGradientFill (type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void
		{
			_graphics.beginGradientFill (type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		
		/**
		 * Efface les graphiques dessinés dans l’objet Graphics et réinitialise les réglages de style de trait et de remplissage. 
		 */
		public function clear ():void
		{
			_graphics.clear();
			_x = 0;
			_y = 0;
		}
		
		/**
		 * Dessine une courbe en utilisant le style de trait actuel à partir de la position actuelle jusqu’à (anchorX, anchorY) en utilisant le point de contrôle spécifié par (<code>controlX</code>, <code>controlY</code>).
		 * @param	controlX	 Nombre qui spécifie la position horizontale du point de contrôle par rapport au point d'alignement de l’objet d'affichage parent.
		 * @param	controlY	 Nombre qui spécifie la position verticale du point de contrôle par rapport au point d'alignement de l’objet d'affichage parent.
		 * @param	anchorX	 Nombre qui spécifie la position horizontale du point d’ancrage suivant par rapport au point d'alignement de l’objet d'affichage parent.
		 * @param	anchorY	 Nombre qui spécifie la position verticale du point d’ancrage suivant par rapport au point d'alignement de l’objet d'affichage parent.
		 */
		public function curveTo (controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void
		{
			_graphics.curveTo(controlX, controlY, anchorX, anchorY);
			_x = anchorX;
			_y = anchorY;
		}
		
		/**
		 * Dessine un cercle.
		 * 
		 * @param	x			 Coordonnée x du centre du cercle par rapport au point d'alignement de l’objet d'affichage parent (en pixels). 
		 * @param	y			 Coordonnée y du centre du cercle par rapport au point d'alignement de l’objet d'affichage parent (en pixels). 
		 * @param	radius	 Rayon du cercle (en pixels).
		 */
		public function drawCircle (x:Number, y:Number, radius:Number):void
		{
			_graphics.drawCircle(x, y, radius);
		}
		
		/**
		 * Dessine une ellipse. 
		 * 
		 * @param	x			 Coordonnée x du centre de l'ovale par rapport au point d'alignement de l’objet d'affichage parent (en pixels). 
		 * @param	y			 Coordonnée y du centre de l'ovale par rapport au point d'alignement de l’objet d'affichage parent (en pixels).
		 * @param	width	 Largeur de l’ellipse (en pixels). 
		 * @param	height	 Hauteur de l’ellipse (en pixels). 
		 */
		public function drawEllipse (x:Number, y:Number, width:Number, height:Number):void
		{
			_graphics.drawEllipse(x, y, width, height);
		}
		
		/**
		 * Dessine un rectangle.
		 * 
		 * @param	x			 Nombre indiquant la position horizontale par rapport au point d'alignement de l’objet d'affichage parent (en pixels). 
		 * @param	y			 Nombre indiquant la position verticale par rapport au point d'alignement de l’objet d'affichage parent (en pixels). 
		 * @param	width	 Largeur du rectangle (en pixels). 
		 * @param	height	 Hauteur du rectangle (en pixels). 
		 */
		public function drawRect (x:Number, y:Number, width:Number, height:Number):void
		{
			_graphics.drawRect(x, y, width, height);
		}
		
		/**
		 * Dessine un rectangle arrondi.
		 * 
		 * @param	x					 Nombre indiquant la position horizontale par rapport au point d'alignement de l’objet d'affichage parent (en pixels). 
		 * @param	y					 Nombre indiquant la position verticale par rapport au point d'alignement de l’objet d'affichage parent (en pixels).
		 * @param	width			 Largeur du rectangle arrondi (en pixels).
		 * @param	height			 Hauteur du rectangle arrondi (en pixels). 
		 * @param	ellipseWidth	 La largeur de l’ellipse utilisée pour dessiner les coins arrondis (en pixels).
		 * @param	ellipseHeight	 La hauteur de l’ellipse utilisée pour dessiner les coins arrondis (en pixels). Facultatif. Si aucune valeur n’est spécifiée, la valeur par défaut correspond à la valeur fournie pour le paramètre ellipseWidth.
		 */
		public function drawRoundRect (x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number):void
		{
			_graphics.drawRoundRect(x, y, width, height, ellipseWidth, ellipseHeight);
		}
		
		/**
		 * Applique un remplissage aux lignes et aux courbes ajoutées depuis le dernier appel de la méthode <code>beginFill()</code>, <code>beginGradientFill()</code> ou <code>beginBitmapFill()</code>.
		 */
		public function endFill ():void
		{
			_graphics.endFill();
		}
		
		/**
		 * Spécifie un dégradé pour le style de trait utilisé par Flash Player lors des appels suivants d’autres méthodes Graphics (telles que <code>lineTo()</code> ou <code>drawCircle()</code>) associées à l’objet.
		 * 
		 * @param	type							 Valeur de la classe GradientType qui spécifie le type de dégradé à utiliser : <code>GradientType.LINEAR</code> ou <code>GradientType.RADIAL</code>. 
		 * @param	colors						 Tableau de valeurs de couleurs RVB hexadécimales à utiliser pour le dégradé (par exemple, rouge correspond à 0xFF0000, bleu à 0x0000FF, etc.). Vous pouvez définir jusqu'à 15 couleurs. Pour chaque couleur, veillez à définir une valeur correspondante dans les paramètres alpha et de rapport.				
		 * @param	alphas						 Un tableau de valeurs alpha pour les couleurs correspondantes du tableau de couleurs ; les valeurs valides vont de 0 à 1. Si la valeur est inférieure à 0, la valeur par défaut est de 0. Si la valeur est supérieure à 1, la valeur par défaut est de 1.
		 * @param	ratios						 Tableau de taux de distribution des couleurs ; les valeurs valides sont comprises entre 0 et 255. Cette valeur définit le pourcentage de la largeur où la couleur est échantillonnée sur 100 %. La valeur 0 représente la position de gauche dans la zone de dégradés, tandis que 255 représente la position de droite.
		 * @param	matrix						 Matrice de transformation définie par la classe flash.geom.Matrix. La classe flash.geom.Matrix inclut une méthode <code>createGradientBox()</code>, qui permet de configurer facilement la matrice en vue de son utilisation avec la méthode <code>beginGradientFill()</code>.
		 * @param	spreadMethod			 Valeur de la classe SpreadMethod qui spécifie la méthode d’étalement à utiliser : <code>SpreadMethod.PAD</code>, <code>SpreadMethod.REFLECT</code> ou <code>SpreadMethod.REPEAT</code>. 
		 * @param	interpolationMethod	 Valeur de la classe InterpolationMethod qui spécifie la valeur à utiliser : <code>InterpolationMethod.linearRGB</code> ou <code>InterpolationMethod.RGB</code>.
		 * @param	focalPointRatio			 Nombre qui contrôle l'emplacement du point focal du dégradé. La valeur 0 signifie que le point focal est au centre. La valeur 1 signifie que le point focal est au bord du cercle du dégradé. La valeur -1 signifie que le point focal est sur l'autre bord du cercle du dégradé. Toute valeur inférieure à -1 ou supérieure à 1 est arrondie à -1 ou 1.	
		 */
		public function lineGradientStyle (type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void
		{
			_graphics.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		
		/**
		 * Spécifie un style de trait utilisé par Flash lors des appels suivants d’autres méthodes Graphics (telles que <code>lineTo()</code> ou <code>drawCircle()</code>) associées à l’objet.
		 * 
		 * @param	thickness		 Un entier qui indique l'épaisseur de la ligne en points ; les valeurs valides vont de 0 à 255. 
		 * @param	color				 Valeur hexadécimale de la couleur de la ligne (par exemple, rouge correspond à 0xFF0000, bleu à 0x0000FF, etc.).
		 * @param	alpha			 Un nombre qui indique la valeur alpha de la couleur de la ligne. 
		 * @param	pixelHinting	 Valeur booléenne qui permet d'ajouter des indices supplémentaires de lissage des pixels. 
		 * @param	scaleMode	 Valeur de la classe LineScaleMode qui spécifie le mode d’échelle à utiliser.
		 * @param	caps				 Valeur de la classe CapsStyle qui spécifie le type d'extrémité au bout des lignes. 
		 * @param	joints			 Valeur de la classe JointStyle qui spécifie le type d'apparence de liaison utilisé dans les angles.
		 * @param	miterLimit		 Nombre qui indique la limite à laquelle une pointe est coupée.
		 */
		public function lineStyle (thickness:Number, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void
		{
			_graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
		}
		
		/**
		 * Trace une ligne en utilisant le style de trait actuel à partir de la position de dessin actuelle jusqu'à (x, y) ; la position de dessin actuelle est ensuite réglée sur (x, y).
		 * 
		 * @param	x	 Nombre indiquant la position horizontale par rapport au point d'alignement de l’objet d'affichage parent (en pixels). 
		 * @param	y	 Nombre indiquant la position verticale par rapport au point d'alignement de l’objet d'affichage parent (en pixels).
		 */
		public function lineTo (x:Number, y:Number):void
		{
			_graphics.lineTo(x, y);
			_x = x;
			_y = y;
		}
		
		/**
		 * Déplace la position de dessin actuelle vers (x, y).
		 * 
		 * @param	x	 Nombre indiquant la position horizontale par rapport au point d'alignement de l’objet d'affichage parent (en pixels). 
		 * @param	y	 Nombre indiquant la position verticale par rapport au point d'alignement de l’objet d'affichage parent (en pixels). 
		 */
		public function moveTo (x:Number, y:Number):void
		{
			_graphics.moveTo(x, y);
			_x = x;
			_y = y;
		}
		
		/**
		 * Metod for drawing dashed (and dotted) lines.
		 * 
		 * @author  Ric Ewing (ric@formequalsfunction.com) - version 1.2 - 5.3.2002
		 * 
		 * @param	startx beginning of dashed line (x)
		 * @param	starty beginning of dashed line (y)
		 * @param	endx end of dashed line (x)
		 * @param	endy end of dashed line (y)
		 * @param	length length of dash
		 * @param	gap length of gap between dashes
		 */
		public function dashTo (startx:Number, starty:Number, endx:Number, endy:Number, length:Number, gap:Number) : void
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
			_x = endx;
			_y = endy;
		}
		
		/**
		 * Method for drawing regular and eliptical arc segments.
		 * 
		 * @author	Ric Ewing (ric@formequalsfunction.com) - version 1.5 - 4.7.2002
		 * 
		 * @param	x				 This must be the current pen position... other values will look bad
		 * @param	y				 This must be the current pen position... other values will look bad
		 * @param	radius		 radius of Arc.
		 * @param	arc			 sweep of the arc. Negative values draw clockwise.
		 * @param	startAngle	 starting angle in degrees.
		 * @param	yRadius	 y radius of arc.
		 * @return		Position (x,y) par rapport au point d'alignement de l’objet d'affichage parent (en pixels). 
		 */
		public function drawArc (x:Number, y:Number, radius:Number, arc:Number, startAngle:Number, yRadius:Number = NaN) : Point
		{
			// if yRadius is undefined, yRadius = radius
			if (isNaN(yRadius))
			{
				yRadius = radius;
			}
			
			// Init vars
			var segAngle:Number;
			var theta:Number;
			var angle:Number;
			var angleMid:Number;
			var segs:int;
			var ax:Number;
			var ay:Number;
			var bx:Number;
			var by:Number;
			var cx:Number;
			var cy:Number;
			
			// no sense in drawing more than is needed :)
			if (Math.abs(arc) > 360)
			{
				arc = 360;
			}
			
			// Flash uses 8 segments per circle, to match that, we draw in a maximum
			// of 45 degree segments. First we calculate how many segments are needed
			// for our arc.
			segs = Math.ceil(Math.abs(arc)/45);
			
			// Now calculate the sweep of each segment
			segAngle = arc/segs;
			
			// The math requires radians rather than degrees. To convert from degrees
			// use the formula (degrees/180)*Math.PI to get radians. 
			theta = -(segAngle/180)*Math.PI;
			
			// convert angle startAngle to radians
			angle = -(startAngle/180)*Math.PI;
			
			// find our starting points (ax,ay) relative to the secified x,y
			ax = x-Math.cos(angle)*radius;
			ay = y-Math.sin(angle)*yRadius;
			
			// if our arc is larger than 45 degrees, draw as 45 degree segments
			// so that we match Flash's native circle routines.
			if (segs > 0)
			{
				// Loop for drawing arc segments
				for (var i:int = 0; i < segs; i++) 
				{
					// increment our angle
					angle += theta;
					// find the angle halfway between the last angle and the new
					angleMid = angle-(theta/2);
					// calculate our end point
					bx = ax+Math.cos(angle)*radius;
					by = ay+Math.sin(angle)*yRadius;
					// calculate our control point
					cx = ax+Math.cos(angleMid)*(radius/Math.cos(theta/2));
					cy = ay+Math.sin(angleMid)*(yRadius/Math.cos(theta/2));
					// draw the arc segment
					_graphics.curveTo(cx, cy, bx, by);
				}
			}
			
			// In the native draw methods the user must specify the end point
			// which means that they always know where they are ending at, but
			// here the endpoint is unknown unless the user calculates it on their 
			// own. Lets be nice and let save them the hassle by passing it back. 
			_x = bx;
			_y = by;
			return new Point(bx, by);
		}
		
		/**
		 * Method for drawing bursts (rounded star shaped ovals often seen in advertising).
		 *
		 * @author	Ric Ewing (ric@formequalsfunction.com) - version 1.4 - 4.7.2002
		 * 
		 * @param	x					center X of burst
		 * @param	y					center Y of burst
		 * @param	innerRadius	radius of the indent of the curves
		 * @param	outerRadius	radius of the outermost points
		 * @param	angle			starting angle in degrees
		 * @param	sides			number of sides or points
		 */
		public function drawBurst (x:Number, y:Number, innerRadius:Number, outerRadius:Number, angle:Number=0, sides:int=3):void
		{
			if (sides < 3)
			{
				return;
			}
			
			var step:Number;
			var halfStep:Number;
			var qtrStep:Number;
			var start:Number;
			var dx:Number;
			var dy:Number;
			var cx:Number;
			var cy:Number;
			
			// calculate length of sides
			step = (Math.PI*2)/sides;
			halfStep = step/2;
			qtrStep = step/4;
			
			// calculate starting angle in radians
			start = (angle/180)*Math.PI;
			_graphics.moveTo(x+(Math.cos(start)*outerRadius), y-(Math.sin(start)*outerRadius));
			
			// draw curves
			for (var n:int = 1; n <= sides; n++)
			{
				cx = x + Math.cos(start + (step * n) - (qtrStep * 3)) * (innerRadius / Math.cos(qtrStep));
				cy = y - Math.sin(start + (step * n) - (qtrStep * 3)) * (innerRadius / Math.cos(qtrStep));
				dx = x + Math.cos(start + (step * n) - halfStep) * innerRadius;
				dy = y - Math.sin(start + (step * n) - halfStep) * innerRadius;
				_graphics.curveTo(cx, cy, dx, dy);
				cx = x + Math.cos(start + (step * n) - qtrStep) * (innerRadius / Math.cos(qtrStep));
				cy = y - Math.sin(start + (step * n) - qtrStep) * (innerRadius / Math.cos(qtrStep));
				dx = x + Math.cos(start + (step * n)) * outerRadius;
				dy = y - Math.sin(start + (step * n)) * outerRadius;
				_graphics.curveTo(cx, cy, dx, dy);
			}
		}
		
		/**
		 * Method that draws gears.
		 *
		 * @author Ric Ewing (ric@formequalsfunction.com) - version 1.3 - 3.5.2002
		 * 
		 * @param	x					center X of gear
		 * @param	y					center Y of gear
		 * @param	innerRadius	radius of the indent of the teeth
		 * @param	outerRadius	outer radius of the teeth
		 * @param	angle			starting angle in degrees
		 * @param	sides			number of teeth on gear. (must be > 2)
		 * @param	holeSides		draw a polygonal hole with this many sides (must be > 2)
		 * @param	holeRadius	size of hole
		 */
		public function drawGear (x:Number, y:Number, innerRadius:Number, outerRadius:Number, holeRadius:Number=NaN, angle:Number = 0, sides:int = 3, holeSides:int = 3):void
		{
			if (sides < 3)
			{
				return;
			}
			
			// init vars
			var step:Number;
			var qtrStep:Number;
			var start:Number;
			var dx:Number;
			var dy:Number;
			
			// calculate length of sides
			step = (Math.PI * 2) / sides;
			qtrStep = step / 4;
			
			// calculate starting angle in radians
			start = (angle / 180) * Math.PI;
			_graphics.moveTo(x + (Math.cos(start) * outerRadius), y - (Math.sin(start) * outerRadius));
			
			// draw lines
			for (var n:int = 1; n <= sides; n++)
			{
				dx = x + Math.cos(start + (step * n) - (qtrStep * 3)) * innerRadius;
				dy = y - Math.sin(start + (step * n) - (qtrStep * 3)) * innerRadius;
				_graphics.lineTo(dx, dy);
				dx = x + Math.cos(start + (step * n) - (qtrStep * 2)) * innerRadius;
				dy = y - Math.sin(start + (step * n) - (qtrStep * 2)) * innerRadius;
				_graphics.lineTo(dx, dy);
				dx = x + Math.cos(start + (step * n) - qtrStep) * outerRadius;
				dy = y - Math.sin(start + (step * n) - qtrStep) * outerRadius;
				_graphics.lineTo(dx, dy);
				dx = x + Math.cos(start + (step * n)) * outerRadius;
				dy = y - Math.sin(start + (step * n)) * outerRadius;
				_graphics.lineTo(dx, dy);
			}
			
			// This is complete overkill... but I had it done already. :)
			if (holeSides > 2)
			{
				if (isNaN(holeRadius))
				{
					holeRadius = innerRadius/3;
				}
				
				step = (Math.PI * 2) / holeSides;
				_graphics.moveTo(x + (Math.cos(start) * holeRadius), y - (Math.sin(start) * holeRadius));
				
				for (n = 1; n <= holeSides; n++)
				{
					dx = x + Math.cos(start + (step * n)) * holeRadius;
					dy = y - Math.sin(start + (step * n)) * holeRadius;
					_graphics.lineTo(dx, dy);
				}
			}
		}
		
		/**
		 * Method for creating circles and ovals.
		 * 
		 * @author	Ric Ewing (ric@formequalsfunction.com) - version 1.1 - 4.7.2002
		 * 
		 * @param	x				center X of oval
		 * @param	y				center Y of oval
		 * @param	radius		radius of oval
		 * @param	yRadius	y radius of oval
		 */
		public function drawOval (x:Number, y:Number, radius:Number, yRadius:Number = NaN):void
		{
			// init variables
			var theta:Number;
			var xrCtrl:Number;
			var yrCtrl:Number;
			var angle:Number;
			var angleMid:Number;
			var px:Number;
			var py:Number;
			var cx:Number;
			var cy:Number;
			
			// if only yRadius is undefined, yRadius = radius
			if (isNaN(yRadius))
			{
				yRadius = radius;
			}
			
			// covert 45 degrees to radians for our calculations
			theta = Math.PI / 4;
			
			// calculate the distance for the control point
			xrCtrl = radius / Math.cos(theta / 2);
			yrCtrl = yRadius / Math.cos(theta / 2);
			
			// start on the right side of the circle
			angle = 0;
			_graphics.moveTo(x + radius, y);
			
			// this loop draws the circle in 8 segments
			for (var i:int = 0; i < 8; i++)
			{
				// increment our angles
				angle += theta;
				angleMid = angle-(theta / 2);
				
				// calculate our control point
				cx = x + Math.cos(angleMid) * xrCtrl;
				cy = y + Math.sin(angleMid) * yrCtrl;
				
				// calculate our end point
				px = x + Math.cos(angle) * radius;
				py = y + Math.sin(angle) * yRadius;
				
				// draw the circle segment
				_graphics.curveTo(cx, cy, px, py);
			}
		}
		
		/**
		 * Method for creating regular polygons.
		 * 
		 * <p>Negative values for sides will draw the polygon in the reverse direction, which allows for creating knock-outs in masks.</p>
		 * 
		 * @author	Ric Ewing (ric@formequalsfunction.com) - version 1.4 - 4.7.2002
		 * 
		 * @param	x			center X of polygon
		 * @param	y			center Y of polygon
		 * @param	radius	radius of the points of the polygon from the center
		 * @param	sides	number of sides (Math.abs(sides) must be > 2)
		 * @param	angle	starting angle in degrees
		 */
		public function drawPoly (x:Number, y:Number, radius:Number, sides:int = 3, angle:Number = 0):void
		{
			// convert sides to positive value
			var count:int = Math.abs(sides);
			
			// check that count is sufficient to build polygon
			if (count < 3)
			{
				return;
			}
			
			// init vars
			var step:Number;
			var start:Number;
			var dx:Number;
			var dy:Number;
			
			// calculate span of sides
			step = (Math.PI * 2) / sides;
			
			// calculate starting angle in radians
			start = (angle / 180) * Math.PI;
			_graphics.moveTo(x + (Math.cos(start) * radius), y - (Math.sin(start) * radius));
			
			// draw the polygon
			for (var n:int = 1; n <= count; n++)
			{
				dx = x + Math.cos(start + (step * n)) * radius;
				dy = y - Math.sin(start + (step * n)) * radius;
				_graphics.lineTo(dx, dy);
			}
		}
		
		/**
		 * Method for drawing stars.
		 * 
		 * @author	Ric Ewing (ric@formequalsfunction.com) - version 1.4 - 4.7.2002
		 * 
		 * @param	x					center X of star
		 * @param	y					center Y of star
		 * @param	points			number of points (Math.abs(points) must be > 2)
		 * @param	innerRadius	radius of the indent of the points
		 * @param	outerRadius	radius of the tips of the points
		 * @param	angle			starting angle in degrees
		 */
		public function drawStar (x:Number, y:Number, innerRadius:Number, outerRadius:Number, points:int = 3, angle:Number = 0):void
		{
			var count:int = (points>2) ? points : 3;
			var step:Number;
			var halfStep:Number;
			var start:Number;
			var dx:Number;
			var dy:Number;
			
			// calculate distance between points
			step = (Math.PI * 2) / points;
			halfStep = step / 2;
			
			// calculate starting angle in radians
			start = (angle / 180) * Math.PI;
			_graphics.moveTo(x + (Math.cos(start) * outerRadius), y - (Math.sin(start) * outerRadius));
			
			// draw lines
			for (var n:int = 1; n <= count; n++) 
			{
				dx = x + Math.cos(start + (step * n) - halfStep) * innerRadius;
				dy = y - Math.sin(start + (step * n) - halfStep) * innerRadius;
				_graphics.lineTo(dx, dy);
				dx = x + Math.cos(start + (step * n)) * outerRadius;
				dy = y - Math.sin(start + (step * n)) * outerRadius;
				_graphics.lineTo(dx, dy);
			}
		}
		
		/**
		 * method for drawing pie shaped	wedges. 
		 * 
		 * <p>Very useful for creating charts.</p>
		 * 
		 * @author	Ric Ewing (ric@formequalsfunction.com) - version 1.3 - 6.12.2002
		 * 
		 * @param	x					center point X of the wedge
		 * @param	y					center point Y of the wedge
		 * @param	startAngle		starting angle in degrees
		 * @param	arc				sweep of the wedge. Negative values draw clockwise.
		 * @param	radius			radius of wedge. If [optional] yRadius is defined, then radius is the x radius.
		 * @param	yRadius		[optional] y radius for wedge.
		 */
		public function drawWedge (x:Number, y:Number, startAngle:Number, arc:Number, radius:Number, yRadius:Number = NaN):void
		{			
			_graphics.moveTo(x, y);
			
			// if yRadius is NaN, yRadius = radius
			if (isNaN(yRadius))
			{
				yRadius = radius;
			}
			
			// Init vars
			var segAngle:Number;
			var theta:Number;
			var angle:Number;
			var angleMid:Number;
			var ax:Number;
			var ay:Number;
			var bx:Number;
			var by:Number;
			var cx:Number;
			var cy:Number;
			var segs:int;
			
			// limit sweep to reasonable numbers
			if (Math.abs(arc) > 360)
			{
				arc = 360;
			}
			
			// Flash uses 8 segments per circle, to match that, we draw in a maximum
			// of 45 degree segments. First we calculate how many segments are needed
			// for our arc.
			segs = Math.ceil(Math.abs(arc) / 45);
			
			// Now calculate the sweep of each segment.
			segAngle = arc / segs;
			
			// The math requires radians rather than degrees. To convert from degrees
			// use the formula (degrees/180)*Math.PI to get radians.
			theta = -(segAngle / 180) * Math.PI;
				
			// convert angle startAngle to radians
			angle = -(startAngle / 180) * Math.PI;
			
			// draw the curve in segments no larger than 45 degrees.
			if (segs > 0) 
			{
				// draw a line from the center to the start of the curve
				ax = x + Math.cos(startAngle / 180 * Math.PI) * radius;
				ay = y + Math.sin( -startAngle / 180 * Math.PI) * yRadius;
				_graphics.lineTo(ax, ay);
				
				// Loop for drawing curve segments
				for (var i:int = 0; i < segs; i++) 
				{
					angle += theta;
					angleMid = angle-(theta / 2);
					bx = x + Math.cos(angle) * radius;
					by = y + Math.sin(angle) * yRadius;
					cx = x + Math.cos(angleMid) * (radius / Math.cos(theta / 2));
					cy = y + Math.sin(angleMid) * (yRadius / Math.cos(theta / 2));
					_graphics.curveTo(cx, cy, bx, by);
				}
				
				// close the wedge by drawing a line to the center
				_graphics.lineTo(x, y);
			}
		}
	}
}