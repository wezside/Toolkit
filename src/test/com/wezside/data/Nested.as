package test.com.wezside.data 
{
	import com.wezside.data.IDeserializable;
	import com.wezside.data.collection.ICollection;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Nested implements IDeserializable 
	{
		public var singleLeafNode:String;
		public var nodes:ICollection;
	}
}
