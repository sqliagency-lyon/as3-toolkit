package com.sqliagency.as3.collections
{
	/**
	 * IListIterator
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IListIterator extends IIterator
	{
		/**
		 * Inserts the specified element into the list.
		 */
		function add(e:*):void;
		
		/**
		 * Returns true if this list iterator has more elements when traversing the list in the reverse direction.
		 */
		function hasPrevious():Boolean;
			
		/**
		 * Returns the index of the element that would be returned by a subsequent call to next.
		 */
		function nextIndex():int;
			
		/**
		 * Returns the previous element in the list.
		 */
		function previous():*;
		
		/**
		 * Returns the index of the element that would be returned by a subsequent call to previous.
		 */
		function previousIndex():int;
		
		/**
		 * Replaces the last element returned by next or previous with the specified element.
		 */
		function set(e:*):void; 
	}
}