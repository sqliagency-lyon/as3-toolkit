package com.sqliagency.as3.net
{	
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	
	/**
	 * Cookie
	 * @author Nicolas CHENG (sqliagency)
	 */
	public dynamic class Cookie
	{	
		private var _name:String;
		private var _localPath:String;
		private var _secure:Boolean;
		private var _minDiskSpace:int;
		
		private var _lso:SharedObject;
		
		public function Cookie (name:String, minDiskSpace:int=0, localPath:String="/", secure:Boolean=false)
		{
			_name = name;
			_localPath = localPath;
			_secure = secure;
			_minDiskSpace = minDiskSpace;
			
			//trace (name, minDiskSpace, localPath, secure);
			
			getLocal();
		}
		
		private function getLocal():void
		{
			try
			{
				_lso = SharedObject.getLocal(_name, _localPath, _secure);
			}
			catch (er:Error)
			{		
				throw new Error ("Flash Player cannot create the shared object for whatever reason.");
			}
		}
		
		public function flush():void 
		{
			try
			{
				var flushResult:String = _lso.flush(_minDiskSpace);
				
				switch(flushResult)
				{
					case SharedObjectFlushStatus.FLUSHED:
						// The cookie is successfully saved
						break;
					case SharedObjectFlushStatus.PENDING:
						// Need more disk space
						//_lso.addEventListener(NetStatusEvent.NET_STATUS, statusHandler, false, 0, true);
						//Security.showSettings(SecurityPanel.LOCAL_STORAGE);
						break;
				}
			}
			catch(err:Error)
			{
				throw new Error ("User has the local storage settings to 'Never'.");
			}
		}
		
		private function statusHandler(event:NetStatusEvent):void
		{
			_lso.removeEventListener(NetStatusEvent.NET_STATUS, statusHandler);
			
			switch (event.info.code) {
				case "SharedObject.Flush.Success":
					flush();
					break;
				
				case "SharedObject.Flush.Failed":
					// The user denied access
					break;
			}
		}
		
		/**
		 * Ensemble des attributs affectés à la propriété data de l'objet.
		 * 
		 * <p>Ces attributs peuvent être partagés et stockés.
		 * Chaque attribut peut être un objet d'un quelconque type ActionScript ou JavaScript : tableau, nombre, valeur booléenne, ByteArray, XML, etc.</p>
		 */
		public function get data():Object
		{
			return _lso.data;
		}
		
		/**
		 * Cette méthode purge toutes les données et supprime l’objet du disque.
		 * La référence à l’objet partagé reste active, mais ses propriétés data sont effacées.
		 */
		public function clear():void
		{
			_lso.clear();
		}
	}
}