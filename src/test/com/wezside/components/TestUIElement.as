package test.com.wezside.components 
{
	import flexunit.framework.Assert;

	import test.com.wezside.sample.styles.LatinStyle;

	import com.wezside.components.UIElementSkin;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.async.Async;

	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestUIElement 
	{


		private var styles:LatinStyle;
		private var mockUIElement:MockUIElement;


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
		public function testUIElementStates():void
		{
			mockUIElement.state = UIElementSkin.STATE_VISUAL_UP;
			mockUIElement.state = UIElementSkin.STATE_VISUAL_SELECTED;
			assertEquals( mockUIElement.state, UIElementSkin.STATE_VISUAL_SELECTED+UIElementSkin.STATE_VISUAL_UP );
		}

		[Test(async)] 
		public function testStyleManagerNoChildren():void
		{			
			styles.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReady, 5000, null, timeout ), false, 0, true );
		}
		
		private function styleReady( event:Event, object:Object ):void
		{			
			mockUIElement.styleName = "title";
			mockUIElement.styleManager = styles;
			assertEquals( "", mockUIElement.antiAliasType );
			
			mockUIElement.setStyle();			
			assertEquals( "advanced", mockUIElement.antiAliasType );
			assertNotNull( mockUIElement.skin.upSkin );						
		}
		
		private function timeout( object:Object ):void
		{
	    	Assert.fail( "Pending Event Never Occurred" );
		}			
	}
}
