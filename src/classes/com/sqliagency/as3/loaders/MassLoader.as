package com.sqliagency.as3.loaders
{
	import com.sqliagency.as3.collections.ArrayList;
	import com.sqliagency.as3.collections.DictionaryMap;
	import com.sqliagency.as3.collections.IIterator;
	import com.sqliagency.as3.collections.IList;
	import com.sqliagency.as3.collections.IMap;
	import com.sqliagency.as3.core.IDisposable;
	
	import flash.events.EventDispatcher;
	import flash.system.LoaderContext;

	/**
	 * MassLoader
	 * TODO : A finir
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class MassLoader extends EventDispatcher implements IDisposable
	{
		private var factory:AbstractLoadableFileFactory;
		private var fileExtParser:IFileExtensionParser;
		
		protected var list:IList = new ArrayList();
		protected var map:IMap = new DictionaryMap();
		
		private var loader:ILoader;
		
		/**
		 * Constructeur.
		 * @param factory
		 */
		public function MassLoader(factory:AbstractLoadableFileFactory=null, 
								   fileExtParser:IFileExtensionParser=null)
		{
			this.factory 		= (!factory) 		? new LoadableFileFactory() : factory;
			this.fileExtParser 	= (!fileExtParser) 	? new FileExtensionParser() : fileExtParser;
		}
		
		/**
		 * Ajoute un fichier à la liste de chargement.
		 * @param url
		 * @return
		 */
		public function add(url:String, args:Object=null):ILoadableFile
		{
			var type:String = fileExtParser.getFileType(url);
			
			var file:ILoadableFile;
			
			if (map.containsKey(url))
			{
				file = list.getAt(map.getValue(url).index);
			}
			else
			{
				file = factory.create(url, type, true);
				list.add(file);
				args.index = list.size()-1;
				map.put(url, args);
			}
			
			return file;
		}
		
		/**
		 * Enlève un fichier à la liste de chargement.
		 * @param url
		 * @return
		 */
		public function remove(url:String):Boolean
		{
			var bool:Boolean;
			var file:ILoadableFile;
			
			bool = map.containsKey(url);
			
			if (bool)
			{
				list.removeAt(list.getAt(map.getValue(url)).index);
				map.remove(url);
			}
			
			return bool;
		}
		
		/**
		 * Lance le téléchargement de tous les fichiers
		 */
		public function start():void
		{
			var itr:IIterator = list.getIterator();
			var file:ILoadableFile;
			
			while (itr.hasNext())
			{
				file = itr.next();
				itr.remove();
			}
		}
		
		/**
		 * Stop le téléchargement de tous les fichiers
		 */
		public function stop():void
		{
			
		}
		
		/**
		 * Efface la liste de téléchargement
		 */
		public function clear():void
		{
			list.clear();
			map.clear();
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			clear();
			list = null;
			map = null;
			factory = null;
			fileExtParser = null;
		}
	}
}

import com.sqliagency.as3.loaders.IFileExtensionParser;
import com.sqliagency.as3.loaders.LoadableFileType;

internal class FileExtensionParser implements IFileExtensionParser
{
	public function getFileExtension(name:String):String
	{
		return name.substr(name.lastIndexOf(".")+1).toLowerCase();
	}
	
	public function getFileType(name:String):String
	{
		var ext:String = getFileExtension(name);
		var type:String;
		
		switch(ext)
		{
			case "swf":
				type = LoadableFileType.SWF;
				break;
			
			case "jpg":
			case "jpeg":
			case "png":
			case "gif":
				type = LoadableFileType.IMG;
				break;
			
			case "txt":
				type = LoadableFileType.TEXT;
			
			case "xml":
				type = LoadableFileType.XML;
				break;
			
			default:
				type = LoadableFileType.BINARY;
				break;
		}
		
		return type;
	}
}