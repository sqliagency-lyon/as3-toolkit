package com.sqliagency.as3.utils
{
	import flash.display.* ;
	import flash.events.*;
	import flash.net.*;
	import flash.text.* ;
	
	public class FormUtils extends MovieClip
	{
		private var elForm:MovieClip;
		
		// constructeur
		public function FormUtils(elTmp:MovieClip, loading:Boolean=false)
		{
			elForm = elTmp;
		}
		
		// vérification des champs
		public function simpleChp (chp: TextField):Boolean
		{
			var tmp:Boolean = false;
			formatChp(true, chp);
			if (chp.text != "") tmp = true;
			else formatChp(false, chp);
			return tmp;
		}
		
		// fonction classique de vérification de l'email
		public function verifMail (chp:TextField):Boolean 
		{ 
			var email:String = chp.text;
			if (email.indexOf("@") > 0) { 
				if ((email.indexOf("@") + 2))
				{
					if (email.lastIndexOf(".") & (email.length - 2)) {
						formatChp(true, chp);
						return (true); 
					} 
				} 
			} 
			formatChp(false, chp);
			return (false); 
		}
		
		public function verifNum (chp:TextField):Boolean
		{
			var tmp:Boolean = true;
			formatChp(true, chp);
			if (chp.text == "") {
				formatChp(false, chp);
				tmp = false;
			} else {
				if (isNaN( Number(chp.text))) {
					tmp = false;
					formatChp(false, chp);
				}
			}
			
			return tmp;
		}
		
		public function checkboxSelect(chp:*):Boolean
		{
			var el:Boolean = chp.selected;
			var myFormat:TextFormat = new TextFormat();
			if (!el) myFormat.color = 0xFF0000;
			else myFormat.color = 0x000066;
			chp.setStyle("textFormat", myFormat);

			return el;
		}
		
		// affichage des erreurs
		public function formatChp (etat:Boolean, chp:TextField):void
		{
			if (etat) chp.borderColor = uint("0x000066");
			else chp.borderColor = uint("0xff0000"); 
		}
	}
}