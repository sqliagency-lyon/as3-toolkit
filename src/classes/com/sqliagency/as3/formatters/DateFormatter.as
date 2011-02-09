package com.sqliagency.as3.formatters 
{
	
	/**
	 * Classe pour formatter une date en une chaine de caractères.
	 * 
	 * <p>Voir le manuel PHP pour les différents formats.</p>
	 * 
	 * <p>Exemple :
	 * var formatter:DateFormatter = new DateFormatter("Y-m-d h:i:s A");
	 * var date:Date = new Date();
	 * 
	 * formatter.format(date);			// donne 2009-03-21 12:06:09 PM
	 * </p>
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class DateFormatter
	{
		private var _mask:String = "";
		
		public function DateFormatter(mask:String="Y-m-d") 
		{
			this.mask = mask;
		}
		
		public function get mask():String
		{
			return _mask;
		}
		
		public function set mask(value:String):void
		{
			_mask = value;
		}
		
		public function format(date:Date):String
		{
			if (!mask)
				return date.toString();
			
			var str:String = "";
			var c:String;
			
			for (var i:int = 0; i < mask.length; i++)
			{
				c = mask.charAt(i);
				
				switch (c)
				{
					/*		jour			*/	
					case "d":	str += NumberFormatter.addLeadingZero(date.date); break;
					case "j":	str += date.date; break;
					case "w":	str += date.day; break;
					case "z":	str += z(date); break;
					
					/*		semaine	*/
					case "W":	str += W(date); break;
					
					/*		mois			*/
					case "m":	str += NumberFormatter.addLeadingZero(date.month + 1); break;
					case "n":	str += (date.month + 1); break;
					case "t":	str += t(date); break;
					
					/*		année		*/
					case "L":	str += (t(new Date(date.fullYear, 1, 1)) == 29) ? 1 : 0; break;
					case "Y": 	str += date.fullYear; break;
					case "y":	str += date.fullYear.toString().replace(/^[0-9]{2}/, ""); break;
					
					/*		heure		*/
					case "a":	str += a(date); break;
					case "A":	str += a(date).toUpperCase(); break;
					case "g":	str += g(date); break;
					case "G":	str += date.hours; break;
					case "h":	str += NumberFormatter.addLeadingZero(g(date)); break;
					case "H":	str += NumberFormatter.addLeadingZero(date.hours); break;
					case "i":	str += NumberFormatter.addLeadingZero(date.minutes); break;
					case "s":	str += NumberFormatter.addLeadingZero(date.seconds); break;
					
					default:		str += c;
				}
			}
			
			return str;
		}
		
		private function g(date:Date):Number
		{
			var h:Number = date.hours;
			h = (h >= 12) ? h - 12 : h;
			h = (h == 0) ? 12 : h;
			
			return h;
		}
		
		private function a(date:Date):String
		{
			return (date.hours <= 11) ? "am" : "pm";
		}
		
		private function t(date:Date):Number
		{
			var tempDate:Date = new Date(date);
			tempDate.setMonth(tempDate.month + 1, 1);
			tempDate.setDate(tempDate.date - 1);
			
			return tempDate.date;
		}
		
		private function z(date:Date):Number
		{
			var tempDate:Date = new Date(date);
			tempDate.setMonth(0, 1);
			
			return (date.time - tempDate.time)/(3600*1000*24);
		}
		
		private function W(date:Date):Number
		{
			var tempDate:Date = new Date(date);
			var d:Number = (tempDate.day == 0) ? 0 : 7 - tempDate.day;
			tempDate.setDate(date.date + d); 
			
			return Math.ceil(z(tempDate) / 7);
		}
	}
}