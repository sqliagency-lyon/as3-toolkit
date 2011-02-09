package templates
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * FastTemplate
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class FastTemplate extends Sprite
	{
		/**
		 * Constructeur.
		 */
		public function FastTemplate()
		{
			var monster:MonsterDebugger = new MonsterDebugger(this);
			
			if (!stage)
			{
				addEventListener(Event.ADDED_TO_STAGE, _init, false, 0, true);
			}
			else
			{
				init();
			}
		}
		
		/**
		 * @private
		 */
		private function _init(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _init, false);
			init();
		}
		
		/**
		 * Initialise le composant.
		 */
		protected function init():void
		{
			// à remplacer
		}
	}
}