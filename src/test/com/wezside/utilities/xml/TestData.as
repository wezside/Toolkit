package test.com.wezside.utilities.xml 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestData implements IDeserializable
	{

		public var meta:ICollection;
		
		public var items:ICollection;
		
		public var modules:ICollection;
				
		public var prefixes:ICollection;
		
		public var switches:ICollection;
				
		public var components:ICollection;		
		
		public function item( id:String ):TestItem
		{
			return TestItem( items.find( id ));
		}
					
		public function metatag( id:String ):TestMeta
		{
			return TestMeta( meta.find( id ));
		}			
					
		public function module( id:String ):TestModule
		{
			return TestModule( modules.find( id ));
		}			
					
		public function prefixe( id:String ):TestPrefix
		{
			return TestPrefix( prefixes.find( id ));
		}			
					
		public function switchItem( id:String ):TestSwitch
		{
			return TestSwitch( switches.find( id ));
		}			
					
		public function component( id:String ):TestComponent
		{
			return TestComponent( components.find( id ));
		}			
	}
}
