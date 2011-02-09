package com.sqliagency.as3.controls
{
	import com.sqliagency.as3.core.SkinnableComponent;
	import com.sqliagency.as3.skins.ISkin;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import com.sqliagency.as3.skins.ButtonSkin;
	
	/**
	 * Button
	 * 
	 * states : 
	 * 	- up
	 * 	- over
	 * 	- down
	 * 	- disabled
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class Button extends SkinnableComponent
	{
		private var _text:String = "";

		// Elements graphiques à skinner
		[SkinElement(required="false")]
		public var labelDisplay:TextField;
		
		/**
		 * Constructeur
		 */
		public function Button()
		{
			super();
			state = "up";
			skinClass = ButtonSkin;
		}
		
		/**
		 * Libellé du bouton.
		 */
		public function get text():String
		{
			return _text;
		}
		
		/**
		 * @private
		 */
		public function set text(value:String):void
		{
			_text = value;
			changeProperty("labelDisplay.text", text);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function skinElementAdded(skinName:String, instance:Object):void
		{
			if (skinName == "labelDisplay")
			{
				addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
				addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
				addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
				addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function skinElementRemoved(skinName:String, instance:Object):void
		{
			if (skinName == "labelDisplay")
			{
				removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
				removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
				removeEventListener(MouseEvent.ROLL_OVER, mouseHandler);
				removeEventListener(MouseEvent.ROLL_OUT, mouseHandler);
			}
		}
		
		/**
		 * @private
		 */
		private function mouseHandler(event:MouseEvent):void
		{
			switch (event.type)
			{
				case MouseEvent.MOUSE_DOWN:
					state = "down";
					break;
				
				case MouseEvent.MOUSE_UP:
				case MouseEvent.ROLL_OVER:
					state = "over";
					break;
				
				case MouseEvent.ROLL_OUT:
					state = "up";
					break;
			}
		}
	}
}