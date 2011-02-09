package com.sqliagency.as3.loaders 
{
	/**
	 * LoadableFileFactory
	 * Implémentation de base de AbstractLoadableFileFactory.
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class LoadableFileFactory extends AbstractLoadableFileFactory 
	{
		/**
		 * @inheritDoc
		 */
		override protected function factoryCreate(url:String, 
												  dataType:String, 
												  useCache:Boolean):ILoadableFile
		{
			var file:LoadableFile = new LoadableFile();
			file.url = url;
			file.dataType = dataType;
			file.useCache = useCache;
			
			return file;
		}
	}
}