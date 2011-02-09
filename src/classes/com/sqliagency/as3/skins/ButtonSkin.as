package com.sqliagency.as3.skins
{
	import com.sqliagency.as3.core.ISkinnable;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class ButtonSkin extends Sprite implements ISkin
	{
		//private var _target:ISkinnable;
		private var _state:String;		
		public var labelDisplay:TextField;
		
		private static const MIN_WIDTH:Number = 20;
		private static const MIN_HEIGHT:Number = 20;
		
		/**
		 * Constructeur.
		 */
		public function ButtonSkin()
		{
			super();
			
			labelDisplay = new TextField()
			labelDisplay.autoSize = TextFieldAutoSize.LEFT;
			labelDisplay.wordWrap = false;
			labelDisplay.multiline = false;
			labelDisplay.mouseEnabled = false;
			addChild(labelDisplay);
		}
		
		/*
		public function get target():ISkinnable
		{
			return _target;
		}
		
		public function set target(value:ISkinnable):void
		{
			_target = value;
		}
		*/
		
		public function get state():String
		{
			return _state;
		}
		
		public function set state(value:String):void
		{
			_state = value;
		}
		
		public function getSkinElement(skinName:String):InteractiveObject
		{
			return (this[skinName] as InteractiveObject);
		}
		
		public function invalidateDisplayList():void
		{
			var measuredWidth:Number = Math.ceil(labelDisplay.width);
			var measuredHeight:Number = Math.ceil(labelDisplay.height);
			updateDisplayList(measuredWidth,measuredHeight);
		}
		
		protected function updateDisplayList(measuredWidth:Number, measuredHeight:Number):void
		{
			if (measuredWidth < MIN_WIDTH)
				measuredWidth = MIN_WIDTH;
			
			if (measuredHeight < MIN_HEIGHT)
				measuredHeight = MIN_HEIGHT;
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(measuredWidth, measuredHeight, Math.PI/2);
			
			graphics.clear();
			
			// border
			graphics.beginFill(0x888888);
			graphics.drawRect(0,0,measuredWidth,measuredHeight);
			graphics.endFill();
			
			if (state == "up")
			{
				graphics.beginGradientFill(GradientType.LINEAR, [0xfafafa,0xaaaaaa], [1,1], [63,255], matrix);
			}
			else if (state == "over")
			{
				graphics.beginGradientFill(GradientType.LINEAR, [0xfdfdfd,0xdddddd], [1,1], [63,255], matrix);
			}
			else if (state == "down")
			{
				graphics.beginGradientFill(GradientType.LINEAR, [0xdddddd,0xfdfdfd], [1,1], [63,255], matrix);
			}
			else if (state == "disabled")
			{
				graphics.beginGradientFill(GradientType.LINEAR, [0xfdfdfd,0xfdfdfd], [1,1], [63,255], matrix);
			}
			
			graphics.drawRect(1,1,measuredWidth-2,measuredHeight-2);
			graphics.endFill();	
		}
		
		public function dispose():void
		{
			//_target = null;
		}
	}
}