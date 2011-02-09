package com.sqliagency.as3.tables {
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Classe STUB
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class TableModelAdapter implements ITableModel {
		
		private var dispatcher:EventDispatcher;
		
		public function TableModelAdapter ()
		{
			if (getQualifiedClassName(this) == "com.bd.inter.semainier.tables.TableModelAdapter::TableModelAdapter") {
				
				throw new IllegalOperationError("TableModelAdapter is an ABSTRACT Class (should be subclassed and not instantiated)");
			}
			
			dispatcher = new EventDispatcher(this);
		}
        
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority);
		}
           
		public function dispatchEvent (event:Event):Boolean
		{
			return dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener (type:String):Boolean
		{
			return dispatcher.hasEventListener(type);
		}
		
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
					   
		public function willTrigger (type:String):Boolean
		{
			return dispatcher.willTrigger(type);
		}
		
		public function getColumnClass (columnIndex:int):Class { return Class; }
		public function getColumnCount ():int { return 0; }			
		public function getColumnName (columnIndex:int):String { return ""; }		
		public function getRowCount ():int { return 0; }
		public function getValueAt (rowIndex:int, columnIndex:int):Object { return new Object(); }
		public function isCellEditable (rowIndex:int, columnIndex:int):Boolean { return false; }
		public function setValueAt (aValue:Object, rowIndex:int, columnIndex:int):void {}
	}
}