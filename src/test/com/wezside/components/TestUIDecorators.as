package test.com.wezside.components 
{
	import com.wezside.components.shape.Rectangle;
	import com.wezside.components.UIElement;
	import com.wezside.components.layout.HorizontalLayout;
	import com.wezside.components.layout.Layout;
	import com.wezside.components.layout.VerticalLayout;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestUIDecorators 
	{
		private var uiElement:UIElement;
		private var hbox:UIElement;

		[Before]
		public function setUp():void
		{
			uiElement = new UIElement();
			hbox = new UIElement();
		}
		
		[After]
		public function tearDown():void
		{
			hbox.purge();
			hbox = null;
			
			uiElement.purge();
			uiElement = null;
		}
				
		[Test]
		public function testLayoutDecorators():void
		{
			assertNull( uiElement.layout );				
			assertEquals( 0, uiElement.numChildren );	
			
			// Create first layout decorator
			uiElement.layout = new HorizontalLayout( uiElement );
			uiElement.layout.horizontalGap = 10;
			assertNotNull( uiElement.layout );
			
			uiElement.layout = new VerticalLayout( uiElement.layout );
			uiElement.layout.verticalGap = 15;
		
			assertEquals( 10, uiElement.layout.horizontalGap );
			assertEquals( 15, uiElement.layout.verticalGap );
			
			// Test commutiveness
			uiElement.layout = new HorizontalLayout( uiElement );
			uiElement.layout.horizontalGap = 10;
			
			uiElement.layout = new VerticalLayout( uiElement.layout );
			uiElement.layout.verticalGap = 15;
			
			assertEquals( 10, uiElement.layout.horizontalGap );
			assertEquals( 15, uiElement.layout.verticalGap );
		}
		
		[Test]
		public function testShapeDecorators():void
		{
			assertNull( uiElement.background );	
			assertEquals( 0, uiElement.numChildren );	
			
			uiElement.background = new Rectangle( uiElement );
			assertNotNull( uiElement.background );
			
			uiElement.update();
			
			assertEquals( 3, uiElement.numChildren );
		}
		
		[Test]
		public function testShapeMixLayout():void
		{
			uiElement.background = new Rectangle( uiElement );
			uiElement.background.width = 200;
			uiElement.background.height = 200;
			uiElement.layout = new VerticalLayout( uiElement );
						
			hbox = new UIElement();			
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xff0000, 0xff0000 ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			uiElement.addChild( hbox );		
			
			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xff0000, 0xff0000 ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			uiElement.addChild( hbox );			
			
			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xff0000, 0xff0000 ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			uiElement.addChild( hbox );			
			
			uiElement.update( true );
			
			for ( var i:int = 0; i < uiElement.numChildren; ++i ) 
			{
				trace( uiElement.getChildAt(i) );	
			}
			
			assertEquals( 6, uiElement.numChildren );
		/*
		 *  [object Rectangle]
			[object Sprite]
			[object UIElement]
			[object UIElement]
			[object UIElement]
			com.wezside.components::UIElementSkin
		 */
			
			assertEquals( 0, uiElement.getChildAt(0).y );				
			assertEquals( 0, uiElement.getChildAt(1).y );				
			assertEquals( 0, uiElement.getChildAt(2).y );
			assertEquals( 50, uiElement.getChildAt(3).y );
			assertEquals( 100, uiElement.getChildAt(4).y );
			assertEquals( 0, uiElement.getChildAt(5).y );
		}
	}
}
