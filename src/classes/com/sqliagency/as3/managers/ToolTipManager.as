package com.sqliagency.as3.managers
{
	import com.sqliagency.as3.core.IToolTip;
	import com.sqliagency.as3.core.Singleton;
	import com.sqliagency.as3.core.core_internal;
	
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	
	use namespace core_internal;
	
	/**
	 * ToolTipManager
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ToolTipManager
	{
		private static var _impl:IToolTipManager;

		public static function getInstance():IToolTipManager
		{
			if (!_impl)
			{
				try
				{
					_impl = IToolTipManager(Singleton.getInstance("com.sqliagency.as3.managers::IToolTipManager"));
				}
				catch (err:Error)
				{
					//...
				}
			}
			
			return _impl;
		}
		
		private static function get impl():IToolTipManager
		{
			return ToolTipManager.getInstance();
		}
		
		/**
		 * Constructeur.
		 */
		public function ToolTipManager()
		{
			throw new IllegalOperationError("ToolTipManager must not be instantiated.");
		}
		
		public static function get currentTarget():DisplayObject
		{
			return impl ? impl.currentTarget : null;
		}
		
		public static function set currentTarget(value:DisplayObject):void
		{
			if (impl)
				impl.currentTarget = value;
		}
		
		public static function get currentToolTip():IToolTip
		{
			return impl ? impl.currentToolTip : null;
		}
		
		public static function set currentToolTip(value:IToolTip):void
		{
			if (impl)
				impl.currentToolTip = value;
		}
		
		public static function get enabled():Boolean
		{
			return impl ? impl.enabled : false;
		}
		
		public static function set enabled(value:Boolean):void
		{
			if (impl)
				impl.enabled = value;
		}
		
		public static function get hideDelay():Number
		{
			return impl ? impl.hideDelay : NaN;
		}
		
		public static function set hideDelay(value:Number):void
		{
			if (impl)
				impl.hideDelay = value;
		}
		
		public static function get showDelay():Number
		{
			return impl ? impl.showDelay : NaN;
		}
		
		public static function set showDelay(value:Number):void
		{
			if (impl)
				impl.showDelay = value;
		}
		
		public static function get toolTipClass():Class
		{
			return impl ? impl.toolTipClass : undefined;
		}

		public static function set toolTipClass(value:Class):void
		{
			if (impl)
				impl.toolTipClass = value;
		}
		
		/*
		core_internal static function registerToolTip(target:DisplayObject, oldToolTip:String, newToolTip:String):void
		{
			if (impl)
				impl.registerToolTip(target, oldToolTip, newToolTip);
		}
		
		core_internal static function sizeTip(toolTip:IToolTip):void
		{
			if (impl)
				impl.sizeTip(toolTip);
		}
		*/
		
		public static function showToolTip(toolTip:IToolTip):void
		{
			if (impl)
				impl.showToolTip(toolTip);
		}
		
		public static function hideToolTip(toolTip:IToolTip):void
		{
			if (impl)
				impl.hideToolTip(toolTip);
		}
		
		public static function createToolTip(text:String, x:Number, y:Number, target:DisplayObject):IToolTip
		{
			return impl ? impl.createToolTip(text, x, y, target) : null;
		}
		
		public static function destroyToolTip(value:*=null):void
		{
			if (impl)
				impl.destroyToolTip(value);
		}
	}
}