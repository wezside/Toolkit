package test.com.wezside.components.control
{
	import flexunit.framework.Assert;

	import test.com.wezside.sample.style.LatinStyle;

	import com.wezside.components.control.Button;
	import com.wezside.components.decorators.interactive.InteractiveSelectable;
	import com.wezside.components.decorators.layout.Layout;
	import com.wezside.components.decorators.layout.PaddedLayout;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;

	import flash.events.Event;
	
	
	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestButton
	{
		private var button:Button;
		private var styleManager:LatinStyle;
		
		[Before]
		public function setUp():void
		{			
			styleManager = new LatinStyle();			
			button = new Button();
			button.interactive = new InteractiveSelectable( button );
			button.styleManager = styleManager;
			button.styleName = "button";
			button.text = "Lorem ipsum dolor sit amet, nunc a nonummy nec";
			button.layout = new PaddedLayout( button.layout );
			button.width = 200;
		}
		
		[After]
		public function tearDown():void
		{
			button.purge();
			button = null;
			styleManager = null;
		}
		
		[Test(async)]
		public function testButtonNoIcon():void
		{			
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReady, 5000, null, timeout ), false, 0, true );
		}		
		
		[Test(async)]
		public function testButtonWithIconCenter():void
		{			
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReadyWithIconCenter, 5000, null, timeout ), false, 0, true );
		}
				
		[Test(async)]
		public function testButtonWithIconCenterLeft():void
		{			
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReadyWithIconCenterLeft, 5000, null, timeout ), false, 0, true );
		}		
				
		[Test(async)]
		public function testButtonWithIconCenterRight():void
		{			
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReadyWithIconCenterRight, 5000, null, timeout ), false, 0, true );
		}		
				
		[Test(async)]
		public function testButtonWithIconTopRight():void
		{			
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReadyWithIconTopRight, 5000, null, timeout ), false, 0, true );
		}		
				
		[Test(async)]
		public function testButtonWithIconTopCenter():void
		{			
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReadyWithIconTopCenter, 5000, null, timeout ), false, 0, true );
		}		
				
		[Test(async)]
		public function testButtonWithIconTopLeft():void
		{			
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReadyWithIconTopLeft, 5000, null, timeout ), false, 0, true );
		}		
				
		[Test(async)]
		public function testButtonWithIconBottomLeft():void
		{			
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReadyWithIconBottomLeft, 5000, null, timeout ), false, 0, true );
		}		
				
		[Test(async)]
		public function testButtonWithIconBottomCenter():void
		{			
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, Async.asyncHandler( this, styleReadyWithIconBottomLeft, 5000, null, timeout ), false, 0, true );
		}		
		
		private function styleReady( event:Event, object:Object ):void
		{							
			button.autoSkinSize = true;
			button.build();
			button.setStyle();
			button.arrange();
			button.activate();
			assertEquals( 200, button.width );
		}
		
		private function styleReadyWithIconCenter( event:Event, object:Object ):void
		{							
			// Test PLACEMENT_CENTER
			button.autoSkinSize = true;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_CENTER;			
			button.build();
			button.setStyle();
			button.arrange();
			
			assertEquals( 200, button.width );
			assertEquals( 25, button.icon.width );
			assertEquals( 87.5, button.icon.x );
			assertEquals( Math.round((( button.height - button.icon.height ) * 0.5 ) * 10 ) / 10, button.icon.y );			
		}
		
		private function styleReadyWithIconCenterLeft( event:Event, object:Object ):void
		{			
			
			// Test PLACEMENT_CENTER_LEFT
			button.autoSkinSize = true;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_CENTER_LEFT;			
			button.build();
			button.setStyle();
			button.arrange();
			
			assertEquals( 225, button.width );
			assertEquals( 25, button.icon.width );
			assertEquals( 0, button.icon.x );
			assertEquals( Math.round((( button.height - button.icon.height ) * 0.5 ) * 10 ) / 10, button.icon.y );
			
		}
		
		private function styleReadyWithIconCenterRight( event:Event, object:Object ):void
		{				
			// Test PLACEMENT_CENTER_RIGHT
			button.autoSkinSize = true;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_CENTER_RIGHT;			
			button.build();
			button.setStyle();
			button.arrange();
			
			trace( button.height, button.icon.height );
			
			assertEquals( 225, button.width );
			assertEquals( 25, button.icon.width );
			assertEquals( 25, button.icon.height );
			assertEquals( 200, button.icon.x );
			assertEquals( Math.round((( button.height - button.icon.height ) * 0.5 ) * 10 ) / 10, button.icon.y );			
		}
		
		private function styleReadyWithIconTopRight( event:Event, object:Object ):void
		{			
			// Test PLACEMENT_TOP_RIGHT
			button.autoSkinSize = true;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_TOP_RIGHT;			
			button.build();
			button.setStyle();
			button.arrange();
			
			assertEquals( 225, button.width );
			assertEquals( 25, button.icon.width );
			assertEquals( 200, button.icon.x );
			assertEquals( 0, button.icon.y );			
		}
		
		private function styleReadyWithIconTopCenter( event:Event, object:Object ):void
		{			
			// Test PLACEMENT_TOP_CENTER
			button.autoSkinSize = true;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_TOP_CENTER;			
			button.build();
			button.setStyle();
			button.arrange();
			
			assertEquals( 200, button.width );
			assertEquals( 25, button.icon.width );
			assertEquals( 87.5, button.icon.x );
			assertEquals( 0, button.icon.y );			
		}
		
		private function styleReadyWithIconTopLeft( event:Event, object:Object ):void
		{			
			// Test PLACEMENT_TOP_LEFT
			button.autoSkinSize = true;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_TOP_LEFT;			
			button.build();
			button.setStyle();
			button.arrange();
			
			assertEquals( 225, button.width );
			assertEquals( 25, button.icon.width );
			assertEquals( 0, button.icon.x );
			assertEquals( 0 , button.icon.y );
		}
		
		private function styleReadyWithIconBottomLeft( event:Event, object:Object ):void
		{			
			// Test PLACEMENT_TOP_LEFT
			button.autoSkinSize = true;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_BOTTOM_LEFT;			
			button.build();
			button.setStyle();
			button.arrange();
			
			assertEquals( 225, button.width );
			assertEquals( 25, button.icon.width );
			assertEquals( 0, button.icon.x );
			assertEquals( 30, button.icon.y );
		}
		
		private function styleReadyWithIconBottomCenter( event:Event, object:Object ):void
		{			
			// Test PLACEMENT_TOP_CENTER
			button.autoSkinSize = true;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_BOTTOM_CENTER;		
			button.build();
			button.setStyle();
			button.arrange();
			
			assertEquals( 225, button.width );
			assertEquals( 25, button.icon.width );
			assertEquals( 87.5, button.icon.x );
			assertEquals( -6, button.icon.y );			
		}
		
		private function styleReadyWithIconBottomRight( event:Event, object:Object ):void
		{			
			// Test PLACEMENT_BOTTOM_RIGHT
			button.autoSkinSize = true;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_BOTTOM_RIGHT;		
			button.build();
			button.setStyle();
			button.arrange();
			
			assertEquals( 225, button.width );
			assertEquals( 25, button.icon.width );
			assertEquals( 87.5, button.icon.x );
			assertEquals( 5.65, button.icon.y );			
		}

		private function timeout( object:Object ):void
		{
	    	Assert.fail( "Pending Event Never Occurred" );
		}		

	}
}
