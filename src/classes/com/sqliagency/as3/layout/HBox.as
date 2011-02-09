package com.sqliagency.as3.layout 
{
	import flash.display.DisplayObject;
	
	public class HBox 
	{
		private var _array:Array;
		private var _spacer:Number;
		private var _width:Number;
		
		public function HBox (spacer:Number=0, width:Number = 0) 
		{
			_spacer = spacer;
			_width = width;
		}
		
		public function set children (value:Array):void
		{
			_array = value;
			_process();
		}
		
		private function _process ():void
		{
			var bool:Boolean = _array.every(_isDisplayObject);
			
			if (!bool)
				throw new ArgumentError("HBox allows only DisplayObject children");
				
			_array.forEach(_moveTo);
			center();
		}
		
		private function center ():void
		{
			if (_width > 0)
			{
				var nb:int = _array.length;
				var need:Number = _array[nb - 1].x + _array[nb - 1].width - _array[0].x;
				
				var startX:Number = (_width - need) / 2;
				
				var offsetX:Number = (startX - _array[0].x);
				
				for (var i:int = 0; i < nb; i++)
				{
					_array[i].x += offsetX;
				}
			}
		}
		
		private function _isDisplayObject (element:*, index:int, arr:Array):Boolean
		{
            return (element is DisplayObject);
        }
		
		private function _moveTo (element:*, index:int, arr:Array):void
		{
			var thisChild:DisplayObject = element as DisplayObject;
			
			if (index < 1)
				return;
				
			var beforeChild:DisplayObject = _array[--index] as DisplayObject;
			
			thisChild.x = beforeChild.x + beforeChild.width + _spacer;
		}
	}
}