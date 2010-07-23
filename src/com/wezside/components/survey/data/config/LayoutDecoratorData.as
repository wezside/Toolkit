package com.wezside.components.survey.data.config 
{
	import com.wezside.data.IDeserializable;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class LayoutDecoratorData implements IDeserializable 
	{
		public var id:String;
		public var top:int;
		public var left:int;
		public var bottom:int;
		public var right:int;
		public var horizontalGap:int;
		public var verticalGap:int;
	}
}
