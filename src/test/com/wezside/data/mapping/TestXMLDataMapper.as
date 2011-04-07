package test.com.wezside.data.mapping 
{
	import com.wezside.data.mapping.XMLDataMapper;

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
		
		/*
		 * TODO: Test should use other data objects. Not survey engine.
		[Test]
		public function testDataMapper():void
		{						
			mapper.addDataMap( SurveyData );
			mapper.addDataMap( LayoutData, "layout", "layout" );
			mapper.addDataMap( LayoutDecoratorData, "decorator", "decorators" );
			mapper.debug = false;
			mapper.deserialize( xml );
						
			assertEquals( 1, SurveyData( mapper.data ).layout.iterator().length());
			assertNotNull( SurveyData( mapper.data ).layout );
			assertNotNull( SurveyData( mapper.data ).layout.find());
			assertEquals( 2, LayoutData( SurveyData( mapper.data ).layout.find( ) ).decorators.length );
//			assertEquals( 0, LayoutDecoratorData(Collection(LayoutData(Collection(SurveyData( mapper.data ).layout).find()).decorators).getElementAt(0)).width );
//			assertEquals( 0, LayoutDecoratorData(Collection(LayoutData(Collection(SurveyData( mapper.data ).layout).find()).decorators).getElementAt(0)).height );
//			assertEquals( .6, LayoutDecoratorData(Collection(LayoutData(Collection(SurveyData( mapper.data ).layout).find()).decorators).getElementAt(0)).widthRatio);			
		}
		
		[Test]
		public function testDataMapperWithNamespace():void
		{					
			mapper.addDataMap( SurveyData );
			mapper.addDataMap( UIData, "component", "component" );
			mapper.addDataMap( UIItemData, "item", "items" );
			mapper.debug = false;
			mapper.deserialize( xml );
			
			assertNotNull( SurveyData( mapper.data ));
			assertNotNull( SurveyData( mapper.data ).component );			
			assertEquals( 1, SurveyData( mapper.data ).component.iterator().length() );
		}
		
		[Test]
		public function testDataMapperNamespaceCollection():void
		{
			mapper.addDataMap( SurveyData );
			mapper.addDataMap( UIData, "component", "component" );
			mapper.addDataMap( UIItemData, "item", "items" );
			mapper.debug = false;
			mapper.deserialize( xml );
			
			assertNotNull( SurveyData( mapper.data ));
			assertEquals( "com.wezside.components.survey.style", mapper.namespaces.getElement( "style" ).uri );						
		}
		
		[Test]
		public function testAutoLeafNodeMapping():void
		{
			mapper.addDataMap( SurveyData );
			mapper.addDataMap( Nested, "nested", "nested" );
			mapper.addDataMap( Node, "node", "nodes" );
			mapper.debug = false;
			mapper.deserialize( xml );			
			
			assertNotNull( SurveyData( mapper.data ));
			assertEquals( "Test leaf nodes level 1", SurveyData( mapper.data ).nested.getElementAt( 0 ).singleLeafNode );
			assertEquals( "Test leaf nodes level 2", SurveyData( mapper.data ).nested.getElementAt( 0 ).nodes.getElementAt( 0 ).singleLeafNode );
		}*/
	}
}
