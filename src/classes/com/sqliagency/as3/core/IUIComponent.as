package com.sqliagency.as3.core 
{
	import com.sqliagency.as3.layout.ILayout;
	import com.sqliagency.as3.resources.IResourceManager;
	import com.sqliagency.as3.systems.ISystemManager;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * IUIComponent
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IUIComponent extends ISprite, IDisposable
	{
		function get initialized():Boolean;
		function get resourceManager():IResourceManager;
		function set resourceManager(value:IResourceManager):void;
		function get systemManager():ISystemManager;
		function set systemManager(value:ISystemManager):void;
		function get layout():ILayout;
		function set layout(value:ILayout):void;
	}
}