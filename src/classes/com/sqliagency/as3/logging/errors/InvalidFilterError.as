package com.sqliagency.as3.logging.errors {
	
	/**
	 * @author Nicolas CHENG (sqliagency)
	 * @ceated 01/06/2009
	 */
	public class InvalidFilterError extends Error {
		
		public function InvalidFilterError(message:String) {
			super(message);
		}
		
		public function toString():String {
			return String(message);
		}
	}
}