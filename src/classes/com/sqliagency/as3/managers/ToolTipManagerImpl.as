package com.sqliagency.as3.managers
{
	import com.sqliagency.as3.controls.ToolTip;
	import com.sqliagency.as3.core.ApplicationGlobals;
	import com.sqliagency.as3.core.IChildList;
	import com.sqliagency.as3.core.IToolTip;
	import com.sqliagency.as3.core.IToolTipable;
	import com.sqliagency.as3.core.IUIComponent;
	import com.sqliagency.as3.core.core_internal;
	import com.sqliagency.as3.systems.ISystemManager;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import mx.core.mx_internal;
	
	use namespace core_internal;
	
	/**
	 * ToolTipManagerImpl
	 * 
	 * Note : Dans cette implémentation, une seule tooltip peut être affiché à l'écran.
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ToolTipManagerImpl implements IToolTipManager
	{
		private var _currentTarget:DisplayObject;
		private var _currentToolTip:IToolTip;
		private var _toolTipClass:Class = ToolTip;
		private var _enabled:Boolean = true;
		private var _hideDelay:Number = 2000;
		private var _showDelay:Number = 250;
		
		private var show_timer:Timer;
		private var hide_timer:Timer;
		
		/**
		 *  @private
		 */
		private static var instance:IToolTipManager;
		
		/**
		 *  @private
		 */
		public static function getInstance():IToolTipManager
		{
			if (!instance)
				instance = new ToolTipManagerImpl();
			
			return instance;
		}
		
		/**
		 * Constructeur.
		 */
		public function ToolTipManagerImpl()
		{
			show_timer = new Timer(showDelay,1);
			hide_timer = new Timer(hideDelay,1);
			
			show_timer.addEventListener(TimerEvent.TIMER_COMPLETE, show_timer_handler, false, 0, true);
			hide_timer.addEventListener(TimerEvent.TIMER_COMPLETE, hide_timer_handler, false, 0, true);
		}
		
		///////////////////////////////////////////////////////////////////////////////////////
		
		public function get currentTarget():DisplayObject
		{
			return _currentTarget;
		}
		
		public function set currentTarget(value:DisplayObject):void
		{
			_currentTarget = value;
		}
		
		public function get currentToolTip():IToolTip
		{
			return _currentToolTip;
		}
		
		public function set currentToolTip(value:IToolTip):void
		{
			_currentToolTip = value;
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}
		
		public function get hideDelay():Number
		{
			return _hideDelay;
		}
		
		public function set hideDelay(value:Number):void
		{
			_hideDelay = value;
		}
		
		public function get showDelay():Number
		{
			return _showDelay;
		}
		
		public function set showDelay(value:Number):void
		{
			_showDelay = value;
		}
		
		public function get toolTipClass():Class
		{
			return _toolTipClass;
		}
		
		public function set toolTipClass(value:Class):void
		{
			_toolTipClass = value;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////
		
		private function show_timer_handler(event:TimerEvent):void
		{
			var sm:ISystemManager = (ApplicationGlobals.topLevelApplication as IUIComponent).systemManager;
			
			if (currentToolTip)
			{
				sm.tooltipChildren.addChild(currentToolTip as DisplayObject);
				positionTip();
				
				hide_timer.reset();
				hide_timer.start();
			}
		}
		
		private function hide_timer_handler(event:TimerEvent):void
		{
			var sm:ISystemManager = (ApplicationGlobals.topLevelApplication as IUIComponent).systemManager;
			
			if (currentToolTip)
			{
				destroyToolTip(currentToolTip);
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////
		
		/*
		public function registerToolTip(target:DisplayObject, oldToolTip:String, newToolTip:String):void
		{
		
		}
		
		public function sizeTip(toolTip:IToolTip):void
		{
		
		}
		*/
		
		/**
		 * @private
		 * Ajout d'une 'custom' toolTip dans la liste d'affichage
		 */
		public function showToolTip(toolTip:IToolTip):void
		{
			var sm:ISystemManager = (ApplicationGlobals.topLevelApplication as IUIComponent).systemManager;
			sm.tooltipChildren.addChild(toolTip as DisplayObject);
		}
		
		/**
		 * @private
		 * Enlève une 'custom' toolTip ajouté précédemment
		 */
		public function hideToolTip(toolTip:IToolTip):void
		{
			var sm:ISystemManager = (ApplicationGlobals.topLevelApplication as IUIComponent).systemManager;
			var childList:IChildList = sm.tooltipChildren;
			
			var index:int = -1;
			
			for (var i:int = 0; i < childList.numChildren; i++)
			{
				if (childList.getChildAt(i) === toolTip)
				{
					index = i;
					break;
				}
			}
			
			if (index > -1)
			{
				childList.removeChildAt(index);
			}
		}
		
		public function createToolTip(text:String, x:Number, y:Number, target:DisplayObject=null):IToolTip
		{
			if (!enabled || !text || text == "")
				return null;
			
			// détruit la dernière tooltip si jamais y en a une
			destroyToolTip();
			
			var toolTip:DisplayObject = new toolTipClass() as DisplayObject;
			var sm:ISystemManager = (ApplicationGlobals.topLevelApplication as IUIComponent).systemManager;
			
			(toolTip as IToolTip).text = text;
			(toolTip as IToolTip).screen = target ? target.getBounds(sm.stage) : null;
			
			toolTip.x = x;
			toolTip.y = y;

			currentTarget = target;
			currentToolTip = toolTip as IToolTip;
			
			hide_timer.stop();
			show_timer.reset();
			show_timer.start();
			
			return currentToolTip;
		}
		
		protected function positionTip():void
		{
			var stage:Stage = (ApplicationGlobals.topLevelApplication as IUIComponent).systemManager.stage;

			if (!currentToolTip)
				return;
			
			var child:DisplayObject = currentToolTip as DisplayObject;
			
			if (child.x < 0)
			{
				child.x = 0;
			}
			else if (child.x + child.width > stage.stageWidth)
			{
				child.x -= Math.ceil(child.x + child.width - stage.stageWidth); 
			}
			
			if (child.y < 0)
			{
				child.y = 0;
			}
			else if (child.y + child.height > stage.stageHeight)
			{
				child.y -= Math.ceil(child.y + child.height - stage.stageHeight); 
			}
		}
		
		public function destroyToolTip(value:*=null):void
		{
			var sm:ISystemManager = (ApplicationGlobals.topLevelApplication as IUIComponent).systemManager;
			
			if (!value)
			{
				value = currentToolTip;
			}
			else if (value is IToolTip)
			{
				value = (currentToolTip === value) ? currentToolTip : null;
			}
			else if (value is IToolTipable)
			{
				value = (currentTarget === value) ? currentToolTip : null;
			}
			
			if (!enabled || !value)
				return;

			try
			{
				sm.tooltipChildren.removeChild(value as DisplayObject);
			}
			catch (err:Error)
			{
				// ...
			}
			
			if (value === currentToolTip)
			{
				currentTarget = null;
				currentToolTip = null;
			}
		}
	}
}