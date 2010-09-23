package test.com.wezside.components 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.decorators.layout.HorizontalLayout;
	import com.wezside.components.decorators.layout.PaddedLayout;
	import com.wezside.components.decorators.layout.VerticalLayout;
	import com.wezside.components.decorators.scroll.ScrollVertical;
	import com.wezside.components.decorators.shape.ShapeRectangle;

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
			hbox.background = new ShapeRectangle( hbox );
			hbox.background.colours = [ 0xff0000, 0xff0000 ];
			hbox.background.alphas = [ 1, 1 ];
			hbox.background.cornerRadius = 10;
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build();
			hbox.arrange();
			uiElement.addChild( hbox );			
			
			hbox = new UIElement();
			hbox.background = new ShapeRectangle( hbox );
			hbox.background.colours = [ 0xff0000, 0xff0000 ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build();
			hbox.arrange();
			uiElement.addChild( hbox );
									
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
			assertNotNull( uiElement.layout );				
			assertEquals( 2, uiElement.numChildren );	
			
			uiElement.build( );
			uiElement.arrange();			
			
			// Create first layout decorator
			uiElement.layout = new HorizontalLayout( uiElement );
			uiElement.layout.horizontalGap = 10;
			assertNotNull( uiElement.layout );
			assertEquals( 10, uiElement.layout.horizontalGap );
			
			uiElement.layout = new VerticalLayout( uiElement.layout );
			uiElement.layout.verticalGap = 15;
		
			assertEquals( 0, uiElement.layout.horizontalGap );
			assertEquals( 15, uiElement.layout.verticalGap );
			
			// Test commutiveness
			uiElement.layout = new HorizontalLayout( uiElement );
			uiElement.layout.horizontalGap = 10;
			
			uiElement.layout = new VerticalLayout( uiElement.layout );
			uiElement.layout.verticalGap = 15;
			
			assertEquals( 0, uiElement.layout.horizontalGap );
			assertEquals( 15, uiElement.layout.verticalGap );
		}
		
		[Test]
		public function testShapeDecorators():void
		{
			assertNull( uiElement.background );	
			assertEquals( 2, uiElement.numChildren );	
			
			uiElement.background = new ShapeRectangle( uiElement );
			assertNotNull( uiElement.background );
			
			uiElement.build();			
			uiElement.arrange();			
			assertEquals( 2, uiElement.numChildren );
		}
		
		[Test]
		public function testVerticalLayout():void
		{
			uiElement.background = new ShapeRectangle( uiElement );
			uiElement.background.width = 200;
			uiElement.background.height = 200;
			uiElement.layout = new VerticalLayout( uiElement );
				
			uiElement.build();
			uiElement.arrange();
			
			assertEquals( 2, uiElement.numChildren );
		}
		
		[Test]
		public function testPadding():void
		{
			uiElement.x = 20;
			uiElement.y = 20;

			uiElement.layout = new PaddedLayout( uiElement );
			uiElement.layout.top = 15;		
			uiElement.layout.left = 15;		
			uiElement.layout.bottom = 15;		
			uiElement.layout.right = 15;							
			
			uiElement.background = new ShapeRectangle( uiElement );
			uiElement.background.colours = [0,0];
			uiElement.background.alphas = [1,1];
						
			uiElement.build();
			uiElement.arrange();
			dumpChildren();
			assertEquals( 2, uiElement.numChildren );
			assertEquals( 20, uiElement.x );
			assertEquals( 20, uiElement.y );
			assertEquals( 0, uiElement.getChildAt(0).x );
			assertEquals( 0, uiElement.getChildAt(0).y );
			assertEquals( 15+15+200, uiElement.width );
			assertEquals( 15+15+50, uiElement.height );
		}
		
		[Test]
		public function testPaddingWithVerticalLayout():void	
		{			
			uiElement.x = 20;
			uiElement.y = 20;
			
			uiElement.background = new ShapeRectangle( uiElement );
			uiElement.background.colours = [ 0, 0 ];
			uiElement.background.alphas = [ 1, 1 ];	
			
			uiElement.layout = new PaddedLayout( uiElement );
			uiElement.layout.top = 15;		
			uiElement.layout.left = 15;		
			uiElement.layout.bottom = 15;		
			uiElement.layout.right = 15;
					
			uiElement.layout = new VerticalLayout( uiElement.layout );
			uiElement.layout.verticalGap = 5;
			uiElement.build();			
			uiElement.arrange();			
						
			assertEquals( 2, uiElement.numChildren );						
			assertEquals( 20, uiElement.x );
			assertEquals( 20, uiElement.y );
			assertEquals( 135, int( uiElement.height ));
		}
		
		
		[Test]
		public function testPaddingWithHorizontalLayout():void	
		{
			
			uiElement.x = 20;
			uiElement.y = 20;
			
			uiElement.background = new ShapeRectangle( uiElement );
			uiElement.background.colours = [0,0];
			uiElement.background.alphas = [1,1];	
					
			uiElement.layout = new PaddedLayout( uiElement );
			uiElement.layout.top = 15;		
			uiElement.layout.left = 15;		
			uiElement.layout.bottom = 15;		
			uiElement.layout.right = 15;				
			
			uiElement.layout = new HorizontalLayout( uiElement.layout );
			uiElement.build();
			uiElement.arrange();
						
			assertEquals( 2, uiElement.numChildren );						
			assertEquals( 20, uiElement.x );
			assertEquals( 20, uiElement.y );
			assertEquals( 430, uiElement.width );
		}
		
		
		[Test]
		public function testVScroll():void
		{
			uiElement.layout = new VerticalLayout( uiElement );
			
			uiElement.background = new ShapeRectangle( uiElement );
			uiElement.background.colours = [0,0];
			uiElement.background.alphas = [1,1];
							
			uiElement.scroll = new ScrollVertical( uiElement );
			uiElement.build();
			uiElement.arrange();
			assertEquals( 2, uiElement.numChildren );
			
			trace("---------------------", "testVScroll", "---------------------");
			dumpChildren();
			trace( "---------------------", "end", "---------------------");
		}		
		
		
		[Test]
		public function testArrange():void
		{
			uiElement.x = 0;
			uiElement.y = 0;
			
			uiElement.background = new ShapeRectangle( uiElement );
			uiElement.background.colours = [ 0, 0 ];
			uiElement.background.alphas = [ 1, 1 ];	
					
			uiElement.layout = new PaddedLayout( uiElement );
			uiElement.layout.top = 15;		
			uiElement.layout.left = 15;		
			uiElement.layout.bottom = 15;		
			uiElement.layout.right = 15;				
			
			uiElement.layout = new HorizontalLayout( uiElement.layout );
			uiElement.build();
			uiElement.arrange();
						
			assertEquals( 430, uiElement.width );		
			uiElement.arrange();
			assertEquals( 430, uiElement.width );
			
		}
		
		private function dumpChildren():void
		{
			for ( var i:int = 0; i < uiElement.numChildren; ++i ) 
			{
				trace( uiElement.getChildAt(i), uiElement.getChildAt(i).x, uiElement.getChildAt(i).y,
					   uiElement.getChildAt(i).width, uiElement.getChildAt(i).height );	
			}			
		}
	}
}
