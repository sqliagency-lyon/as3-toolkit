package com.sqliagency.as3.collections
{	
	/**
	 * IList
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IList extends ICollection
	{
		function getListIterator(index:int=0):IListIterator;
		function addAt(e:*, index:int):void;
		function addAllAt(c:ICollection, index:int):Boolean;
		function getAt(index:int):*;
		function indexOf(o:Object):int;
		function lastIndexOf(o:Object):int;
		function removeAt(index:int):*;
		function setAt(e:*, index:int):*;
		function subList(fromIndex:int, toIndex:int):IList;
	}
}