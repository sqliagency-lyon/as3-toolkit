package com.sqliagency.as3.utils
{
	import com.sqliagency.as3.core.IDisposable;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	[Event(name="timer", type="flash.events.TimerEvent")]
	[Event(name="timerComplete", type="flash.events.TimerEvent")]
	
	/**
	 * Timer (precis à 10ms près pour 1000ms)
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class Timer extends EventDispatcher implements IDisposable
	{
		private var _timer:flash.utils.Timer;
		private var _startTime:int = 0;
		private var _delay:Number = 1000;
		private var _repeatCount:int = 0;
		private var _currentCount:int = 0;
		
		/**
		 * Construteur.
		 * @param delay
		 * @param repeatCount
		 */
		public function Timer(delay:Number=1000, repeatCount:int=0)
		{
			this.delay = delay;
			this.repeatCount = repeatCount;
		}
		
		public function get delay():Number
		{
			return _delay;
		}
		
		public function set delay(value:Number):void
		{
			if (value <= 0)
				return;
			
			value = Math.round(value);
			
			_delay = value;
			
			if (_timer)
				_timer.delay = delay/100;
		}
		
		public function get repeatCount():int
		{
			return _repeatCount;
		}
		
		public function set repeatCount(value:int):void
		{
			_repeatCount = Math.max(value, 0);
		}

		/**
		 * @private
		 */
		private function addTimer():void
		{
			_timer = new flash.utils.Timer(delay/100, 0);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer = null;
		}
		
		/**
		 * Start.
		 */
		public function start():void
		{
			if (!_timer)
			{
				addTimer();
			}
			
			_startTime = getTimer();
			_timer.start();
		}
		
		/**
		 * Stop.
		 */
		public function stop():void
		{	
			if (_timer)
				_timer.stop();	
		}
		
		/**
		 * Reset.
		 */
		public function reset():void
		{
			if (_timer)
				_timer.reset();
			
			_currentCount = 0;
		}
		
		/**
		 * Nombre de boucles.
		 */
		public function get currentCount():int
		{
			return _currentCount;
		}
		
		/**
		 * Timer en fonctionnement
		 */
		public function get running():Boolean
		{
			return (_timer) ? _timer.running : false;
		}
		
		/**
		 * @private
		 */
		private function onTimer(event:TimerEvent):void
		{
			var timer:int = getTimer();
			var duration:int = timer - _startTime;
			
			if (duration >= delay)
			{	
				_currentCount++;
				
				// infini ? 0 = oui
				if (repeatCount == 0)
				{
					dispatchEvent(new TimerEvent(TimerEvent.TIMER));	
				}
				else
				{
					dispatchEvent(new TimerEvent(TimerEvent.TIMER));
					
					if (currentCount == repeatCount)
					{
						stop();
						dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
					}
				}
				
				_startTime = timer - ((duration - delay));
			}
		}	
	}
} 