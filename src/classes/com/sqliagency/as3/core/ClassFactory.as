package com.sqliagency.as3.core 
{
	/**
	 * ClassFactory
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ClassFactory 
	{
		private var generator:Class;
		private var properties:Object;
		
		/**
		 * Constructeur.
		 * @param generator
		 * @param properties
		 */
		public function ClassFactory(generator:Class, properties:Object=null)
		{
			this.generator = generator;
			this.properties = properties;
		}
		
		/**
		 * Crée une nouvelle instance de la classe.
		 * @return 
		 */
		public function newInstance():*
		{
			var instance:Object = new generator();

			if (properties != null)
			{
				for (var p:String in properties)
				{
					if (instance[p])
					{
						instance[p] = properties[p];
					}
				}
			}

			return instance;
		}
	}
}