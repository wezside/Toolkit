package test.com.wezside.utilities.xml 
{
	import flexunit.framework.Assert;

	import com.wezside.utilities.xml.XMLDataMapper;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.async.Async;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestXMLDataMapper 
	{
		private var mapper:XMLDataMapper;
		private var loader:URLLoader;

		[Before]
		public function setUp():void
		{
			mapper = new XMLDataMapper();
			loader = new URLLoader();
		}
				
		[After]
		public function tearDown():void
		{
			mapper = null;
			loader = null;
		}		
				
		[Test(async)] 
		public function testDataMapper():void
		{			
			mapper.addDataMap( TestData  );
			mapper.addDataMap( TestModule, "module", "modules" );
			mapper.addDataMap( TestItem, "item", "items" );
			mapper.addDataMap( TestSwitch, "switch", "switches" );
			mapper.addDataMap( TestAssets, "assets", "assets" );
			
			loader.addEventListener( Event.COMPLETE, Async.asyncHandler( this, xmlLoaded, 3000, null, timeout ), false, 0, true );
			loader.load( new URLRequest( "bin-release/xml/en-GB.xml" ));			
		}
		
		protected function xmlLoaded( event:Event, object:Object ):void
		{
			var xml:XML = XML( event.target.data );
			mapper.deserialize( xml );

			assertNotNull( mapper.data );
			assertNotNull( TestData( mapper.data ).module );
			assertNotNull( TestData( mapper.data ).module("ExampleModule") );
			assertEquals( "My Label", TestData( mapper.data ).module("ExampleModule").item("navLabel" ).text );
		}
		
		protected function timeout( object:Object ):void
		{
	    	Assert.fail( "Pending Event Never Occurred" );
		}			
	}
}
