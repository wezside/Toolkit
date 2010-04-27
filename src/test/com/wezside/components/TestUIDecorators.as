package test.com.wezside.components 
{
	import com.wezside.components.scroll.VScroll;
	import com.wezside.components.UIElement;
	import com.wezside.components.layout.HorizontalLayout;
	import com.wezside.components.layout.PaddedLayout;
	import com.wezside.components.layout.VerticalLayout;
	import com.wezside.components.shape.Rectangle;

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
			assertEquals( 3, uiElement.numChildren );	
			
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
			assertEquals( 3, uiElement.numChildren );	
			
			uiElement.background = new Rectangle( uiElement );
			assertNotNull( uiElement.background );
			
			uiElement.update();			
			assertEquals( 5, uiElement.numChildren );
		}
		
		[Test]
		public function testVerticalLayout():void
		{
			uiElement.background = new Rectangle( uiElement );
			uiElement.background.width = 200;
			uiElement.background.height = 200;
			uiElement.layout = new VerticalLayout( uiElement );
				
			uiElement.update( true );
			assertEquals( 5, uiElement.numChildren );
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
			
			uiElement.background = new Rectangle( uiElement );
			uiElement.background.colours = [0,0];
			uiElement.background.alphas = [1,1];
						
			uiElement.update( true );
			dumpChildren();
			assertEquals( 5, uiElement.numChildren );
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
			
			uiElement.background = new Rectangle( uiElement );
			uiElement.background.colours = [0,0];
			uiElement.background.alphas = [1,1];	
			
			uiElement.layout = new PaddedLayout( uiElement );
			uiElement.layout.top = 15;		
			uiElement.layout.left = 15;		
			uiElement.layout.bottom = 15;		
			uiElement.layout.right = 15;
					
			uiElement.layout = new VerticalLayout( uiElement.layout );
			uiElement.layout.verticalGap = 5;
			uiElement.update( true );			
						
			assertEquals( 5, uiElement.numChildren );						
			assertEquals( 20, uiElement.x );
			assertEquals( 20, uiElement.y );
			assertEquals( 15, uiElement.getChildAt(1).y );
			assertEquals( 70, uiElement.getChildAt(2).y );
			assertEquals( 125, uiElement.getChildAt(3).y );
			assertEquals( 15, uiElement.getChildAt(1).x );
			assertEquals( 190, int( uiElement.height ));
		}
		
		
		[Test]
		public function testPaddingWithHorizontalLayout():void	
		{
			
			uiElement.x = 20;
			uiElement.y = 20;
			
			uiElement.background = new Rectangle( uiElement );
			uiElement.background.colours = [0,0];
			uiElement.background.alphas = [1,1];	
					
			uiElement.layout = new PaddedLayout( uiElement );
			uiElement.layout.top = 15;		
			uiElement.layout.left = 15;		
			uiElement.layout.bottom = 15;		
			uiElement.layout.right = 15;				
			
			uiElement.layout = new HorizontalLayout( uiElement.layout );
			uiElement.update( true );
						
			assertEquals( 5, uiElement.numChildren );						
			assertEquals( 20, uiElement.x );
			assertEquals( 20, uiElement.y );
			assertEquals( 15, uiElement.getChildAt(1).x );
			assertEquals( 215, uiElement.getChildAt(2).x );
			assertEquals( 415, uiElement.getChildAt(3).x );
			assertEquals( 630, uiElement.width );
		}
		
		
		[Test]
		public function testVScroll():void
		{
			uiElement.layout = new VerticalLayout( uiElement );
			
			uiElement.background = new Rectangle( uiElement );
			uiElement.background.colours = [0,0];
			uiElement.background.alphas = [1,1];
							
			uiElement.scroll = new VScroll( uiElement );
			uiElement.update( true );
			assertEquals( 6, uiElement.numChildren );
			
			trace("---------------------", "testVScroll", "---------------------");
			dumpChildren();
			trace( "---------------------", "end", "---------------------");
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
