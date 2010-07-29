package test.com.wezside.data.mapping 
{
	import org.flexunit.asserts.assertNotNull;
	import com.wezside.components.survey.data.SurveyData;
	import com.wezside.components.survey.data.config.LayoutData;
	import com.wezside.components.survey.data.config.LayoutDecoratorData;
	import com.wezside.components.survey.data.ui.UIData;
	import com.wezside.components.survey.data.ui.UIItemData;
	import com.wezside.data.mapping.XMLDataMapper;

	import org.flexunit.asserts.assertEquals;

	import flash.net.URLLoader;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestXMLDataMapper 
	{
		private var mapper:XMLDataMapper;
		private var loader:URLLoader;

		[Embed( source="/../bin/resources-en-MS/survey-config.xml", mimeType="application/octet-stream")]
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
			assertEquals( 1, SurveyData( mapper.data ).layout.iterator().length() );			
		}
		
		[Test][Ignore]
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
	}
}
