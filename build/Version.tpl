package com.sqliagency.as3 {
	/**
	 * //
	 * 
	 * @author AntTask
	 */
	final public class Version {

		public static const FULL_VERSION:String = "SqliAgency-Toolkit-@MAJOR@.@MINOR@.@BUILD@ ( build @TODAY@ )";
		public static const VERSION:String = "@MAJOR@.@MINOR@.@BUILD@";
		public static const VERSION_DATE:String = "@TODAY@";
		
		public function Version()
		{
			//System.out.println(FULL_VERSION);
    		//System.out.println(COPYRIGHT);
		}
	}
}