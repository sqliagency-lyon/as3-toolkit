package com.sqliagency.as3.fonts
{
	import com.sqliagency.as3.collections.DictionaryMap;
	import com.sqliagency.as3.collections.IMap;
	
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.FontType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	/**
	 * FontsManager
	 * 
	 * @author		Cedric Tabin - thecaptain
	 * @version		1.0
	 * @modified	Nicolas CHENG (sqliagency)
	 */
	public class FontsManager 
	{
		//---------//
		//Constants//
		//---------//
		
		/**
		 * Defines a font as an embedded font.
		 * 
		 * @see		#isFontAvailable	isFontAvailable()
		 */
		public static const FONT_EMBEDDED:String = "embeddedFont";
		
		/**
		 * Defines a font as a device font.
		 * 
		 * @see		#isFontAvailable	isFontAvailable()
		 */
		public static const DEVICE_FONT:String = "deviceFont";
		
		/**
		 * Defines a font that is not available.
		 * 
		 * @see		#isFontAvailable	isFontAvailable()
		 */
		public static const FONT_NOT_AVAILABLE:String = "fontNotAvailable";
		
		//---------//
		//Variables//
		//---------//
		private static var linkages:IMap = new DictionaryMap(false);
		
		//--------------//
		//Public methods//
		//--------------//
		
		/**
		 * Register a class as a <code>Font</code>.
		 */
		public static function register(classPath:String, linkageName:String):Boolean
		{
			//check if the font is registered
			if (isRegistered(linkageName))
				return false;
			
			//register the font
			var fontClass:Class = getDefinitionByName(classPath) as Class;
			Font.registerFont(fontClass);
			
			//retrieves the instance
			var enumerateFonts:Array = Font.enumerateFonts(false);
			var font:Font = null;
			
			for (var i:int = 0; i < enumerateFonts.length; i++)
			{
				font = enumerateFonts[i];
				
				if (font is fontClass)
				{
					break;
				}
				else
				{
					font = null;
				}
			}
			
			//this case should never be produced...
			if (font == null) 
				return false;
			
			//set the linkage & map
			linkages.put(linkageName, font);
			
			//trace(font.fontName);
			
			return true;
		}
		
		/**
		 * Defines if the specified linkage name is already linked.
		 * 
		 * @param	linkageName		The linkage name.
		 * @return	<code>true</code> if the linkage is already linked.
		 */
		public static function isRegistered(linkageName:String):Boolean
		{
			return linkages.containsKey(linkageName);
		}
		
		/**
		 * Retrieves the <code>AbstractFont</code> registered under the
		 * specified <code>linkageName</code>.
		 */
		public static function getFont(linkageName:String):Font
		{
			return linkages.getValue(linkageName) as Font;
		}
		
		/**
		 * Retrieves the linkage names available.
		 */
		public static function enumerateLinkages():Array
		{
			return linkages.keys();
		}
		
		/**
		 * Retrieves the type of a font.
		 * 
		 * @param	fontName	The name of the font.
		 * @return	The type of the font issued from the constants.
		 * @see		#FONT_EMBEDDED	FONT_EMBEDDED
		 * @see		#DEVICE_FONT	DEVICE_FONT
		 * @see		#FONT_NOT_AVAILABLE	FONT_NOT_AVAILABLE
		 */
		public static function isFontAvailable(fontName:String):String
		{
			//check only the embedded fonts first
			var a:Array = Font.enumerateFonts(false);
			for each(var k:Font in a)
			{
				if (k.fontName == fontName)
				{
					return FONT_EMBEDDED;
				}
			}
			
			//check all the fonts (so the device fonts)
			var d:Array = Font.enumerateFonts(true);
			for each(var z:Font in d)
			{
				if (z.fontName == fontName)
				{
					return DEVICE_FONT;
				}
			}
			
			//the specified font is not available
			return FONT_NOT_AVAILABLE;
		}
		
		/**
		 * Retrieves a copy of the <code>TextFormat</code> used by this <code>AbstractFont</code>.
		 * <p>Be aware that the <code>tabStops</code> Array is copied by reference which means that if you
		 * modify it, the modifications will be also translated to the <code>textFormat</code> property.</p>
		 * 
		 * @return	A copy of the <code>textFormat</code> property.
		 */
		public static function copyTextFormat(textFormat:TextFormat):TextFormat
		{
			var copy:TextFormat = new TextFormat();
			copy.align = textFormat.align;
			copy.blockIndent = textFormat.blockIndent;
			copy.bold = textFormat.bold;
			copy.bullet = textFormat.bullet;
			copy.color = textFormat.color;
			copy.display = textFormat.display;
			copy.font = textFormat.font;
			copy.indent = textFormat.indent;
			copy.italic = textFormat.italic;
			copy.kerning = textFormat.kerning;
			copy.leading = textFormat.leading;
			copy.leftMargin = textFormat.leftMargin;
			copy.letterSpacing = textFormat.letterSpacing;
			copy.rightMargin = textFormat.rightMargin;
			copy.size = textFormat.size;
			copy.tabStops = textFormat.tabStops;  /* !!! Reference copy !!! */
			copy.target = textFormat.target;
			copy.underline = textFormat.underline;
			copy.url = textFormat.url;
			
			return copy;
		}
		
		/**
		 * Applique une font sur un TextField.
		 * @param textfield
		 * @param linkageName
		 */
		public static function applyFont(textfield:TextField, linkageName:String, size:int=12, color:uint=0x000000, defaultFormat:Boolean=false):void
		{
			var font:Font = getFont(linkageName);
			
			if (!font)
				return;
			
			var tf:TextFormat = new TextFormat();
			tf.bold = (font.fontStyle.indexOf(FontStyle.BOLD) > -1) ? true : false;
			tf.italic = (font.fontStyle.indexOf(FontStyle.ITALIC) > -1) ? true : false;
			tf.font = font.fontName;
			tf.color = color;
			tf.size = size;
			textfield.embedFonts = true;
			
			textfield.setTextFormat(tf);
			
			if (defaultFormat)
				textfield.defaultTextFormat = tf;
		}
	}
}