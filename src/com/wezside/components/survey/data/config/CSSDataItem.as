package com.wezside.components.survey.data.config 
{
	import com.wezside.data.IDeserializable;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class CSSDataItem implements IDeserializable 
	{
		public var id:String;		
		public var cssID:String;		
		
		public function toString():String
		{
			return id;
		}
	}
}
