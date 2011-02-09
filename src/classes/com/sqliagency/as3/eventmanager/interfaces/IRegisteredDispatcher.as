package com.sqliagency.as3.eventmanager.interfaces
{
	import flash.events.IEventDispatcher;
	
	public interface IRegisteredDispatcher extends IEventDispatcher
	{
		function getEvents():Array;
	}
}