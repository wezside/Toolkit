package test.com.wezside.data.mapping 
{
	import test.com.wezside.data.Node;
	import test.com.wezside.data.Nested;
	import com.wezside.components.survey.data.SurveyData;
	import com.wezside.components.survey.data.config.LayoutData;
	import com.wezside.components.survey.data.config.LayoutDecoratorData;
	import com.wezside.components.survey.data.ui.UIData;
	import com.wezside.components.survey.data.ui.UIItemData;
	import com.wezside.data.mapping.XMLDataMapper;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;

	import flash.net.URLLoader;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestXMLDataMapper 
	{
		private var mapper:XMLDataMapper;
		private var loader:URLLoader;

		[Embed( source="/../resource/xml/survey-config.xml", mimeType="application/octet-stream")]
		public static var ConfigXMLData:Class;
		private var data:*;
		private var str:*;
		private var xml:XML;

		[Before]
		public function setUp():void
		{
			mapper = new XMLDataMapper();
			loader = new URLLoader();
			data = new ConfigXMLData();
			str = data.readUTFBytes( data.length );
			xml = new XML( str );			
		}
				
		[After]
		public function tearDown():void
		{
			mapper = null;
			loader = null;
			xml = null;
			str = null;
			data = null;
		}		
				
		[Test]
		public function testDataMapper():void
		{						
			mapper.addDataMap( SurveyData );
			mapper.addDataMap( LayoutData, "layout", "layout" );
			mapper.addDataMap( LayoutDecoratorData, "decorator", "decorators" );
			mapper.debug = true;
			mapper.deserialize( xml );
						
			assertEquals( 2, SurveyData( mapper.data ).layout.iterator().length());
			assertNotNull( SurveyData( mapper.data ).layout );
			assertNotNull( SurveyData( mapper.data ).layout.find());
			assertEquals( 4, LayoutData( SurveyData( mapper.data ).layout.find( ) ).decorators.length );
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
			mapper.debug = true;
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
			mapper.debug = true;
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
			mapper.debug = true;
			mapper.deserialize( xml );			
			
			assertNotNull( SurveyData( mapper.data ));
			assertEquals( "Test leaf nodes level 1", SurveyData( mapper.data ).nested.getElementAt( 0 ).singleLeafNode );
			assertEquals( "Test leaf nodes level 2", SurveyData( mapper.data ).nested.getElementAt( 0 ).nodes.getElementAt( 0 ).singleLeafNode );
		}
	}
}
