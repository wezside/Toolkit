package test.com.wezside.components 
{
	import org.flexunit.asserts.assertNull;
	import flexunit.framework.Assert;

	import test.com.wezside.sample.styles.LatinStyle;

	import com.wezside.components.IUIElement;
	import com.wezside.components.UIElementState;

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
		
		[Test][Ignore]
		public function testUIElementStates():void
		{
			mockUIElement.state = UIElementState.STATE_VISUAL_UP;
			mockUIElement.state = UIElementState.STATE_VISUAL_SELECTED;
			assertEquals( mockUIElement.state, UIElementState.STATE_VISUAL_SELECTED+UIElementState.STATE_VISUAL_UP );
		}

		[Test(async)]
		public function testStyleManagerWithChildren():void
		{			
			styles.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleWithChildren, 5000, null, timeout ), false, 0, true );
		}
		
		[Test(async)][Ignore]
		public function testStyleManagerNoChildren():void
		{			
			styles.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReady, 5000, null, timeout ), false, 0, true );
		}
		
		private function styleWithChildren( event:Event, object:Object ):void
		{	
			mockUIElement.styleName = "title";
			mockUIElement.styleManager = styles;
			assertNull( mockUIElement.child );
			mockUIElement.update();
			
			assertNotNull( mockUIElement.child );
			assertNull( IUIElement( mockUIElement.child ).styleManager );
			assertNull( IUIElement( mockUIElement.child ).styleName );
						
			mockUIElement.child.inheritCSS = true;
			mockUIElement.setStyle();
			
			assertNotNull( IUIElement( mockUIElement.child ).styleManager );
			assertNotNull( IUIElement( mockUIElement.child ).styleName );
			
			mockUIElement.child.setStyle();
			assertEquals( "advanced", MockChildUIElement( mockUIElement.child ).antiAliasType  );
			
			IUIElement( mockUIElement.child ).styleName = "body";			
			mockUIElement.child.setStyle();
			assertEquals( "normal", MockChildUIElement( mockUIElement.child ).antiAliasType );
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
