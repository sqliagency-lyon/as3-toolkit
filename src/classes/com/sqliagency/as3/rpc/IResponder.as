package com.sqliagency.as3.rpc
{	
	public interface IResponder
	{	
		function result(data:Object):void;
		function fault(info:Object):void;
	}
}