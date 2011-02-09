package com.sqliagency.as3.modules
{
	import com.sqliagency.as3.loaders.ILoader;
	import com.sqliagency.as3.loaders.Loader;
	import com.sqliagency.as3.utils.ClassNameUtil;
	
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	/**
	 * ModuleLoaderMediator
	 * 
	 * exemple : 
	 *
	 	private var info:IModuleInfo;

		public function loadModule()
		{	
			info = ModuleManager.getModuleInfo("SWFACharger.swf");
			info.addEventListener(Event.COMPLETE, moduleReady, false, 0, true);
			info.load();
		}
		
		private function moduleReady(event:Event):void
		{
			info.removeEventListener(Event.COMPLETE, moduleReady);
			addChild(info.create() as DisplayObject);
		}
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ModuleManager
	{
		private static var moduleMap:Dictionary;	// dictionary
		
		private static var loader:ILoader;
 		private static var lastUrl:String;
		
		private static var initialized:Boolean = ModuleManager.initialize();

		/**
		 * Constructeur.
		 */
		public function ModuleManager()
		{
			throw new IllegalOperationError("ModuleManager must not be instantiated.");
		}
		
		private static function initialize():Boolean
		{
			moduleMap = new Dictionary(true);
			
			loader = new Loader();
			loader.addEventListener(Event.COMPLETE, completeHandler, false);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler, false);
			lastUrl = null;
			
			return true;
		}
		
		/**
		 * Obtient les informations sur un module.
		 * @param id
		 * @return informations
		 */
		public static function getModuleInfo(url:String):IModuleInfo
		{
			if (!url || url == "")
				return null;
			
			var info:ModuleInfo = (moduleMap[url]) ? moduleMap[url] : new ModuleInfo();
			info.moduleUrl = url;
			
			moduleMap[url] = info;
			
			return info;
		}
		
		/**
		 * Charge un module.
		 * @param url
		 * @return info du module
		 */
		public static function load(url:String):IModuleInfo
		{
			var info:IModuleInfo = getModuleInfo(url);
			
			if (!info)
				return null;
			
			if (info.ready)
			{
				// le module est déjà chargé
				info.dispatchEvent(new Event(Event.COMPLETE));
			}
			else
			{
				// chargement en cours ?
				if (lastUrl != info.url)
				{
					// n'est pas en train d'être chargé
					lastUrl = url;
					close();
					
					// chargement dans l'ApplicationDomain courant
					var context:LoaderContext = new LoaderContext();
					context.applicationDomain = ApplicationDomain.currentDomain;	
					
					loader.load(lastUrl, context);
				}
			}
			
			return info;
		}
		
		/////////////////////// EVENT HANDLERS ///////////////////////
		
		private static function completeHandler(event:Event):void
		{
			// update info
			var info:ModuleInfo = getModuleInfo(lastUrl) as ModuleInfo;
			
			var clazzName:String = ClassNameUtil.getQualifiedClassName(loader.data);
			info.moduleClass = (loader as Loader).info.applicationDomain.getDefinition(clazzName) as Class;
			info.dispatchEvent(new Event(Event.COMPLETE));

			lastUrl = null;
		}
		
		private static function errorHandler(event:Event):void
		{
			var info:ModuleInfo = getModuleInfo(lastUrl) as ModuleInfo;
			info.dispatchEvent(event);
			lastUrl = null;
		}
		
		/**
		 * Arrête le téléchargement en cours.
		 */
		public static function close():void
		{
			loader.close();
		}
		
		/**
		 * Enleve le module (chargé ou non) de la liste.
		 * @param url
		 * @return boolean
		 */
		public static function unload(url:String):void
		{
			var info:ModuleInfo = getModuleInfo(url) as ModuleInfo;
			
			if (!info)
				return;
			
			// stop le chargement en cours ?
			if (lastUrl == url)
			{
				close();
				lastUrl = null;
			}
			
			delete moduleMap[url];
			
			info.dispatchEvent(new Event(Event.UNLOAD));
		}
	}
}

import com.sqliagency.as3.loaders.ILoader;
import com.sqliagency.as3.modules.IModuleInfo;
import com.sqliagency.as3.modules.ModuleManager;

import flash.events.EventDispatcher;

internal class ModuleInfo extends EventDispatcher implements IModuleInfo
{	
	internal var moduleUrl:String;
	internal var moduleClass:Class;
	
	public function get url():String
	{
		return moduleUrl;
	}
	
	public function get ready():Boolean
	{
		return (moduleClass) ? true : false;
	}
	
	public function create():Object
	{
		return (ready) ? new moduleClass() : null;
	}
	
	public function load():void
	{
		ModuleManager.load(url);
	}
	
	public function close():void
	{
		ModuleManager.close();
	}
	
	public function unload():void
	{
		ModuleManager.unload(url);
	}
}