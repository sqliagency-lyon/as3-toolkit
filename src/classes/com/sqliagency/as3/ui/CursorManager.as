package com.sqliagency.as3.ui
{
	import com.sqliagency.as3.core.Singleton;
	
	import flash.errors.IllegalOperationError;
	
	/**
	 * CursorManager
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class CursorManager
	{
		private static var _impl:ICursorManager;
		
		public static const NO_CURSOR:int = 0;
		public static const IDLE_CURSOR:int = 1;
		public static const BUSY_CURSOR:int = 2;
		
		/**
		 * Constructeur.
		 */
		public function CursorManager()
		{
			throw new IllegalOperationError("CursorManager must not be instantiated.");
		}
		
		public static function getInstance():ICursorManager
		{
			if (!_impl)
			{
				try
				{
					_impl = ICursorManager(Singleton.getInstance("com.sqliagency.as3.ui::ICursorManager"));
				}
				catch (err:Error)
				{
					//...
				}
			}
			
			return _impl;
		}
		
		private static function get impl():ICursorManager
		{
			return (!_impl) ? CursorManager.getInstance() : _impl;
		}
		
		public static function showCursor():void
		{
			if (impl)
				impl.showCursor();
		}
		
		public static function hideCursor():void
		{
			if (impl)
				impl.hideCursor();
		}
		
		public static function setCursor(cursorClass:Class, priority:int=2, xOffset:Number = 0, yOffset:Number = 0):void
		{
			if (impl)
				impl.setCursor(cursorClass, priority, xOffset, yOffset);
		}
		
		public static function setBusyCursor():void
		{
			if (impl)
				impl.setBusyCursor();
		}
		
		public static function removeBusyCursor():void
		{
			if (impl)
				impl.removeBusyCursor();
		}
	}
}