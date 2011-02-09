package 
{
	import com.sqliagency.as3.logging.ILogger;
	import com.sqliagency.as3.logging.Log;
	import com.sqliagency.as3.logging.LogEventLevel;
	import com.sqliagency.as3.logging.targets.MonsterTarget;
	import com.sqliagency.as3.logging.targets.TraceTarget;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import templates.FastTemplate;
	
	/**
	 * LogDemo
	 * @author Nicolas CHENG (sqliagency)
	 * @created 01/06/2009
	 * @modified 23/04/2010
	 * 
	 */
	[SWF(frameRate="30",width="800",height="600",backgroundColor="#ffffff")]
	public class LogDemo extends FastTemplate
	{	
		private var logger:ILogger;
		
		override protected function init():void
		{
			/*
			var logTarget:TraceTarget = new TraceTarget();
			logTarget.filters=["*"];
			logTarget.level = LogEventLevel.ALL;
			logTarget.includeDate = true;
			logTarget.includeTime = true;
			logTarget.includeCategory = true;
			logTarget.includeLevel = true;
			logTarget.includeMethodName = true;
			*/
			
			var logTarget:MonsterTarget = new MonsterTarget();
			logTarget.filters=["*"];
			logTarget.level = LogEventLevel.ALL;
			logTarget.includeDate = false;
			logTarget.includeTime = false;
			logTarget.includeCategory = true;
			logTarget.includeLevel = true;
			logTarget.includeMethodName = true;
			
			Log.addTarget(logTarget);
			
			logger = Log.getLogger(this);
			logger.debug("");
		}
	}
}