package com.sqliagency.as3.systems
{
	import com.sqliagency.as3.controls.Application;
	import com.sqliagency.as3.core.IChildList;
	import com.sqliagency.as3.core.ISprite;
	import com.sqliagency.as3.core.IToolTipable;
	import com.sqliagency.as3.core.IUIComponent;
	import com.sqliagency.as3.core.UIComponent;
	import com.sqliagency.as3.core.core_internal;
	import com.sqliagency.as3.events.PopupMouseEvent;
	import com.sqliagency.as3.managers.PopUpManager;
	import com.sqliagency.as3.managers.ToolTipManager;
	
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	
		use namespace core_internal;
	
	/**
	 * SystemManager
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class SystemManager extends EventDispatcher implements ISystemManager
	{
		private var mainApp:Application;

		/**
		 * Constructeur.
		 */
		public function SystemManager(application:Application)
		{
			mainApp = application;
			createChildren();
			addEventListeners();
		}
		
		public function get loaderInfo():LoaderInfo
		{
			return stage.loaderInfo;
		}
		
		public function get stage():Stage
		{
			return mainApp.stage;
		}
		
		private function createChildren():void
		{
			var container:ISprite;
			
			mainApp.rawChildren = new UIComponent();
			mainApp.popupChildren = new UIComponent();
			mainApp.tooltipChildren = new UIComponent();
			mainApp.cursorChildren = new UIComponent();
			
			mainApp.addChild(rawChildren as DisplayObject);
			mainApp.addChild(popupChildren as DisplayObject);
			mainApp.addChild(tooltipChildren as DisplayObject);
			mainApp.addChild(cursorChildren as DisplayObject);
			
			mainApp.layoutTarget = rawChildren;
			
			// bloque intéractions souris sur les toolTips et sur les cursors
			container = mainApp.tooltipChildren as ISprite;
			container.mouseEnabled = container.mouseChildren = false;
			container = mainApp.cursorChildren as ISprite;
			container.mouseEnabled = container.mouseChildren = false;
		}
		
		private function addEventListeners():void
		{
			stage.addEventListener(Event.RESIZE, resizeHandler, false, 0, true);
			stage.addEventListener(Event.ADDED, addedHandler, false, 0, true);
			
			// gestion globale des tooltips
			if (ToolTipManager.enabled)
			{
				stage.addEventListener(MouseEvent.ROLL_OVER, toolTipHandler , true, 0, true);
				stage.addEventListener(MouseEvent.ROLL_OUT, toolTipHandler , true, 0, true);
			}
			
			// gestion des popups
			stage.addEventListener(MouseEvent.MOUSE_DOWN, popupHandler, false, 0, true);
		}
		
		public function get rawChildren():IChildList
		{
			return mainApp.rawChildren;
		}
		
		public function get popupChildren():IChildList
		{
			return mainApp.popupChildren;
		}
		
		public function get tooltipChildren():IChildList
		{
			return mainApp.tooltipChildren;
		}
		
		public function get cursorChildren():IChildList
		{
			return mainApp.cursorChildren;
		}
		
		protected function resizeHandler(event:Event):void
		{
			// TODO
		}
		
		protected function addedHandler(event:Event):void
		{
			if (event.target is IUIComponent)
			{
				(event.target as IUIComponent).resourceManager = mainApp.resourceManager;
				(event.target as IUIComponent).systemManager = this;
			}
		}
		
		protected function toolTipHandler(event:MouseEvent):void
		{
			var target:IToolTipable = event.target as IToolTipable;
			
			var result:Boolean = (event.eventPhase == EventPhase.CAPTURING_PHASE)
									&& target; 
			
			if (!result)
				return;
			
			switch (event.type)
			{
				case MouseEvent.ROLL_OVER:
					ToolTipManager.createToolTip(target.toolTip, event.stageX, event.stageY, target as DisplayObject);
					break;
				
				case MouseEvent.ROLL_OUT:
					ToolTipManager.destroyToolTip(target);
					break;
				
				default:
					break;
			}
		}
		
		protected function popupHandler(event:MouseEvent):void
		{
			var target:DisplayObject = event.target as DisplayObject;
			
			var i:int;
			var index:int;

			var popups:Array = []; // popups qui vont dispatché l'événement mouseDownOutside
			var popup:DisplayObject;
			
			for (i = 0; i < popupChildren.numChildren; i++)
			{
				popup = popupChildren.getChildAt(i);
				
				if (target.name == "modalBackground")
				{
					index = popupChildren.getChildIndex(target["popUp"]); // Dynamic Property (écrit dans PopupManagerImpl)
					
					// on dispatch l'event uniquement sur la popup modal et sur toutes celles au dessus d'elle
					if (i >= index)
					{
						popups.push(popup);
					}
				}
				else
				{
					index = PopUpManager.core_internal::getLastModalPopUpIndex();
					
					// on dispatch l'event uniquement sur les popup de niveaux supérieur
					// sauf sur la popup qu'on a cliqué
					if (popup !== target)
					{
						if (index > -1)
						{
							if (i >= index)
								popups.push(popup);
						}
						else
						{
							popups.push(popup);
						}
					}
				}
			}
			
			for (i = 0; i < popups.length; i++)
			{
				popup = popups[i];
				popup.dispatchEvent(PopupMouseEvent.createEvent(event, PopupMouseEvent.MOUSE_DOWN_OUTSIDE));
			}
		}
	}
}