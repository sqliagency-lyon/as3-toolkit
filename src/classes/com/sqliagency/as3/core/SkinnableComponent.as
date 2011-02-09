package com.sqliagency.as3.core
{
	import com.sqliagency.as3.collections.IIterator;
	import com.sqliagency.as3.collections.IList;
	import com.sqliagency.as3.collections.IMap;
	import com.sqliagency.as3.core.ISkinnable;
	import com.sqliagency.as3.core.UIComponent;
	import com.sqliagency.as3.reflect.ClassInfo;
	import com.sqliagency.as3.reflect.Metadata;
	import com.sqliagency.as3.reflect.Parameter;
	import com.sqliagency.as3.reflect.Variable;
	import com.sqliagency.as3.skins.ISkin;
	import com.sqliagency.as3.utils.ClassUtil;
	import com.sqliagency.as3.utils.StringUtil;
	
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	/**
	 * SkinnableComponent
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class SkinnableComponent extends UIComponent implements ISkinnable
	{
		private static var skinElementDescriptorsCache:Object;  // cache des descriptions des éléments graphiques
		private var propertiesChanging:Dictionary;				// propriétés à modifier
		private var _skinClass:Class;
		private var _skin:ISkin;
		private var _state:String;
		
		/**
		 * Constructeur.
		 */
		public function SkinnableComponent()
		{
			super();
			describeSkinElements();
			propertiesChanging = new Dictionary(true);
		}
		
		/**
		 * La Skin du composant.
		 */
		protected function get skin():ISkin
		{
			return _skin;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get skinClass():Class
		{
			return _skinClass;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set skinClass(value:Class):void
		{
			if (value === _skinClass)
				return;
			
			_skinClass = value;
			
			detachSkin();
			attachSkin();
		}
		
		/**
		 * @private
		 */
		private function describeSkinElements():void
		{
			// obtenir les différentes descriptions des éléments graphiques à skinner
			if (skinElementDescriptorsCache)
				return;
			
			var descriptor:SkinElementDescriptor;
			var metadataList:IList = ClassUtil.getClassInfo(this).metadatas;
			var cursor:IIterator = metadataList.getIterator();
			var metadata:Metadata;
			
			skinElementDescriptorsCache = {};
			
			while (cursor.hasNext())
			{
				metadata = cursor.next() as Metadata;
				if (metadata.name == "SkinElement")
				{
					if (metadata.assignedTo is Variable)
					{
						descriptor = new SkinElementDescriptor();
						
						var variable:Variable = metadata.assignedTo as Variable;
						descriptor.name = variable.name;
						
						descriptor.clazz = ApplicationDomain.currentDomain.getDefinition(variable.type) as Class;
						
						var args:IMap = metadata.args;
						
						descriptor.required = (args.containsKey("required")) ? StringUtil.toBoolean(args.getValue("required") as String) : false;
						
						skinElementDescriptorsCache[descriptor.name] = descriptor;
					}
				}
			}
		}
		
		/**
		 * @private
		 */
		private function linkSkinElements():void
		{
			// lier les différents éléments graphiques
			var descriptor:SkinElementDescriptor;
			
			for each (descriptor in skinElementDescriptorsCache)
			{
				var instance:*;
				var p:PropertyChange; 
				
				try
				{
					instance = this[descriptor.name] = skin.getSkinElement(descriptor.name) as descriptor.clazz;
					
					p = propertiesChanging[descriptor.name];
					
					if (p)
					{
						applyPropertyChanged(p);
					}
				}
				catch (err:Error)
				{
					if (descriptor.required)
					{
						throw new Error("La SkinElement '"+ descriptor.name +"' dans la "+ skinClass +" est manquante.");
					}
				}
				
				skinElementAdded(descriptor.name, instance);
			}
		}
		
		/**
		 * @private
		 */
		private function unlinkSkinElements():void
		{
			// délier les différents éléments graphiques
			var descriptor:SkinElementDescriptor;
			
			for each (descriptor in skinElementDescriptorsCache)
			{
				var instance:* = this[descriptor.name] = skin.getSkinElement(descriptor.name) as descriptor.clazz;
				skinElementRemoved(descriptor.name, instance);
			}
		}
		
		/**
		 * Ajout d'un élément graphique
		 * @param skinName
		 * @param instance
		 */
		protected function skinElementAdded(skinName:String, instance:Object):void
		{
			// à remplacer
		}
		
		/**
		 * Suppression d'un élément graphique
		 * @param skinName
		 * @param instance
		 */
		protected function skinElementRemoved(skinName:String, instance:Object):void
		{
			// à remplacer
		}
		
		/**
		 * @private
		 */
		private function detachSkin():void
		{
			// suppression de la skin
			if (skin)
			{
				unlinkSkinElements();
				removeChild(skin as DisplayObject);
				skin.dispose();
				_skin = null;
			}
		}
		
		/**
		 * @private
		 */
		private function attachSkin():void
		{
			// ajout de la skin
			_skin = new _skinClass() as ISkin;
			addChild(_skin as DisplayObject);
			//skin.target = this;
			linkSkinElements();
			invalidateDisplayList();
		}
		
		/**
		 * @private
		 */
		protected function changeProperty(destination:String, value:*):void
		{
			destination = (destination) ? destination.replace(/^this./,"") : "";
			
			var split:Array = destination.split(".");
			var skinName:String = (split && split.length > 0) ? split[0] : "";
			
			if (!(skinElementDescriptorsCache[skinName]))
			{
				return;
			}
			
			var p:PropertyChange = new PropertyChange();
			p.skinName = skinName;
			p.destination = destination;
			p.value = value;
			
			propertiesChanging[skinName] = p;
			applyPropertyChanged(p);
		}
		
		private function applyPropertyChanged(p:PropertyChange):void
		{
			if (!skin)
			{
				return;				
			}
			
			var split:Array = p.destination.split(".");
			var target:Object;
			var prop:String;
			var skinName:String;
			
			target = this;
			
			while (split.length > 1)
			{
				prop = split.shift();
				
				if (target)
					target = target[prop];
				else
					break;
			}
			
			if (!target)
			{
				delete propertiesChanging[p.skinName];
				return;
			}
			else
			{
				target[split[0]] = p.value;
				invalidateDisplayList();
			}
		}
		
		public function invalidateDisplayList():void
		{
			if (skin)
			{
				skin.state = state;
				skin.invalidateDisplayList();
			}
		}
		
		public function get state():String
		{
			return _state;
		}
		
		public function set state(value:String):void
		{
			_state = value;
			invalidateDisplayList();
		}
		
		override public function dispose():void
		{
			super.dispose();
			detachSkin();
			propertiesChanging = null;
			_skinClass = null;
		}
	}
}

internal class SkinElementDescriptor
{
	public var name:String;
	public var clazz:Class;
	public var required:Boolean;
}

internal class PropertyChange
{
	public var skinName:String;
	public var destination:String;
	public var value:*;
}