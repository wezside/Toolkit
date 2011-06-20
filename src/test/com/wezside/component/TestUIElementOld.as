package test.com.wezside.component 
{
	import com.wezside.component.IUIElement;
	import com.wezside.component.UIElementState;
	import com.wezside.component.decorator.layout.HorizontalLayout;
	import com.wezside.component.decorator.layout.PaddedLayout;
	import com.wezside.component.decorator.layout.VerticalLayout;
	import flash.events.Event;
	import flexunit.framework.Assert;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	import sample.style.LatinStyle;





	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestUIElementOld 
	{

		private var styles:LatinStyle;
		private var mockUIElement:MockUIElement;

		[Before]
		public function setUp():void
		{			
			mockUIElement = new MockUIElement();
		}

		[After]
		public function tearDown():void
		{
			styles = null;
			mockUIElement = null;
		}
		
		[Test]
		public function testUIElementPurge():void
		{
			mockUIElement.purge();
			mockUIElement = new MockUIElement();
			assertEquals( 0, mockUIElement.numChildren );
			mockUIElement.purge();
			assertEquals( 0, mockUIElement.numChildren );
		}
		
		[Test]
		public function testUIElementLayout():void
		{
			mockUIElement.layout = new HorizontalLayout( mockUIElement );	
			mockUIElement.layout.horizontalGap = 10;	
			assertEquals( 10, mockUIElement.layout.horizontalGap );
			
			mockUIElement.layout = new VerticalLayout( mockUIElement.layout );
			mockUIElement.layout.verticalGap = 20;	
			assertEquals( 20, mockUIElement.layout.verticalGap );
			
			mockUIElement.layout = new PaddedLayout( mockUIElement.layout );
			mockUIElement.layout.bottom = 5;		
			mockUIElement.layout.left = 5;		
			mockUIElement.layout.top = 5;		
			mockUIElement.layout.right = 5;			
		}		
		
		[Test]
		public function testUIElementStates():void
		{
			mockUIElement.state = UIElementState.STATE_VISUAL_UP;
			mockUIElement.state = UIElementState.STATE_VISUAL_SELECTED;
			assertEquals( mockUIElement.state, UIElementState.STATE_VISUAL_SELECTED+UIElementState.STATE_VISUAL_UP );
		}

		[Test(async)]
		public function testStyleManagerWithChildren():void
		{			
			styles = new LatinStyle();
			styles.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleWithChildren, 5000, null, timeout ), false, 0, true );
		}
		
		[Test(async)]
		public function testStyleManagerNoChildren():void
		{			
			styles = new LatinStyle();
			styles.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReady, 5000, null, timeout ), false, 0, true );
		}
		
		private function styleWithChildren( event:Event, object:Object ):void
		{	
//			mockUIElement.styleName = "Mo";
			mockUIElement.styleManager = styles;
			assertNull( mockUIElement.child );
			mockUIElement.build();
			mockUIElement.arrange();
			
			assertNotNull( mockUIElement.child );
			assertNull( IUIElement( mockUIElement.child ).styleManager );
			assertNull( IUIElement( mockUIElement.child ).styleName );
						
			mockUIElement.child.styleManager = styles;
			mockUIElement.child.styleName = "title";
			mockUIElement.setStyle();
			assertEquals( "MockUIElement", mockUIElement.styleName );
			assertEquals( "normal", mockUIElement.antiAliasType );
			
			assertNotNull( IUIElement( mockUIElement.child ).styleManager );
			assertNotNull( IUIElement( mockUIElement.child ).styleName );
			
			mockUIElement.child.setStyle();
			assertEquals( "advanced", MockChildUIElement( mockUIElement.child ).antiAliasType  );
			
			IUIElement( mockUIElement.child ).styleName = "body";			
			mockUIElement.child.setStyle();
			assertEquals( "advanced", MockChildUIElement( mockUIElement.child ).antiAliasType );
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
