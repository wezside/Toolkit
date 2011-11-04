package test.com.wezside.data.collection 
{
	import org.flexunit.asserts.assertTrue;
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestCollection 
	{
		
		private var collection:ICollection;
 
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
			collection.addElement({ id: "one", value: 10 });
			collection.addElement({ id: "three", value: 4 });			
			collection.addElement({ id: "two", value: 1 });			
			assertEquals( 3, collection.length );
			assertNotNull( collection.getElementAt( 0 ));
		}
						
		[Test]
		public function testRemove():void
		{	
			assertEquals( 0, collection.length );			
			collection.addElement( { id: "one", value: 10 });
			collection.addElement( { id: "three", value: 4 });			
			collection.addElement( { id: "two", value: 1 });			
			
			assertNotNull( collection.find( "id", "three" ));
			collection.removeElement( "id", "three" );					
			assertEquals( 2, collection.length );
			assertNull( collection.find( "id", "three" ));
		}
						
		[Test]
		public function testRemoveNativeObject():void
		{	
			assertEquals( 0, collection.length );			
			collection.addElement( "one" );
			collection.addElement( "two");			
			collection.addElement( "three" );			
			
			assertNotNull( collection.find( "one" ));
			collection.removeElement( "three" );					
			assertEquals( 2, collection.length );
			assertNull( collection.find( "three" ));
		}
		
		[Test]
		public function testAddElementAt():void
		{
			assertEquals( 0, collection.length );
			collection.addElement( "one" );
			collection.addElement( "three");			
			collection.addElement( "four" );			
			collection.addElementAt( "two", 1 );
			assertEquals( "one", collection.getElementAt( 0 ));
			assertEquals( "two", collection.getElementAt( 1 ));
			assertEquals( "three", collection.getElementAt( 2 ));
		}
		
		[Test]
		public function sortDescending():void
		{
			assertEquals( 0, collection.length );
			for ( var i:int = 0; i < 500; ++i ) 
			{
				collection.addElement( int( Math.random() * 1000 ));
				
			}
			collection.descending().sort();
			trace( collection );
			trace( "Sorting took: " + collection.elapsedSortTime() + "ms");
			assertTrue( collection.getElementAt( 0 ) > collection.getElementAt( collection.length - 1 ));
		}
		
		[Test]
		public function sortAscending():void
		{
			assertEquals( 0, collection.length );
			for ( var i:int = 0; i < 500; ++i ) 
			{
				collection.addElement( int( Math.random() * 1000 ));				
			}
			collection.sort();
			trace( collection );
			trace( "Sorting took: " + collection.elapsedSortTime() + "ms");
			assertTrue( collection.getElementAt( 0 ) < collection.getElementAt( collection.length - 1 ));
		}
		
		[Test]
		public function sortObjectsAscending():void
		{
			assertEquals( 0, collection.length );
			for ( var i:int = 0; i < 500; ++i ) 
			{
				collection.addElement({ index: int( Math.random() * 1000 ), value: "Value" });				
			}			

//			collection.sort().ascending().on( "index" );			
			collection.sortOn( "index" ).ascending().sort();
			trace( collection );
			trace( "Sorting took: " + collection.elapsedSortTime() + "ms");
			assertTrue( collection.getElementAt( 0 ).index < collection.getElementAt( collection.length - 1 ).index);
		}
		
		[Test]
		public function sortObjectsDescending():void
		{
			assertEquals( 0, collection.length );
			for ( var i:int = 0; i < 500; ++i ) 
			{
				collection.addElement({ test: int( Math.random() * 1000 ), value: "Value" });				
			}
			
			collection.sortOn( "test" ).descending().sort();
			trace( collection );
			trace( "Sorting took: " + collection.elapsedSortTime() + "ms");
			assertTrue( collection.getElementAt( 0 ).test > collection.getElementAt( collection.length - 1 ).test );
		}
	}
}
