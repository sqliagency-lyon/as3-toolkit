package com.sqliagency.as3.events
{
	import flash.events.Event;
	
	/**
	 * CollectionEvent
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 * created 20/10/2009
	 * 
	 */
	public class CollectionEvent extends Event
	{
		public static const COLLECTION_CHANGE:String = "collectionChange";
		
		public var kind:String;
		public var location:int;
		public var items:Array;
		
		/**
		 * Constructeur
		 * 
		 * @param type Type de l'événement
		 * @param kind Type de changement réalisé (update, add, delete, ...)
		 * @param location Index de l'item qui a changé
		 * @param items Les items qui ont changé
		 * 
		 */
		public function CollectionEvent(type:String, kind:String = null, location:int = -1, items:Array = null)
		{
			super(type, false, false);
			
			this.kind = kind;
			this.location = location;
			this.items = items ? items : [];
		}

		/**
		 *  @private
		 */
		override public function clone():Event
		{
			return new CollectionEvent(type, kind, location, items);
		}
		
		/**
		 *  @private
		 */
		override public function toString():String
		{
			return formatToString("CollectionEvent", "kind", "location", "type", "bubbles", "cancelable", "eventPhase");
		}
	}	
}