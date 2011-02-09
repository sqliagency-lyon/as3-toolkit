package com.sqliagency.as3.core 
{
	import com.sqliagency.as3.layout.ILayout;
	import com.sqliagency.as3.resources.IResourceManager;
	import com.sqliagency.as3.systems.ISystemManager;
	import com.sqliagency.as3.utils.StringUtil;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;

	use namespace core_internal;
	
	/**
	 * Composant de Base pour tous les composants
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class UIComponent extends Sprite implements IUIComponent, IChildList, IToolTipable
	{	
		protected var _systemManager:ISystemManager;
		protected var _resourceManager:IResourceManager;
		protected var _layout:ILayout;
		
		private var preinitialized:Boolean;
		private var _initialized:Boolean;
		
		protected var _width:Number;
		protected var _height:Number;
		protected var _toolTip:String;
		
		core_internal var layoutTarget:IChildList;
		
		/**
		 * Constructeur.
		 */
		public function UIComponent() 
		{
			layoutTarget = this;
			
			if (!stage)
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			else
				_initialize();
		}
		
		/**
		 * @private
		 */
		core_internal function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, core_internal::onAddedToStage, false);
			_initialize();
		}
		
		/**
		 * @private
		 */
		core_internal function preinitialize():void
		{
			// à redéfinir dans certains cas très spécifique
		}
		
		/**
		 * @private
		 */
		public function set systemManager(value:ISystemManager):void
		{
			_systemManager = value;
		}
		
		/**
		 * @private
		 */
		public function set resourceManager(value:IResourceManager):void
		{
			_resourceManager = value;
		}
		
		/**
		 * @inheritDoc
		 */
		[Bindable]
		public function get initialized():Boolean
		{
			return _initialized;
		}
		
		private function set initialized(value:Boolean):void
		{
			_initialized = true;
		}
		
		/**
		 * @private
		 */
		private function _initialize():void
		{
			if (!preinitialized)
			{
				preinitialize();
				preinitialized = true;
			}
			initialize();
			initialized = true;
		}
		
		/**
		 * Initialise le composant.
		 */
		protected function initialize():void
		{
			// à redéfinir
		}
		
		/**
		 * Libère le composant de toutes ses références.
		 */
		public function dispose():void
		{
			if (layout)
				layout.dispose();
			layout = null;
			resourceManager = null;
			systemManager = null;
		}
		
		/**
		 * Le resourceManager du composant.
		 */
		public function get resourceManager():IResourceManager
		{
			return _resourceManager;
		}
		
		/**
		 * Le systemManager du composant.
		 */
		public function get systemManager():ISystemManager
		{
			return _systemManager;
		}
		
		/**
		 * Le layout qui est appliqué aux enfants du composant.
		 */
		public function get layout():ILayout
		{
			return _layout;
		}
		
		/**
		 * @private 
		 */
		public function set layout(value:ILayout):void
		{
			_layout = value;
			
			if (_layout)
			{
				_layout.target = layoutTarget;
				_layout.apply();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addChild(child:DisplayObject):DisplayObject
		{
			var parent:DisplayObjectContainer = layoutTarget as DisplayObjectContainer;
			
			if (parent === this)
			{
				child = super.addChild(child);
			}
			else
			{
				child = parent.addChild(child);
			}
			
			if (layout)
				layout.apply();
			
			return child;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			var parent:DisplayObjectContainer = layoutTarget as DisplayObjectContainer;
			
			if (parent === this)
			{
				child = super.addChildAt(child, index);
			}
			else
			{
				child = parent.addChildAt(child, index);
			}
			
			if (layout)
				layout.apply();
			
			return child;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			var parent:DisplayObjectContainer = layoutTarget as DisplayObjectContainer;
			
			if (parent === this)
			{
				child = super.removeChild(child);
			}
			else
			{
				child = parent.removeChild(child);
			}
			
			if (layout)
				layout.apply();
			
			return child;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildAt(index:int):DisplayObject
		{
			var parent:DisplayObjectContainer = layoutTarget as DisplayObjectContainer;
			var child:DisplayObject;
			
			if (parent === this)
			{
				child = super.removeChildAt(index);
			}
			else
			{
				child = parent.removeChildAt(index);
			}
			
			if (layout)
				layout.apply();
			
			return child;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get numChildren():int
		{
			var parent:DisplayObjectContainer = layoutTarget as DisplayObjectContainer;
			var num:int;
			
			if (parent === this)
			{
				num = super.numChildren;
			}
			else
			{
				num = parent.numChildren;
			}
			
			return num;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set width(value:Number):void
		{
			_width = Math.round(value);
			super.width = _width;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set height(value:Number):void
		{
			_height = Math.round(value);
			super.height = _height;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get toolTip():String
		{
			return _toolTip;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set toolTip(value:String):void
		{
			_toolTip = value ? StringUtil.trim(value) : "";
		}
	}
}