package com.sqliagency.as3.logging.errors {
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 * @ceated 01/06/2009
	 */
	public class InvalidCategoryError extends Error {
		
		public function InvalidCategoryError(message:String) {
			super(message);
		}
		
		public function toString():String {
			return String(message);
		}
	}
}