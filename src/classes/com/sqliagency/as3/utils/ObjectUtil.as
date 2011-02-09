package com.sqliagency.as3.utils
{
	import com.sqliagency.as3.collections.IMap;
	import com.sqliagency.as3.reflect.Access;
	import com.sqliagency.as3.reflect.Accessor;
	import com.sqliagency.as3.reflect.ClassInfo;
	import com.sqliagency.as3.reflect.Variable;
	
	import flash.utils.ByteArray;
	import flash.utils.describeType;

	/**
	 * Permet de faire comme la méthode formatToString dans la classe Event.
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ObjectUtil
	{
		/**
		 * Clone un objet quelque soit son type.
		 * @param objet
		 * @return objet cloné.
		 */
		public static function clone(object:Object):* 
		{
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(object);
			byteArray.position = 0;
			return byteArray.readObject();
		}
		
		/**
		 * Merge un objet A avec un objet B.
		 * @param objectA
		 * @param objectB
		 * @return booleen si le merge a effectué des changements sur l'objet A.
		 */
		public static function merge(objectA:Object, objectB:Object):Boolean
		{
			var bool:Boolean = (objectA != null && objectB != null);
			
			if (bool)
			{
				for (var prop:String in objectB)
				{
					if (objectA[prop] != undefined)
					{
						objectA[prop] = objectB[prop];
						bool = true;
					}
				}
			}
			
			return bool;
		}

		/**
		 * formatToString
		 * @param object
		 * @param properties
		 * @return 
		 */
		public static function formatToString(object:Object, ...args):String
		{
			return toString(object, args);
		}
		
		/**
		 * toString
		 * @param object
		 * @return
		 */
		public static function toString(object:Object, filter:Array=null):String
		{
			var name:String = ClassUtil.getQualifiedClassName(object, false);
			var info:ClassInfo;
			var props:Array;
			
			if (filter == null) filter = [];
			
			if (name == "Object")
			{
				props = getObjProps(object, filter)
			}
			else
			{
				info = ClassInfo.forInstance(name, object);
				props = getClassProps(info, object, filter);
			}
			
			name = name.substr(name.lastIndexOf(":") + 1);
			
			return "[object " + name + formatProps(props) + "]";
		}

		/**
		 * @private
		 */
		private static function getClassProps(info:ClassInfo, object:Object, filter:Array):Array
		{
			var props:Array=[];
			var name:String;
			var value:*;
			var type:String;

			var vars:Array = info.accessors.values().concat(info.variables.values());
			vars.sortOn("name");
			vars.filter(isAccessible);
			
			var v:Variable;
			
			for (var i:int = 0; i < vars.length; i++)
			{
				v = vars[i];
				name = v.name;
				value = object[name];
				type = v.type;
				
				if (filter.length == 0 || (filter.length > 0 && filter.indexOf(name) > -1))
				{
					props.push(name + "=" + formatValue(value, type));
				}
			}
			
			return props;
		}
		
		/**
		 * Filtre les variables et accessors qui sont en lecture et/ou lecture/écriture
		 */
		private static function isAccessible(element:*, index:int, arr:Array):Boolean 
		{
			var acc:Accessor = element as Accessor;
			
			if (acc && acc.access != Access.READ && acc.access != Access.READ_WRITE) 
				return false;
			else
				return true;
		}

		/**
		 * @private
		 */
		private static function getObjProps(object:Object, filter:Array):Array
		{
			var props:Array=[];
			var name:String;
			var value:*;
			var type:String;

			for (name in object)
			{
				value=object[name];
				type=getType(value);
				
				if (filter.length == 0 || (filter.length > 0 && filter.indexOf(name) > -1))
				{
					props.push(name + "=" + formatValue(value, type));
				}
			}

			return props;
		}

		/**
		 * @private
		 */
		private static function getType(value:*):String
		{
			var type:String=typeof value;

			switch (type)
			{
				case "object":
					var array:Array=value as Array;

					if (array)
					{
						type="array";
					}
					break;
			}

			return type;
		}

		/**
		 * @private
		 */
		private static function formatProps(value:Array):String
		{
			var length:int=value.length;
			var str:String="";

			if (length > 0)
			{
				str=" (";
				for each (var val:* in value)
				{
					str+=val + ", ";
				}
				str=str.replace(/, $/, "") + ")";
			}

			return str;
		}

		/**
		 * @private
		 */
		private static function formatValue(value:*, type:String):String
		{
			switch (type.toLowerCase())
			{
				case "int":
				case "number":
					break;

				case "object":
					value=(value != null) ? value : "[object NULL]";
					break;

				case "string":
					value=(value != null) ? "\"" + value + "\"" : "NULL";
					break;

				case "array":
					value="[array(" + ((value != null) ? value.length : "NULL") + ")]";
					break;

				case "xml":
					value="[xml(" + ((value != null) ? value.children().length() : "NULL") + ")]";
					break;

				case "undefined":
					value="[object UNDEFINED]";
					break;
			}

			return value;
		}
	}
}