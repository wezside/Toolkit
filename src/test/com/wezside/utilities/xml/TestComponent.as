package test.com.wezside.utilities.xml 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestComponent implements IDeserializable
	{
		
		public var id:String;
		
		
		public var items:ICollection;
		
		
		public var share:ICollection;
		
		
		public var assets:ICollection;
		
				
		public function item( id:String ):TestItem
		{
			return TestItem( items.find( id ));
		}
					
		public function shareItem( id:String ):TestShare
		{
			return TestShare( share.find( id ));
		}	
					
		public function asset( id:String ):TestAssets
		{
			return TestAssets( assets.find( id ));
		}	
		
	}
}

