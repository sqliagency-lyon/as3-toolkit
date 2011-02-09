package com.sqliagency.as3.eventmanager.models
{
	
	/**
	* Simple object for holding event listener info, a unique ID is required in the constructor
	* @author Patrick Cousins    pj@pj-co.com
	*/
	public class EventListenerObject 
	{
		
		protected var 	_func 					: Function;
		protected var 	_type 					: String;
		protected var 	_id 					: uint;
		protected var 	_useCapt				: Boolean;
		protected var	_listenerReference 		: Object;
		
		
		
		function EventListenerObject ( id : uint )
		{
			this._id = id;
			
		}
		
		public function valueOf ( ) : uint
		{
			return _id;
		}
		
		
		//getters
		public function get func ( ) : Function 
		{ 
			return _func; 
		}				
		
		public function get type ( ) : String 
		{ 
			return _type; 
		}
		
		public function get listenerReference ( ) : Object 
		{ 
			return _listenerReference; 
		}
		
		public function get id ( ) : uint 
		{ 
			return _id; 
		}		
		
		public function get useCapt ( ) : Boolean 
		{ 
			return _useCapt; 
		}
		
		
		
		//setters
		public function set func ( value : Function ) : void 
		{
			_func = value;
		}
		
		public function set type ( value : String ) : void 
		{
			_type = value;
		}
		
		public function set useCapt ( value : Boolean ) : void 
		{
			_useCapt = value;
		}		
		
		public function set listenerReference ( value : Object ) : void 
		{
			_listenerReference = value;
		}
		
	
	}
	
}