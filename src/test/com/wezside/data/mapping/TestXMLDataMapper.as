package test.com.wezside.data.mapping 
{
	import sample.data.ContentData;
	import sample.data.Data;
	import sample.data.ItemData;

	import test.com.wezside.data.Nested;
	import test.com.wezside.data.Node;

	import com.wezside.data.mapping.XMLDataMapper;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestXMLDataMapper 
	{
		private var xml:XML;
		private var mapper:XMLDataMapper;
		
		[Embed( source="/../resource/xml/data.xml", mimeType="application/octet-stream")]
		public static var XMLData:Class;
		private var data:*;
		private var str:*;

		[Before]
		public function setUp():void
		{
			mapper = new XMLDataMapper();
			data = new XMLData();
			str = data.readUTFBytes( data.length );
			xml = new XML( str );			
		}
				
		[After]
		public function tearDown():void
		{
			xml = null;
		}		
		
		[Test]
		public function testDataMapper():void
		{						
			mapper.addDataMap( Data );
			mapper.addDataMap( ContentData, "content", "content" );
			mapper.addDataMap( ItemData, "item", "items" );
			mapper.debug = false;
			mapper.deserialize( xml );
						
			assertNotNull( Data( mapper.data ).content );
			assertNotNull( Data( mapper.data ).content.find());
			assertEquals( 3, Data( mapper.data ).content.iterator().length() );
			assertEquals( "show all", ContentData( Data( mapper.data ).content.find( "id", "filter" )).item( "all" ).text );
		}
		
		[Test]
		public function testDataMapperWithNamespace():void
		{					
			mapper.addDataMap( Data );
			mapper.addDataMap( ContentData, "content", "content" );
			mapper.addDataMap( ItemData, "item", "items" );
			mapper.debug = false;
			mapper.deserialize( xml );
			
			assertNotNull( Data( mapper.data ).content );
			assertNotNull( Data( mapper.data ).content.find());
			assertEquals( 3, Data( mapper.data ).content.iterator().length() );
			assertEquals( "show all", ContentData( Data( mapper.data ).content.find( "id", "filter" )).item( "all" ).text );
		}
		
		[Test]
		public function testDataMapperNamespaceCollection():void
		{
			mapper.addDataMap( Data );
			mapper.addDataMap( ContentData, "content", "content" );
			mapper.addDataMap( ItemData, "item", "items" );
			mapper.debug = false;
			mapper.deserialize( xml );
			
			assertNotNull( Data( mapper.data ));
			assertEquals( "com.wezside.sample", mapper.namespaces.getElement( "article" ).uri );						
		}
		
		[Test]
		public function testAutoLeafNodeMapping():void
		{
			mapper.addDataMap( Data );
			mapper.addDataMap( ContentData, "content", "content" );
			mapper.addDataMap( ItemData, "item", "items" );
			mapper.debug = false;
			mapper.deserialize( xml );		

			assertNotNull( Data( mapper.data ));
			assertEquals( "This is a single leaf node.", ContentData( Data( mapper.data ).content.find( "id", "entries" )).leaf );						
		}
	}
}
