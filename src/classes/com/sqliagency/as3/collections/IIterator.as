package com.sqliagency.as3.collections
{
	/**
	 * IIterator
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IIterator
	{
		/**
		 * Returns true if the iteration has more elements.
		 */
		function hasNext():Boolean;
		
		/**
		 * Returns the next element in the iteration.
		 */
		function next():*;
		
		/**
		 * Removes from the underlying collection the last element returned by the iterator (optional operation).
		 */
		function remove():void;
	}
}