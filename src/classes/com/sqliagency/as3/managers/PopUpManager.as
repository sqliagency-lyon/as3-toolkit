package com.sqliagency.as3.managers
{
	import com.sqliagency.as3.core.IPopUp;
	import com.sqliagency.as3.core.IUIComponent;
	import com.sqliagency.as3.core.Singleton;
	import com.sqliagency.as3.core.core_internal;
	
	import flash.display.DisplayObject;
	
		use namespace core_internal;
	

	/**
	 * PopUpManager
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class PopUpManager
	{
		private static var _impl:IPopUpManager;
		
		private static function get impl():IPopUpManager
		{
			if (!_impl)
			{
				try
				{
					_impl = IPopUpManager(Singleton.getInstance("com.sqliagency.as3.managers::IPopUpManager"));
				}
				catch (err:Error)
				{
					Singleton.registerClass("com.sqliagency.as3.managers::IPopUpManager", PopUpManagerImpl);
					_impl = IPopUpManager(Singleton.getInstance("com.sqliagency.as3.managers::IPopUpManager"));
				}
			}
			
			return _impl;
		}
		
		public static function createPopUp(parent:DisplayObject,
										   className:Class,
										   modal:Boolean = false):IPopUp
		{   
			return (impl) ? impl.createPopUp(parent, className, modal) : null;
		}
		
		public static function addPopUp(window:IPopUp,
										parent:DisplayObject,
										modal:Boolean = false):void
		{
			if (impl)
				impl.addPopUp(window, parent, modal);
		}
		
		public static function centerPopUp(popUp:IPopUp):void
		{
			if (impl)
				impl.centerPopUp(popUp);
		}
		
		public static function removePopUp(popUp:IPopUp):void
		{
			if (impl)
				impl.removePopUp(popUp);
		}
		
		public static function bringToFront(popUp:IPopUp):void
		{
			if (impl)
				impl.bringToFront(popUp);
		}
		
		core_internal static function getLastModalPopUpIndex():int
		{
			return (impl) ? impl.getLastModalPopUpIndex() : -1;
		}
	}
}