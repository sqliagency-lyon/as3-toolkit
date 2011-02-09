package com.sqliagency.as3.core
{
	/**
	 * IComparator
	 * @author Nicolas CHENG (sqliagency)
	 */
	public interface IComparator
	{
		function compare(o1:IComparable, o2:IComparable):int;
	}
}