package com.sqliagency.as3.controls 
{
	import com.sqliagency.as3.controls.accordionClasses.AccordionHeader;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	//import gs.easing.*;
	//import gs.*;
	
	/**
	 * Classe Accordion
	 * @author Nicolas CHENG (sqliagency)
	 * @created ??
	 * @modified 23/03/2010 [Nicolas CHENG]
	 * 
	 */
	public class Accordion extends MovieClip
	{
		protected var headerHeight:Number = 22;
		protected var openDuration:Number = 0.5;
		//protected var openEasingFunction:Function = Expo.easeIn;
		
		protected var minWidth:Number = 120;
		protected var totalHeight:Number = 180;
		
		protected var headerClass:Class = AccordionHeader;
		
		protected var panes:Array;
		private var _selectedPane:int = -1;
		
		public function Accordion ()
		{
			panes = new Array();
			
			init();
		}
		
		protected function init():void
		{
			addMask();
		}
		
		protected function addMask ():void {
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x000000);
			shape.graphics.drawRect(0, 0, minWidth, totalHeight);
			shape.graphics.endFill();
		
			addChild(shape);
			this.mask = shape;
		}
		
		public function addPane (container:DisplayObjectContainer, name:String=""):void
		{
			if (container is Stage)
				throw new ArgumentError("Stage must not be a pane in Accordion");
			
			var pane:Sprite = createPane(container, name);
			attachPane(pane);
		}
		
		private function attachPane (pane:Sprite):void
		{
			pane.y = headerHeight * length;
			addChild(pane);
			panes.push(pane);
			_selectedPane++;
		}
		
		protected function createPane(container:DisplayObjectContainer, name:String):Sprite
		{
			var pane:Sprite = new Sprite();
			
			// header
			var header:AccordionHeader;
			if (headerClass)
			{
				header = new headerClass();
				header.width = minWidth;
				header.label = name;
				header.id = panes.length;
				header.addEventListener(MouseEvent.CLICK, headerHandler);
				pane.addChild(header);
			}
			
			// body
			container.y = (header) ? header.height : 0;
			
			pane.addChild(container);
			
			return pane;
		}
		
		protected function headerHandler(event:MouseEvent):void
		{
			var target:AccordionHeader = event.target as AccordionHeader;
			
			if (target)
				selectedPane = target.id;
		}
		
		public function get length ():int
		{
			return panes.length;
		}
		
		public function get selectedPane():int
		{
			return _selectedPane;
		}
		
		public function set selectedPane(value:int):void
		{
			movePanes(value);
			_selectedPane = value;
		}
		
		protected function movePanes(value:int, tween:Boolean=true):void
		{
			var duration:Number = (tween) ? openDuration : 0;
			
			if (value > selectedPane)
			{
				value++;
				for (var i:int = 1; i < value; i++)
				{
					//TweenLite.to (panes[i], duration, { y:i * headerHeight, ease:openEasingFunction } );
				}
			}
			else if (value < selectedPane)
			{
				value++;
				for (var j:int = value; j < length; j++)
				{
					//TweenLite.to (panes[j], duration, { y:totalHeight - (length - j) * headerHeight, ease:openEasingFunction } );
				}
			}
		}
	}
}