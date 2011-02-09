package com.sqliagency.as3.core
{
	/**
	 * IEquals
	 * @author Nicolas CHENG (sqiagency)
	 */
	public interface IEquals extends IComparable
	{
		function equals(value:IComparable):Boolean;
	}
}