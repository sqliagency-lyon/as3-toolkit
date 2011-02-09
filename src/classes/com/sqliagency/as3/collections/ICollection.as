package com.sqliagency.as3.collections
{
	/**
	 * ICollection
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface ICollection extends IIterable
	{
		function add(e:*):Boolean;
		function addAll(c:ICollection):Boolean;
		function clear():void;
		function contains(e:*):Boolean;
		function containsAll(c:ICollection):Boolean;
		function isEmpty():Boolean;
		function remove(e:*):Boolean;
		function removeAll(c:ICollection):Boolean;
		function retainAll(c:ICollection):Boolean;
		function size():int;
		function toArray():Array;
	}
}