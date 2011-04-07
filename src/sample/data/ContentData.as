package sample.data
{
	import com.wezside.data.IDeserializable;
	import com.wezside.data.collection.ICollection;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class ContentData implements IDeserializable
	{
		public var id:String;
		public var leaf:String;
		public var items:ICollection;
		
		public function item( id:String = "" ):ItemData
		{
			return items ? ItemData( items.find( "id", id )) : null;
		}			
		
	}
}
