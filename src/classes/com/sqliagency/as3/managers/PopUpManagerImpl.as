package com.sqliagency.as3.managers
{
	import com.sqliagency.as3.core.ApplicationGlobals;
	import com.sqliagency.as3.core.IChildList;
	import com.sqliagency.as3.core.IPopUp;
	import com.sqliagency.as3.core.ISprite;
	import com.sqliagency.as3.core.IUIComponent;
	import com.sqliagency.as3.systems.ISystemManager;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.utils.Dictionary;
	
	/**
	 * PopupManagerImpl
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class PopUpManagerImpl implements IPopUpManager
	{
		private static var instance:IPopUpManager;
		
		private var popupDescriptors:Dictionary = new Dictionary(true);
		
		private static const MODAL_BLUR:Number = 2;
		private static const MODAL_COLOR:uint = 0xafafaf;
		private static const MODAL_ALPHA:Number = 0.2;
		
		/**
		 *  @private
		 */
		public static function getInstance():IPopUpManager
		{
			if (!instance)
				instance = new PopUpManagerImpl();
			
			return instance;
		}
		
		/**
		 * Constructeur.
		 */
		public function PopUpManagerImpl()
		{
		}
		
		protected function get systemManager():ISystemManager
		{
			return (ApplicationGlobals.topLevelApplication as IUIComponent).systemManager;
		}
		
		public function createPopUp(parent:DisplayObject, className:Class, modal:Boolean=false):IPopUp
		{
			var popup:IPopUp = new className() as IPopUp;
			
			if (!popup)
				throw new ArgumentError("La popup n'est pas du type IPopUp");
			
			addPopUp(popup, parent, modal);
			
			return popup;
		}
		
		public function addPopUp(window:IPopUp, parent:DisplayObject, modal:Boolean=false):void
		{
			var modalBackground:MovieClip;
			
			// popup est modal ?
			if (modal)
			{
				modalBackground = new MovieClip();
				modalBackground.name = "modalBackground";
				modalBackground.graphics.beginFill(MODAL_COLOR, MODAL_ALPHA);
				modalBackground.graphics.drawRect(0,0,systemManager.stage.stageWidth, systemManager.stage.stageHeight);
				modalBackground.graphics.endFill();
				
				// applique un flou sur toute l'application
				(systemManager.rawChildren as ISprite).filters = [new BlurFilter(MODAL_BLUR,MODAL_BLUR)];
				
				for (var i:int = 0; i < systemManager.popupChildren.numChildren; i++)
				{
					systemManager.popupChildren.getChildAt(i).filters = [new BlurFilter(MODAL_BLUR,MODAL_BLUR)];
				}
				
				systemManager.popupChildren.addChild(modalBackground);
				
				// mise à jour de l'index de la dernière popup modal
				_lastModalPopUpIndex = systemManager.popupChildren.numChildren-1;
				
				modalBackground["popUp"] = window;			// Dynamic Property (lu dans SystemManager)
			}
			
			systemManager.popupChildren.addChild(window as DisplayObject);
			
			// listeners sur les popups ajoutés (bloc les combobox!!!!)
			//(window as DisplayObject).addEventListener(MouseEvent.MOUSE_DOWN, popupBlockMouseDown, true, 0, false);
			
			var descriptor:PopupDescriptor = new PopupDescriptor();
			descriptor.popUp = window;
			descriptor.parent = parent;
			descriptor.modal = modal;
			descriptor.modalBackground = modalBackground;
			
			// dropshadow
			(window as DisplayObject).filters = [new GlowFilter(  0x000000, 0.2, 32, 64, 1 )];
			
			popupDescriptors[window] = descriptor;
		}
		
		/**
		 * Stop la propagation des événements mouseDown d'une popup
		 * Nécessaire pour mouseOutsideDown (voir SystemManager)
		 */
		private function popupBlockMouseDown(event:MouseEvent):void
		{
			//event.stopPropagation();
		}
		
		public function centerPopUp(popUp:IPopUp):void
		{
			if (popupDescriptors[popUp])
			{
				var child:DisplayObject = popUp as DisplayObject;
				
				child.x = (systemManager.stage.stageWidth - child.width) / 2;
				child.y = (systemManager.stage.stageHeight - child.height) / 2;
			}
		}
		
		public function removePopUp(popUp:IPopUp):void
		{
			var descriptor:PopupDescriptor = popupDescriptors[popUp];
			var container:IChildList;
			
			if (descriptor)
			{
				container = systemManager.popupChildren;
				
				popUp.dispose();
				container.removeChild(popUp as DisplayObject);
				
				// enlève les listeners
				//(popUp as DisplayObject).removeEventListener(MouseEvent.MOUSE_DOWN, popupBlockMouseDown, true);
				
				if (descriptor.modal)
				{
					container.removeChild(descriptor.modalBackground);
				}

				// popup(s) en dessous de celle supprimée ?
				if (container.numChildren > 0)
				{
					var underPopup:IPopUp = container.getChildAt(container.numChildren-1) as IPopUp;
					
					descriptor = popupDescriptors[underPopup];
					
					// on enleve le flou qu'il y a sur la dernière popup
					(underPopup as DisplayObject).filters = [];
					
					if (descriptor.modal)
					 {
						// mise à jour de l'index de la dernière popup modal
						_lastModalPopUpIndex = systemManager.popupChildren.numChildren-1;
					 }
					else
					{
						retrieveLastModalPopUpIndex();
					}
				}
				
				if (_lastModalPopUpIndex == -1 || systemManager.popupChildren.numChildren == 0)
				{
					// on enleve le flou qui avait été mis sur toute l'application
					// puisqu'il n'y a plus de popups ou plus aucune popup modal
					(systemManager.rawChildren as ISprite).filters = [];
				}
				
				delete popupDescriptors[popUp];
			}
		}
		
		public function bringToFront(popUp:IPopUp):void
		{
			var descriptor:PopupDescriptor = popupDescriptors[popUp];
			
			if (descriptor)
			{
				if (descriptor.modal)
				{
					for (var i:int = 0; i < systemManager.popupChildren.numChildren; i++)
					{
						systemManager.popupChildren.getChildAt(i).filters = [new BlurFilter(MODAL_BLUR,MODAL_BLUR)];
					}
					
					systemManager.popupChildren.setChildIndex(descriptor.modalBackground, systemManager.popupChildren.numChildren);
					descriptor.modalBackground.filters = [];
					
					// mise à jour de l'index de la dernière popup modal
					_lastModalPopUpIndex = systemManager.popupChildren.numChildren-1;
				}
				
				systemManager.popupChildren.setChildIndex(popUp as DisplayObject, systemManager.popupChildren.numChildren);
				popUp.filters = [];
			}
		}
		
		private var _lastModalPopUpIndex:int = -1;
		
		public function getLastModalPopUpIndex():int
		{
			return _lastModalPopUpIndex;
		}
		
		private function retrieveLastModalPopUpIndex():void
		{
			var container:IChildList = systemManager.popupChildren;
			var popup:DisplayObject;
			
			_lastModalPopUpIndex = -1;
			
			for (var i:int = container.numChildren-1; i >=0; i--)
			{
				popup = container.getChildAt(i);
				
				if (popup is IPopUp)
				{
					if (popupDescriptors[popup].modal)
					{
						_lastModalPopUpIndex = i;
						break;
					}
				}
			}
		}
	}
}

import com.sqliagency.as3.core.IPopUp;

import flash.display.DisplayObject;
import flash.display.MovieClip;

internal class PopupDescriptor
{
	public var popUp:IPopUp;
	public var modal:Boolean;
	public var modalBackground:MovieClip;
	public var parent:DisplayObject;
}