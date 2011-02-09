package com.sqliagency.as3.events
{
	import flash.events.Event;
	
	/**
	 * Classe de base pour les classes Event.
	 * Le type d'événement de la BaseEvent peut être changé dynamiquement. 
	 * Il n'est donc pas nécessaire d'instancier un nouvel objet Event.
	 * 
	 * Attention : Dans tout projet il est important de redéfinir la méthode clone() car cette dernière est utilisée dans la méthode dispatchEvent().
	 * 
	 * @created 30/01/2010
	 * 
	 */
	public class BaseEvent extends Event
	{
		private var _type:String;
		private var _data:Object;
		
		/**
		 * Constructeur.
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function BaseEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_type = type;
			_data = data;
		}
		
		/**
		 * (read-write) The type of event.
		 */ 
		public override function get type():String
		{
			return _type ;
		}
		
		/**
		 * (read-write) The type of event.
		 */ 
		public function set type(name:String):void
		{
			_type = name ;
		}
		
		/**
		 * Accesseur sur la propriété 'data'.
		 */
		public function get data():Object
		{
			return _data;
		}
		
		/**
		 * Modifieur sur la propriété 'data'.
		 */
		public function set data(value:Object):void
		{
			_data = value;
		}
		
		/**
		 * Returns a shallow copy of the object.
		 * @return a shallow copy of the object.
		 */
		override public function clone():Event
		{
			var event:BaseEvent = new BaseEvent(type, data, bubbles, cancelable);
			return event;
		}
	}
}