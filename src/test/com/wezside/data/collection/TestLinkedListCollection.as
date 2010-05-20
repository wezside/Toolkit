package test.com.wezside.data.collection 
{
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertEquals;
	import com.wezside.data.collection.LinkedListCollection;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestLinkedListCollection 
	{
		
		private var collection:LinkedListCollection;

		[Before]
		public function setUp():void
		{
			collection = new LinkedListCollection();					
		}
		
		[After]
		public function tearDown():void
		{
			collection.purge();
			collection = null;
		}
						
		[Test]
		public function testStruct():void
		{	
			assertEquals( 0, collection.length() );			
			collection.addElement( { id: "one", value: 10 });
			collection.addElement( { id: "three", value: 4 });			
			collection.addElement( { id: "two", value: 1 });			
			assertEquals( 3, collection.length() );
			
			assertNotNull( collection.find( "two" ));		
			assertEquals( "two", collection.find( "two" ).id );	
			assertEquals( "one", collection.find( "one" ).id );	
			assertEquals( 4, collection.find( "three" ).value );	
		}
	}
}
