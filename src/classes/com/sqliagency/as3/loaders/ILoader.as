package com.sqliagency.as3.loaders
{
	import com.sqliagency.as3.core.IDisposable;
	
	import flash.events.IEventDispatcher;
	import flash.system.LoaderContext;

	[Event(name="complete", 		type="flash.events.Event")]
	[Event(name="httpStatus", 		type="flash.events.HTTPStatusEvent")]
	[Event(name="init", 			type="flash.events.Event")]
	[Event(name="ioError", 			type="flash.events.IOErrorEvent")]
	[Event(name="open", 			type="flash.events.Event")]
	[Event(name="progress", 		type="flash.events.ProgressEvent")]
	[Event(name="securityError",	type="flash.events.SecurityErrorEvent")]
	
	/**
	 * ILoader
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface ILoader extends IEventDispatcher, IDisposable
	{
		function get bytesLoaded():uint;
		function get bytesTotal():uint;
		function get data():*;
		function get dataFormat():String;
		function set dataFormat(value:String):void;
		function load(url:String, context:LoaderContext=null):void;
		function close():void;
	}
}