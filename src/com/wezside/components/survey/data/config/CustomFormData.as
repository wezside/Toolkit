package com.wezside.components.survey.data.config 
{
	import com.wezside.data.IDeserializable;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class CustomFormData implements IDeserializable 
	{
		public var id:String;		
		public var className:String;		
		
		public function toString():String
		{
			return id;
		}		
	}
}
