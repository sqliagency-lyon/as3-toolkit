package com.sqliagency.as3.controls.accordionClasses 
{
	import com.sqliagency.as3.controls.Accordion;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class AccordionHeader extends MovieClip
	{
		public var label_txt:TextField;
		private var _id:int;
		
		public function AccordionHeader() 
		{
			buttonMode = true;
			mouseChildren = false;
		}
		
		public function set label (value:String):void
		{
			label_txt.text = value;
		}
		
		public function get id ():int
		{
			return _id;
		}
		
		public function set id (value:int):void
		{
			_id = value;
		}
	}
}