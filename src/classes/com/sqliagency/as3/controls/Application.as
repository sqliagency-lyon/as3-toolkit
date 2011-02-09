package com.sqliagency.as3.controls 
{
	import com.sqliagency.as3.layout.ILayout;
	import com.sqliagency.as3.resources.ResourceManager;
	import com.sqliagency.as3.systems.SystemManager;
	
	import flash.errors.IllegalOperationError;
	import com.sqliagency.as3.core.ApplicationGlobals;
	import com.sqliagency.as3.core.IChildList;
	import com.sqliagency.as3.core.UIComponent;
	import com.sqliagency.as3.core.core_internal;
	
	use namespace core_internal;
	
	/**
	 * Application
	 * 
	 * Classe mère de l'application.
	 * Note : Il ne peut y avoir qu'une seule classe Application par application.
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class Application extends UIComponent
	{
		core_internal var rawChildren:IChildList;
		core_internal var popupChildren:IChildList;
		core_internal var tooltipChildren:IChildList;
		core_internal var cursorChildren:IChildList;
		
		/**
		 * Constructeur.
		 */
		public function Application() 
		{	
			super();
			
			if (Object(this).constructor === Application)
			{
				throw new IllegalOperationError("Application must not be directly instantiated.");
			}
		}
		
		/**
		 * @private
		 */
		core_internal override function preinitialize():void
		{
			super.core_internal::preinitialize();
			
			if (ApplicationGlobals.topLevelApplication != null)
			{
				throw new IllegalOperationError("Application must be unique.");
			}
			else
			{
				ApplicationGlobals.topLevelApplication = this;
			}
			
			resourceManager = ResourceManager.getInstance();
			systemManager = new SystemManager(this);
		}
	}
}