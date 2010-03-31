package com.wezside.components.media.data 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	[Bindable]
	public class Item implements IDeserializable
	{
		
		public var id:String;
		
		public var text:String;
	
		public var url:String;
		
		public var livedate:Date;
	
		public var href:String;
		
		public var type:String;
		
		public var width:Number;
		
		public var height:Number;

		
	}
}
