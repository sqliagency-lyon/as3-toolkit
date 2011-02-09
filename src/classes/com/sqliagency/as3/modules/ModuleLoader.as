package com.sqliagency.as3.modules
{
	import com.sqliagency.as3.core.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ModuleLoader
	 * 
	 * Note : 
	 * Un module peut-être créé plusieurs fois une fois son chargement terminé.
	 * L'appel à la méthode unload() de IModuleInfo détruit toutes les instances du module.
	 * Le module doit implémenter IDisplayObjectModule.
	 * 
	 * Exemple :
	 * 
	   	package
		{
			import com.sqliagency.as3.core.Application;
			import com.sqliagency.as3.modules.ModuleLoader;
			import com.sqliagency.as3.modules.ModuleManager;
			import com.sqliagency.as3.utils.Timer;
			
			import flash.events.TimerEvent;
			import flash.utils.getTimer;
			
			[SWF(width="1200", height="600", frameRate="30", backgroundColor="#888888")]
			public class Main extends Application
			{
				private var timer:Timer;
				
				override protected function initialize():void
				{
					var module:ModuleLoader;
					
					for (var i:int = 0; i < 10; i++)
					{
						module = new ModuleLoader("MonModule.swf");
						module.x = Math.random()  * (stage.stageWidth-100);
						module.y = Math.random()  * (stage.stageHeight-100);
						addChild(module);
					}
					
					timer = new Timer(1000,10);
					timer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerHandler, false, 0, true);
					timer.start();
				}
				
				private function timerHandler(event:TimerEvent):void
				{
					if (event.type == TimerEvent.TIMER)
					{
						trace(timer.currentCount);
					}
					else if (event.type == TimerEvent.TIMER_COMPLETE)
					{
						trace("Modules supprimés");
						ModuleManager.unload("MonModule.swf");
					}
				}
			}
		}
	 * 
	 * Dans l'exemple ci-dessus 10 instances du module sont créés et au bout de 10 secondes,
	 * toutes les instances sont supprimés puisqu'on 'unload' le module chargé.
	 * Par contre, les 'container' du module existe toujours.
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ModuleLoader extends UIComponent
	{
		private var child:DisplayObject;
		private var info:IModuleInfo;
		private var _url:String;
		
		/**
		 * Constructeur.
		 */
		public function ModuleLoader(url:String="")
		{
			this.url = url;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function initialize():void
		{
			load();
		}
		
		/**
		 * Url du module.
		 */
		public function get url():String
		{
			return _url;
		}
		
		/**
		 * @private
		 */
		public function set url(value:String):void
		{	
			_url = value;
			
			if (url == null || url == "")
			{
				remove();
				return;
			}
			
			if (initialized)
				load();
		}
		
		/**
		 * Instance du module chargé/ajouté.
		 */
		public function getChild():DisplayObject
		{
			return (child) ? child as DisplayObject : null;
		}
		
		/**
		 * @private
		 */
		private function load():void
		{
			if (info)
			{
				info.removeEventListener(Event.COMPLETE, completeHandler, false);
				info.removeEventListener(Event.UNLOAD, unloadHandler, false);
				info = null;
				remove();
			}
			
			info = ModuleManager.getModuleInfo(url);
			
			if (info)
			{
				if (info.ready)
				{
					add();
				}
				else
				{
					info.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
					info.load();
				}
			}
		}
		
		/**
		 * @private
		 */
		private function add():void
		{
			// on crée une instance du module une fois le module chargé (ready)
			child = info.create() as DisplayObject;
			addChild(child);
		}
		
		/**
		 * @private
		 */
		private function remove():void
		{
			if (!child)
				return;
			
			removeChild(child as DisplayObject);
			child = null;
		}
		
		/**
		 * @private
		 */
		private function completeHandler(event:Event):void
		{
			info.removeEventListener(Event.COMPLETE, completeHandler, false);
			info.addEventListener(Event.UNLOAD, unloadHandler, false, 0, true);
			add();
		}
		
		/**
		 * @private
		 */
		private function unloadHandler(event:Event):void
		{
			info.removeEventListener(Event.UNLOAD, unloadHandler, false);
			remove();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			remove();
			
			if (info)
			{
				info.removeEventListener(Event.COMPLETE, completeHandler, false);
				info.removeEventListener(Event.UNLOAD, unloadHandler, false);
				info = null;
			}
		}
	}
}