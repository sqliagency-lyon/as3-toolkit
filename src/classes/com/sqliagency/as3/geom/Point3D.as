package com.sqliagency.as3.geom {
	
	import com.sqliagency.as3.utils.NumberUtil;
	import flash.geom.Point;
	
	/**
	 * Classe Point3D représentant un point dans un espace en 3 dimensions.
	 * 
	 * Note : 
	 * L'espace est orienté avec les conventions habituelles :
	 * x vers l'avant 
	 * y vers la droite
	 * z vers le haut
	 * 
	 * Les rotations se font dans le sens contraire aux aiguilles d'une montre.
	 * 
	 * Par défaut, les valeurs sont arrondis au twips (0.05 pixel) près.
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 * @created 25/11/2009
	 * @modified 28/11/2009 [Nicolas CHENG]
	 * 						- Ajout de la méthode toString
	 * 						- Ajout de la méthode clone
	 * 						- Modification de la méthode rotationX
	 * 						- Modification de la méthode rotationY
	 * 						- Modification de la méthode rotationZ
	 * 
	 */
	public class Point3D  {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public const TO_RADIANS:Number = Math.PI / 180;
		public const TO_DEGREES:Number = 180 / Math.PI;
		
		/**
		 * Constructeur
		 * @param	x
		 * @param	y
		 * @param	z
		 */
		public function Point3D(x:Number=0, y:Number=0, z:Number=0)  {
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		/**
		 * Cloner un Point3D
		 * @return copie du Point3D
		 */
		public function clone():Point3D {
			return new Point3D(x, y, z);
		}
		
		/**
		 * Rotation sur l'axe des X
		 * 
		 * [	1		0		0		]
		 * [	0		cos		-sin	]
		 * [	0		sin 	cos		]
		 * 
		 * @param	angle en degré
		 * @return le point 3D
		 */
		public function rotateX(angle:Number):Point3D {
			var p:Point3D = clone();
			angle *= TO_RADIANS;
			y = p.y * Math.cos(angle) - p.z * Math.sin(angle);
			z = p.y * Math.sin(angle) + p.z * Math.cos(angle);
			
			y = NumberUtil.round(y, 0.05);
			z = NumberUtil.round(z, 0.05);
			
			return this;
		}
		
		/**
		 * Rotation sur l'axe des Y
		 * 
		 * [	cos		0		sin 	]
		 * [	0		1		0		]
		 * [	-sin	0 		cos		]
		 * 
		 * @param	angle en degré
		 * @return le point 3D
		 */
		public function rotateY(angle:Number):Point3D {
			var p:Point3D = clone();
			angle *= TO_RADIANS;
			x = p.x * Math.cos(angle) + p.z * Math.sin(angle);
			z = p.z * Math.cos(angle) - p.x * Math.sin(angle);
			
			x = NumberUtil.round(x, 0.05);
			z = NumberUtil.round(z, 0.05);
			
			return this;
		}
		
		/**
		 * Rotation sur l'axe des Z
		 * 
		 * [	cos		-sin	0	]
		 * [	sin		cos		0	]
		 * [	0		0 		1	]
		 * 
		 * @param	angle en degré
		 * @return le point 3D
		 */
		public function rotateZ(angle:Number):Point3D {
			var p:Point3D = clone();
			angle *= TO_RADIANS;
			x = p.x * Math.cos(angle) - p.y * Math.sin(angle);
			y = p.x * Math.sin(angle) + p.y * Math.cos(angle);
			
			x = NumberUtil.round(x, 0.05);
			y = NumberUtil.round(y, 0.05);
			
			return this;
		}
		
		/**
		 * Appliquer une projection 'perspective'
		 * 
		 * Théorême de Thales , rapide et efficace mais limité :
		 * H/h=(fl+z)/fl
		 * fl est la distance focale (distance entre nous et la fenêtre par laquelle nous regardons l'objet)
		 * z est la distance par rapport à la fenêtre de notre objet (z=0 est la position de la fenêtre)
		 * H est la hauteur réelle de l'objet
		 * h est la hauteur de l'objet telle que nous la voyons sur la fenêtre
		 * 
		 * Donc utilisation des vraies formules de projection perspective :
		 * X' = Xo + Zo * (X-Xo) / (Zo-Z)
		 * Y' = Yo + Zo * (Y-Yo) / (Zo-Z)
		 * Ces formules tiennent compte de la position de l'observateur, qui est situé au point O(Xo,Yo,Zo).
		 * 
		 * @param	eyePoint
		 * @return un point en 2 dimensions
		 */
		public function toScreen(eyePoint:Point3D=null):Point {
			if (!eyePoint) {
				eyePoint = new Point3D(0, 0, 1000);
			}
			
			var p:Point = new Point();
			p.x = eyePoint.x + eyePoint.z * (x - eyePoint.x) / (eyePoint.z - z);
			p.y = eyePoint.y + eyePoint.z * (y - eyePoint.y) / (eyePoint.z - z);
			
			return p;
		}
		
		/**
		 * Représentation en chaine de caractères de l'objet Point3D
		 * @return une chaine de caractères
		 */
		public function toString():String {
			return "[object Point3D (x:" + x + ", y:" + y + ", z:" + z + ")]";
		}
	}
}