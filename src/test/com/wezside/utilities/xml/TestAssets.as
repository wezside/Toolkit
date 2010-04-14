package test.com.wezside.utilities.xml 
{
	import com.wezside.utilities.iterator.ICollection;
	import com.wezside.utilities.iterator.IDeserializable;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestAssets implements IDeserializable 
	{
		public var id:String;

		public var items:ICollection;
		
		public function item( id:String ):TestItem
		{
			return TestItem( items.find( id ));
		}
		
		public static const SWF:String = "swf";
		public static const IMG:String = "image";
		public static const VIDEO:String = "video";
	}
}
