package sample.data
{
	import com.wezside.data.IDeserializable;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class ItemData implements IDeserializable
	{
		
		public var id:String;		
		public var text:String;	
		public var date:Date;	
		public var href:String;		
		public var type:String;		
		public var width:Number;	
		public var height:Number;
		public var handle:String;
		public var uri:String;
	}
}
