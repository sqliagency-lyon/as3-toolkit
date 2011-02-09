package com.sqliagency.as3.tables {
	
	import flash.events.IEventDispatcher;
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 */
	
	public interface ITableModel extends IEventDispatcher {
		
		function getColumnClass (columnIndex:int):Class;							// Returns the most specific superclass for all the cell values in the column.
		function getColumnCount ():int;												// Returns the number of columns in the model.
		function getColumnName (columnIndex:int):String;							// Returns the name of the column at columnIndex.
		function getRowCount ():int;          										// Returns the number of rows in the model.
		function getValueAt (rowIndex:int, columnIndex:int):Object;					// Returns the value for the cell at columnIndex and rowIndex.
		function isCellEditable (rowIndex:int, columnIndex:int):Boolean; 			// Returns true if the cell at rowIndex and columnIndex is editable.
		function setValueAt (aValue:Object, rowIndex:int, columnIndex:int):void; 	// Sets the value in the cell at columnIndex and rowIndex to aValue.
	}
}