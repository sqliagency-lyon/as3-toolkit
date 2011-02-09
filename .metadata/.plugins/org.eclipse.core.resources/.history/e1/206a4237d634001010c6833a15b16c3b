package com.sqliagency.as3.ui
{
	import com.sqliagency.as3.core.ApplicationGlobals;
	import com.sqliagency.as3.core.IChildList;
	import com.sqliagency.as3.core.ISprite;
	import com.sqliagency.as3.core.IUIComponent;
	import com.sqliagency.as3.managers.ToolTipManager;
	import com.sqliagency.as3.systems.ISystemManager;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.ui.Mouse;

	/**
	 * CursorManagerImpl
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class CursorManagerImpl implements ICursorManager
	{
		private static var instance:CursorManagerImpl;
		
		private var _currentID:int;
		protected var cursors:Array;
		
		protected var currentCursor:DisplayObject;
		
		/**
		 * Constructeur.
		 */
		public function CursorManagerImpl()
		{
			// on enregistre le cursor busy (par défaut)
			setCursor(BusyCursorSkin);
		}
		
		/**
		 * Obtient l'instance unique du CursorManagerImpl.
		 * @return instance
		 */
		public static function getInstance():CursorManagerImpl
		{
			if (!instance)
			{
				instance = new CursorManagerImpl();
			}
			
			return instance;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get currentID():int
		{
			return _currentID;
		}
		
		public function showCursor():void 
		{
			setCursorOnScreen(1);
		}
		
		public function hideCursor():void 
		{
			setCursorOnScreen(0);
		}
		
		public function setCursor(cursorClass:Class, priority:int=2, xOffset:Number = 0, yOffset:Number = 0):void 
		{
			if (!cursors)
				cursors = [null,null,null];
			
			// no_cursor = 0
			// idle_cursor = 1
			// busy_cursor = 2
			
			if (0 > priority || priority > 4)
				return;
			
			cursors[priority] = { cursorClass:cursorClass, priority:priority, xOffset:xOffset, yOffset:yOffset };
		}
		
		public function setBusyCursor():void 
		{
			setCursorOnScreen(2);
		}
		
		public function removeBusyCursor():void 
		{
			setCursorOnScreen(1);
		}
		
		protected function setCursorOnScreen(priority:int):void
		{
			if (priority == currentID)
				return;
			
			var cursorInfo:Object = cursors[priority];
			
			// on enleve tout curseur présent à l'écran
			Mouse.hide();
			removeCursorOnScreen();
			
			// si données curseur
			if (cursorInfo)
			{
				addCursorOnScreen(cursorInfo);
			}
			else
			{
				// si aucune donnée curseur et qu'un curseur doit être affiché
				// alors faire réapparaitre le curseur
				if (priority > 0)
					Mouse.show();
			}
			
			_currentID = priority;
		}
		
		/**
		 * @private
		 */
		protected function addCursorOnScreen(cursorInfo:Object):void
		{
			var systemManager:ISystemManager = (ApplicationGlobals.topLevelApplication as IUIComponent).systemManager;
			
			var parent:DisplayObjectContainer = systemManager.cursorChildren as DisplayObjectContainer;
			
			var container:ISprite;
			
			// busy cursor qu'on affiche ?
			if (cursorInfo.priority == 2)
			{
				// bloque les intéractions souris sur les composants enfants de l'application
				/*
				container = systemManager.rawChildren as ISprite;
				container.mouseEnabled = container.mouseChildren = false;
				container = systemManager.popupChildren as ISprite;
				container.mouseEnabled = container.mouseChildren = false;
				*/
				
				// enlève toute tooltip présente sur la scène
				ToolTipManager.destroyToolTip();
			}
			
			currentCursor = new cursorInfo.cursorClass();
			currentCursor.x = systemManager.stage.mouseX + cursorInfo.xOffset;
			currentCursor.y = systemManager.stage.mouseY + cursorInfo.yOffset;
			parent.addChild(currentCursor);
			
			// faire suivre le déplacement de la souris
			var c:Sprite = currentCursor as Sprite;
			if (c)
				c.startDrag();
		}
		
		/**
		 * @private
		 */
		protected function removeCursorOnScreen():void
		{
			var systemManager:ISystemManager = (ApplicationGlobals.topLevelApplication as IUIComponent).systemManager;
			
			var parent:DisplayObjectContainer;
			var c:Sprite;
			
			if (currentCursor)
			{
				c = currentCursor as Sprite;
				
				if (c)
					c.stopDrag();
				
				parent = currentCursor.parent;
				parent.removeChild(currentCursor);
				
				if (currentID==2)
				{
					var container:ISprite;
					// débloque les intéractions souris sur les composants enfants de l'application
					/*
					container = systemManager.rawChildren as ISprite;
					container.mouseEnabled = container.mouseChildren = false;
					container = systemManager.popupChildren as ISprite;
					container.mouseEnabled = container.mouseChildren = false;
					*/
				}
			}
			
			currentCursor = null;
		}
	}
}