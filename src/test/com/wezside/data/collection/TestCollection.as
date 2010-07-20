package test.com.wezside.data.collection 
{
	import com.wezside.data.collection.Collection;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestCollection 
	{
		
		private var collection:Collection;

		[Before]
		public function setUp():void
		{
			collection = new Collection();					
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
			assertEquals( 0, collection.length );			
			collection.addElement( { id: "one", value: 10 });
			collection.addElement( { id: "three", value: 4 });			
			collection.addElement( { id: "two", value: 1 });			
			assertEquals( 3, collection.length );
			assertNotNull( collection.getElementAt(0));
		}
						
		[Test]
		public function testRemove():void
		{	
			assertEquals( 0, collection.length );			
			collection.addElement( { id: "one", value: 10 });
			collection.addElement( { id: "three", value: 4 });			
			collection.addElement( { id: "two", value: 1 });			
			
			assertNotNull( collection.find( "three" ));
			collection.removeElement( "three" );						
			assertEquals( 2, collection.length );
			assertNull( collection.find( "three" ));
		}
	}
}
