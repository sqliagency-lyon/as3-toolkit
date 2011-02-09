package com.sqliagency.as3.reflect
{
	/**
	 * Accessor
	 * 
	 * <accessor name="soundTransform" access="readwrite" type="flash.media::SoundTransform" declaredBy="flash.display::Sprite"/>
	 * 
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class Accessor extends Variable implements IMetadataAware
	{
		//public var name:String;
		public var access:String;
		//public var type:String;
		public var declaredBy:String;
	}
}