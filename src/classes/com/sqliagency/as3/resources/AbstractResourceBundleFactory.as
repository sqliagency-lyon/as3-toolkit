package com.sqliagency.as3.resources
{
	import flash.errors.IllegalOperationError;

	public class AbstractResourceBundleFactory
	{
		/**
		 * Constructeur.
		 */
		public function AbstractResourceBundleFactory() 
		{
			if (Object(this).constructor === AbstractResourceBundleFactory)
			{
				throw new IllegalOperationError("AbstractResourceBundleFactory must not be directly instantiated.");
			}
		}
		
		/**
		 * Crée un ResourceBundle
		 * @param name
		 * @param content
		 * @param locale
		 * @return
		 */
		public function create(name:String, content:Object, locale:String):IResourceBundle
		{
			return factoryCreate(name, content, locale);
		}
		
		/**
		 * @private
		 */
		protected function factoryCreate(name:String, content:Object, locale:String):IResourceBundle
		{
			// ABSTRACT Method
			throw new IllegalOperationError("Abstract method: must be overridden in a subclass.");
			return null;
		}
	}
}