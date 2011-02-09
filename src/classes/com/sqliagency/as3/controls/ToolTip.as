package com.sqliagency.as3.controls
{
	import com.sqliagency.as3.core.IToolTip;
	import com.sqliagency.as3.core.core_internal;
	import com.sqliagency.as3.fonts.FontsManager;
	
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.FontType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	use namespace core_internal;
	
	/**
	 * ToolTip
	 * @uthor Nicolas CHENG (sqliagency)
	 */
	public class ToolTip extends Sprite implements IToolTip
	{
		core_internal var textfield:TextField;
		
		private var _text:String;
		private var _screen:Rectangle;
		
		/**
		 * Constructeur.
		 */
		public function ToolTip()
		{
			mouseEnabled = mouseChildren = false;
			
			textfield = new TextField();
			textfield.autoSize = TextFieldAutoSize.LEFT;
			textfield.mouseEnabled = false;
			addChild(textfield);
			
			filters = [new DropShadowFilter(2,90,0x000000,0.2)];
		}
		
		/**
		 * @inheritDoc
		 */
		public function get screen():Rectangle
		{
			return _screen;
		}
		
		/**
		 * @private
		 */
		public function set screen(value:Rectangle):void
		{
			_screen = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get text():String
		{
			return _text;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set text(value:String):void
		{
			if (!value)
				return;
			
			_text = value;
			
			textfield.width = 10;
			textfield.wordWrap = false;
			textfield.multiline = false;
			textfield.text = value;
			
			if (textfield.width > 200)
			{
				textfield.width = 200;
				textfield.wordWrap = true;
				textfield.multiline = true;
				textfield.text = value;
			}
			
			updateDisplayList();
		}
		
		/**
		 * @private
		 * Mise à jour du background de la tooltip.
		 */
		protected function updateDisplayList():void
		{
			var pad:Number = 6;
			graphics.clear();
			
			graphics.beginFill(0xffe08d);
			graphics.drawRect(0,0,textfield.width+2*pad,textfield.height+2);
			graphics.endFill();
			
			graphics.beginFill(0xfbfcaf);
			graphics.drawRect(1,1,textfield.width+2*pad-2,textfield.height);
			graphics.endFill();
			
			textfield.x = pad;
		}
	}
}