package com.sqliagency.as3.systems
{
	import com.sqliagency.as3.core.IChildList;
	
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	
	/**
	 * Classe maintenant de multiples enfants : windows, popups, tooltips, cursors.
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface ISystemManager extends IEventDispatcher
	{
		function get loaderInfo():LoaderInfo;
		function get stage():Stage;
		function get rawChildren():IChildList;
		function get popupChildren():IChildList;
		function get tooltipChildren():IChildList;
		function get cursorChildren():IChildList;
	}
}