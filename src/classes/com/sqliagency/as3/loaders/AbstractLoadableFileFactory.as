package com.sqliagency.as3.loaders 
{
	import flash.errors.IllegalOperationError;
	
	/**
	 * AbstractLoadableFileFactory
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class AbstractLoadableFileFactory 
	{
		/**
		 * Constructeur.
		 */
		public function AbstractLoadableFileFactory() 
		{
			if (Object(this).constructor === AbstractLoadableFileFactory)
			{
				throw new IllegalOperationError("AbstractLoadableFileFactory must not be directly instantiated.");
			}
		}
		
		/**
		 * Crée une ressource externe à charger.
		 * @param url
		 * @param dataType
		 * @param useCache
		 * @return un objet téléchargeable
		 */
		public function create(url:String, dataType:String=null, useCache:Boolean=false):ILoadableFile
		{
			return factoryCreate(url, dataType, useCache);
		}
		
		/**
		 * @private
		 */
		protected function factoryCreate(url:String, dataType:String, useCache:Boolean):ILoadableFile
		{
			// ABSTRACT Method
			throw new IllegalOperationError("Abstract method: must be overridden in a subclass.");
			return null;
		}
	}
}