package  {
	
	import com.sqliagency.as3.geom.Point3D;
	
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.flashsandy.display.DistortImage;
	
	import templates.FastTemplate;
	
	/**
	 * Classe DistortImageExample
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 * @created 23/11/2009
	 * @updated 10/02/2011
	 * 
	 */	
	[SWF(frameRate="30",width="800",height="600",backgroundColor="#ffffff")]
	public class DistortImageExample extends FastTemplate {	
		
		// elements graphiques
		private var shape:Shape;
		
		// autres variables
		[Embed("../assets/space_invaders_by_molotov_arts.jpg")]
		private var imageClass:Class;
		
		private var bitmap:Bitmap;
		private var distortion:DistortImage;
		
		private var tl:Point3D;
		private var tr:Point3D;
		private var bl:Point3D;
		private var br:Point3D;
		
		public var MAX:Number = 80;
		public var MIN:Number = -80;
		public var angleX:Number = 0;
		public var angleY:Number = 0;
		
		/**
		 * Initialisation.
		 */
		override protected function init():void {
			bitmap = new imageClass as Bitmap;
			
			shape = new Shape();
			addChild(shape);
			
			distortion = new DistortImage(620, 320, 3, 3);
			
			tl = new Point3D( -310, -160);
			tr = new Point3D(310, -160);
			bl = new Point3D(-310, 160);
			br = new Point3D(310, 160);
			
			render();
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseHandler, false, 0, true);
		}
		
		/**
		 * Rendu de l'objet bitmap chargé.
		 * @param angleX
		 * @param angleY
		 */
		private function render(angleX:Number = 0, angleY:Number = 0):void {
			shape.x = (stage.stageWidth - 620) / 2;
			shape.y = (stage.stageHeight - 160) / 2;

			var a:Point = tl.clone().rotateX(angleX).rotateY(angleY).toScreen(new Point3D(0, 0, 1000));
			var b:Point = tr.clone().rotateX(angleX).rotateY(angleY).toScreen(new Point3D(0, 0, 1000));
			var c:Point = br.clone().rotateX(angleX).rotateY(angleY).toScreen(new Point3D(0, 0, 1000));
			var d:Point = bl.clone().rotateX(angleX).rotateY(angleY).toScreen(new Point3D(0, 0, 1000));
			
			a.x += 310;
			b.x += 310;
			c.x += 310;
			d.x += 310;
			
			a.y += 160;
			b.y += 160;
			c.y += 160;
			d.y += 160;
			
			shape.graphics.clear();
			distortion.setTransform(shape.graphics, bitmap.bitmapData, a, b, c, d);
		}
		
		/**
		 * @private
		 */
		private function mouseHandler(event:MouseEvent):void {
			angleX = (mouseY / (stage.stageHeight - 1)) * (MAX - MIN) + MIN;
			angleY = (mouseX / (stage.stageWidth - 1)) * (MAX - MIN) + MIN;
			render(-angleX, angleY);
		}
	}
}