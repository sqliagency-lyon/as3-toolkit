package com.sqliagency.as3.reflect
{
	import com.sqliagency.as3.collections.ArrayList;
	import com.sqliagency.as3.collections.DictionaryMap;
	import com.sqliagency.as3.collections.IList;
	import com.sqliagency.as3.collections.IMap;
	import com.sqliagency.as3.utils.StringUtil;
	
	import flash.utils.describeType;

	/**
	 * ClassInfo
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ClassInfo implements IMetadataAware
	{
		private static var cache:IMap = new DictionaryMap();
		
		/**
		 * 
		 * @default 
		 */
		public var name:String;
		/**
		 * 
		 * @default 
		 */
		public var base:String;
		/**
		 * 
		 * @default 
		 */
		public var isDynamic:Boolean;
		/**
		 * 
		 * @default 
		 */
		public var isFinal:Boolean;
		/**
		 * 
		 * @default 
		 */
		public var isStatic:Boolean;
		
		/**
		 * 
		 * @default 
		 */
		public var extendsClass:IList;
		/**
		 * 
		 * @default 
		 */
		public var implementsInterface:IList;
		
		/**
		 * 
		 * @default 
		 */
		public var constructor:Constructor;
		/**
		 * 
		 * @default 
		 */
		public var methods:IMap;
		/**
		 * 
		 * @default 
		 */
		public var accessors:IMap;
		/**
		 * 
		 * @default 
		 */
		public var variables:IMap;
		/**
		 * 
		 * @default 
		 */
		public var metadatas:IList;
		
		/**
		 * Constructeur.
		 */
		public function ClassInfo()
		{
			extendsClass = new ArrayList();
			implementsInterface = new ArrayList();
			
			constructor = new Constructor();
			
			methods = new DictionaryMap();
			accessors = new DictionaryMap();
			variables = new DictionaryMap();
			
			metadatas = new ArrayList();
		}
		
		/**
		 * Récupère un objet ClassInfo
		 * @param className
		 * @param instance
		 * @return
		 */
		public static function forInstance(className:String, instance:Object):ClassInfo
		{	
			var info:ClassInfo;
			
			if (cache.containsKey(className))
			{
				info = cache.getValue(className) as ClassInfo;
			}
			else
			{
				info = createClassInfo(className, instance);
				cache.put(className, info);
			}
			
			return info;
		}
		
		/**
		 * @private
		 */
		private static function createClassInfo(className:String, instance:Object):ClassInfo
		{
			var info:ClassInfo = new ClassInfo();
			
			var xml:XML = describeType(instance);
			
			var infoAttributes:XMLList = xml.attributes();
			var infoChidren:XMLList = xml.children();
			var localName:String;
			
			for each (var infoAttr:XML in infoAttributes)
			{
				localName = infoAttr.localName().toString();
				
				if (localName == "name")
					info.name = infoAttr.toString();
				else if (localName == "base")
					info.base = infoAttr.toString();
				else if (localName == "isDynamic")
					info.isDynamic = StringUtil.toBoolean(infoAttr.toString());
				else if (localName == "isFinal")
					info.isFinal = StringUtil.toBoolean(infoAttr.toString());
				else if (localName == "isStatic")
					info.isStatic = StringUtil.toBoolean(infoAttr.toString());
			}
			
			var accessor:Accessor;
			var method:Method;
			var variable:Variable;
			var parameter:Parameter;
			var paramChildren:XMLList;
			var paramChild:XML;
			var metadata:Metadata;
			var metadataChild:XML;
			var metadataArgChildren:XMLList;
			var metadataArgChild:XML;
			var length:int;
			
			for each (var infoChild:XML in infoChidren)
			{
				localName = infoChild.localName().toString();
				
				if (localName == "metadata")
				{
					metadata = new Metadata();
					metadata.name = infoChild.@name.toString();
					metadata.assignedTo = info;
					info.metadatas.add(metadata);
					
					metadataArgChildren = infoChild.children();
					
					for each (metadataArgChild in metadataArgChildren)
					{
						metadata.args.put(metadataArgChild.@key.toString(), metadataArgChild.@value.toString());
					}
				}
				else if (localName == "extendsClass")
					info.extendsClass.add(infoChild.@type.toString());
				else if (localName == "implementsInterface")
					info.implementsInterface.add(infoChild.@type.toString());
				else if (localName == "accessor")
				{
					accessor = new Accessor();
					accessor.name = infoChild.@name.toString();
					accessor.access = infoChild.@access.toString();
					accessor.type = infoChild.@type.toString();
					accessor.declaredBy = infoChild.@declaredBy.toString();
					info.accessors.put(accessor.name, accessor);
					
					length = infoChild.elements("metadata").length();
					
					if (length > 0)
					{
						for each (metadataChild in infoChild.metadata)
						{
							metadata = new Metadata();
							metadata.name = metadataChild.@name.toString();
							metadata.assignedTo = accessor;
							info.metadatas.add(metadata);
							
							metadataArgChildren = metadataChild.children();
							
							for each (metadataArgChild in metadataArgChildren)
							{
								metadata.args.put(metadataArgChild.@key.toString(), metadataArgChild.@value.toString());
							}
						}
					}
				}
				else if (localName == "variable")
				{
					variable = new Variable();
					variable.name = infoChild.@name.toString();
					variable.type = infoChild.@type.toString();
					info.variables.put(variable.name, variable);
					
					length = infoChild.elements("metadata").length();
					
					if (length > 0)
					{
						for each (metadataChild in infoChild.metadata)
						{
							metadata = new Metadata();
							metadata.name = metadataChild.@name.toString();
							metadata.assignedTo = variable;
							info.metadatas.add(metadata);
							
							metadataArgChildren = metadataChild.children();
							
							for each (metadataArgChild in metadataArgChildren)
							{
								metadata.args.put(metadataArgChild.@key.toString(), metadataArgChild.@value.toString());
							}
						}
					}
				}
				else if (localName == "method")
				{
					method = new Method();
					method.name = infoChild.@name.toString();
					method.declaredBy = infoChild.@declaredBy.toString();
					method.returnType = infoChild.@returnType.toString();
					
					info.methods.put(method.name, method);
					
					paramChildren = infoChild.children();
					
					for each (paramChild in paramChildren)
					{
						localName = paramChild.localName().toString();
						
						if (localName == "parameter")
						{
							parameter = new Parameter();
							parameter.index = int(paramChild.@index.toString());
							parameter.type = paramChild.@type.toString();
							parameter.optional = StringUtil.toBoolean(paramChild.@optional.toString());
							method.parameters.add(parameter);
						}
					}
				}
				else if (localName == "constructor")
				{
					paramChildren = infoChild.children();
					
					for each (paramChild in paramChildren)
					{
						localName = paramChild.localName().toString();
						
						if (localName == "parameter")
						{
							parameter = new Parameter();
							parameter.index = int(paramChild.@index.toString());
							parameter.type = paramChild.@type.toString();
							parameter.optional = StringUtil.toBoolean(paramChild.@optional.toString());
							info.constructor.parameters.add(parameter);
						}
					}
				}
			}
			
			return info;
		}
	}
}