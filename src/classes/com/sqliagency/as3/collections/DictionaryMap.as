package com.sqliagency.as3.collections
{
	import flash.utils.Dictionary;

	/**
	 * DictionaryMap
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class DictionaryMap implements IMap
	{
		private var _count:int = 0;
		private var _dictionary:Dictionary;
		
		public function DictionaryMap(weakKeys:Boolean=false)
		{
			_dictionary = new Dictionary(weakKeys);
		}
		
		public function clear():void
		{
			for (var i:String in _dictionary)
			{
				delete _dictionary[i];
			}
			
			_count = 0;
		}
		
		public function containsKey(key:*):Boolean
		{
			return (key in _dictionary);
		}
		
		public function containsValue(value:*):Boolean
		{
			for each(var k:* in _dictionary)
			{
				if (k === value) return true;
			}
			
			return false;
		}
		
		public function getValue(key:*):*
		{
			return _dictionary[key];
		}
		
		public function isEmpty():Boolean
		{
			return (_count == 0);
		}
		
		public function put(key:*, value:*):*
		{
			if (key == null) 
				throw new ArgumentError("The key is not defined (value="+value+")");
			
			var old:* = _dictionary[key];
			_dictionary[key] = value;
			
			if (old == null) _count++;
			
			return old;
		}
		
		public function putAll(source:IMap):void
		{
			var keys:Array = source.keys();
			for each(var currentKey:* in keys)
			{
				var currentValue:* = source.getValue(currentKey);
				put(currentKey, currentValue);  
			}
		}
		
		public function remove(key:*):*
		{
			var old:* = _dictionary[key];
			
			delete _dictionary[key];
			_count--;
			
			return old;
		}
		
		public function size():int
		{
			return _count;
		}
		
		public function values():Array
		{
			var list:Array = new Array();
			for each(var value:* in _dictionary)
			{
				list.push(value);
			}
			
			return list;
		}
		
		public function keys():Array
		{
			var list:Array = new Array();
			for (var i:* in _dictionary)
			{
				list.push(i);
			}
			return list;
		}
	}
}