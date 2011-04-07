package sample.data
{
	import com.wezside.data.IDeserializable;
	import com.wezside.data.collection.ICollection;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class Data implements IDeserializable
	{

		public var content:ICollection;
		
		public function contentData( id:String ):ContentData
		{
			return content ? ContentData( content.find( "id",id )) : null;
		}
	}
}
