package 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.filters.ShaderFilter;
	import flash.utils.ByteArray;
	
	/**
	 * PixelBenderDemo
	 * Importation d'un fichier PixelBender
	 * 
	 * Requiert: flash CS4
	 * 
	 * Exemple:
	 		var demo:PixelBenderDemo = new PixelBenderDemo();
			addChild(demo);
			demo.init();
	 * 
	 * @author Nicolas CHENG
	 * @created 28/01/2010
	 * 
	 */
	[SWF(frameRate="30",width="800",height="600",backgroundColor="#ffffff")]
	public class PixelBenderDemo extends Sprite
	{
		[Embed("../assets/DTW.pbj", mimeType="application/octet-stream")]
		private var pbjClass:Class;
		
		[Embed("../assets/femme.jpg")]
		private var image1Class:Class;
		
		[Embed("../assets/homme.jpg")]
		private var image2Class:Class;
		
		private var image1:Bitmap;
		private var image2:Bitmap;
		private var shader:Shader;
		private var filter:ShaderFilter;
		//private var tween:GTween;
		private var tween:TweenLite;
		public var contrast:Number = 1.0;
		private var who:DisplayObject;
		
		/**
		 * Initialisation
		 */
		override protected function init():void 
		{
			image1 = new image1Class() as Bitmap;
			image2 = new image2Class() as Bitmap;
			addChild(image1);
			addChild(image2);
			who = image1;
			image2.visible = false;
			
			shader = new Shader(new pbjClass() as ByteArray);
			filter = new ShaderFilter(shader);
			
			/*
			tween = new GTween(this, 1);
			tween.onChange = tweenChange;
			tween.onComplete = transition;
			transition(tween);
			*/
			
			tween = new TweenLite(this, 1, { contrast:5, ease:Expo.easeIn, onUpdate:tweenChange, onComplete:transition });
		}
		
		//private function transition(tween:GTween):void
		private function transition():void
		{
			if (contrast > 4)
			{
				if (image1 == who)
				{
					image1.visible = false;
					image2.visible = true;
					who = image2;
				}
				else
				{
					image2.visible = false;
					image1.visible = true;
					who = image1;
				}
			}
			
			if (contrast == 1) 
			{
				//tween.setValues({ contrast:5 });
				//tween.ease = Expo.easeIn;
				tween = new TweenLite(this, 1, { contrast:5, ease:Expo.easeIn, onUpdate:tweenChange, onComplete:transition });
			}
			else
			{
				//tween.setValues({ contrast:1 });
				//tween.ease = Expo.easeInOut;
				tween = new TweenLite(this, 1, { contrast:1, ease:Expo.easeOut, onUpdate:tweenChange, onComplete:transition });
			}
		}
		
		//private function tweenChange(tween:GTween):void 
		private function tweenChange():void
		{
			shader.data.contrast.value = [ contrast ];
			who.filters = [ filter ];
		}
	}
}