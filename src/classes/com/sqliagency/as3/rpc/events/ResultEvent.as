package com.sqliagency.as3.rpc.events {

	import flash.events.Event;
	import com.sqliagency.as3.rpc.AsyncToken;

	public class ResultEvent extends AbstractEvent  {
	
		private var _result:Object;

		public static const RESULT:String = "result";

		public function ResultEvent(type:String, result:Object = null, token:AsyncToken = null) {
			super(type, false, true, token);
			_result = result;
		}

		public function get result():Object {
			return _result;
		}

		override public function clone():Event {
			return new ResultEvent(type, result, token);
		}
		
		override public function toString():String {
			return formatToString("ResultEvent", "type");
		}

		override public function callTokenResponders():void {
			if (token != null)
				token.applyResult(this);
		}
	}
}