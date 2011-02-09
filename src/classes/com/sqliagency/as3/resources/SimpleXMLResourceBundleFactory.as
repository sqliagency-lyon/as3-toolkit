package com.sqliagency.as3.resources
{
	/**
	 * SimpleXMLResourceBundleFactory
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class SimpleXMLResourceBundleFactory extends AbstractResourceBundleFactory
	{
		override protected function factoryCreate(name:String, content:Object, locale:String):IResourceBundle
		{
			var xml:XML = content as XML;
			
			var resourceBundle:ResourceBundle = new ResourceBundle(name, locale);
			
			var n:String;		// nom de la resource
			var arrStr:Array;	// tableau de valeurs de la resource (voir getStringArray() de IResourceManager)
			var str:String;		// valeur de la resource
			
			for each (var xmlChild:XML in xml.children())
			{
				n = xmlChild.name().toString();
				str = xmlChild.toString();
				
				if (resourceBundle.content[n])
				{
					// il existe déjà une entrée donc transforme un texte en tableau au cas ou
					if (resourceBundle.content[n] is String)
					{
						arrStr = [];
						arrStr.push(resourceBundle.content[n]);
						resourceBundle.content[n] = arrStr;
					}
					else
					{
						// passage de string à tableau déjà effectué
						arrStr = resourceBundle.content[n];
					}
					
					// ajoute l'entrée comme tableau
					arrStr.push(str);
				}
				else
				{
					// ajoute l'entrée comme string
					resourceBundle.content[n] = str;
				}
			}
			
			return resourceBundle;
		}
	}
}