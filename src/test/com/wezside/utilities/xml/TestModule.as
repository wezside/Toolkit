package test.com.wezside.utilities.xml 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestModule implements IDeserializable 
	{
		
		public var id:String;
		public var assets:ICollection;
		public var items:ICollection;
	
		public function item( id:String ):TestItem
		{
			return TestItem( items.find( id ));
		}
					
		public function asset( id:String ):TestAssets
		{
			return TestAssets( assets.find( id ));
		}			
	
	}
}
