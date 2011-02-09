package com.sqliagency.as3.utils 
{
	/**
	 * DateUtil
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class DateUtil 
	{		
		public static function getDay(date:Date, startDayOfWeek:Number = 0):Number
		{
			var d:Number = date.day - startDayOfWeek;
			
			if (d < 0)
				d = 7 + d;
			
			return d;
		}
		
		public static function firstDateOfWeek(date:Date, startDayOfWeek:Number = 0):Date
		{
			var newDate:Date = clone(date);
			newDate.setDate(newDate.date - getDay(date, startDayOfWeek));
			
			return newDate;
		}
		
		public static function lastDateOfWeek(date:Date, startDayOfWeek:Number = 0):Date
		{
			var newDate:Date = firstDateOfWeek(date, startDayOfWeek);
			newDate.setDate(newDate.date + 6);
			
			return newDate;
		}
		
		public static function firstDateOfMonth(date:Date):Date
		{
			var newDate:Date = clone(date);
			newDate.setDate(1);
			
			return newDate;
		}
		
		public static function lastDateOfMonth(date:Date):Date
		{
			var newDate:Date = clone(date);
			newDate.setMonth(newDate.month + 1, 1);
			newDate.setDate(newDate.date - 1);
			
			return newDate;
		}
		
		public static function addDays(date:Date, days:Number):Date
		{
			var newDate:Date = clone(date);
			newDate.setDate(newDate.date + days);
			
			return newDate;
		}
		
		public static function addWeeks(date:Date, weeks:Number):Date
		{	
			return addDays(date, weeks*7);
		}
		
		public static function addMonths(date:Date, months:Number):Date
		{	
			var tempDate:Date = clone(date);
			tempDate.setMonth(tempDate.month + months);
			return tempDate;
		}
		
		/**
		 * Nombre de jours dans le mois (timeScale = "month") ou dans l'année (timeScale = "year")
		 * @param date
		 * @param timeScale
		 * @return nombre de jours
		 */
		public static function numberOfDays(date:Date, timeScale:String="month"):int
		{
			var nb:int = 0;
			
			if (timeScale == "month")
			{
				var tempDate:Date = new Date(date.fullYear, date.month, 1);
				tempDate.setMonth(tempDate.month+1);
				tempDate.setDate(tempDate.date-1);
				nb = tempDate.date;
			}
			else if (timeScale == "year")
			{
				var beginDate:Date = new Date(date.fullYear, 0, 1);
				var endDate:Date = new Date(date.fullYear, 11, 31);
				
				nb = (endDate.time-beginDate.time)/(3600*24*1000);
			}
			
			return nb;
		}
		
		public static function clone(date:Date):Date
		{
			return (date) ? new Date(date) : null;
		}
	}
}