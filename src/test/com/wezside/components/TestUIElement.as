package test.com.wezside.components 
{
	import test.com.wezside.sample.styles.LatinStyle;

	import org.flexunit.asserts.assertEquals;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestUIElement 
	{

		private var mockUIElement:MockUIElement;
		private var styles:LatinStyle;

		[Before]
		public function setUp():void
		{
			styles = new LatinStyle();
			mockUIElement = new MockUIElement();
		}

		[After]
		public function tearDown():void
		{
			styles = null;
			mockUIElement = null;
		}		

		[Test] 
		public function testStyleManagerInitialize():void
		{			
			mockUIElement.styleName = "title";
			mockUIElement.styleManager = styles;
			assertEquals( "", "" );
			
			mockUIElement.setStyle();			
			assertEquals( "advanced", mockUIElement.antiAliasType );
		}
		
	}
}
