package test.com.wezside.components 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.layout.PaddedLayout;
	import com.wezside.components.layout.VerticalLayout;
	import com.wezside.components.scroll.VScroll;
	import com.wezside.components.shape.Rectangle;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MockUIDecoratorTest extends UIElement 
	{
		
		private var hbox:UIElement;

		
		public function MockUIDecoratorTest()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, initStage );
		}

		private function initStage( event:Event ):void 
		{			
			x = 20;
			y = 20;			
			
			scroll = new VScroll( this );
			scroll.scrollHeight = 150; 
			scroll.horizontalGap = 2;

			layout = new PaddedLayout( this ); 
			layout.bottom = 15;		
			layout.left = 15;
			layout.top = 15;
			layout.right = 15;
			
			layout = new VerticalLayout( layout );
			layout.verticalGap = 3;			
			
			background = new Rectangle( this );
			background.colours = [ 0, 0 ];
			background.alphas = [ 1, 1 ];
			
			build();
			arrange();
		}

		override public function build():void
		{			
			

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xff0000, 0xff0000 ];
			hbox.background.alphas = [ 1, 1];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build();
			hbox.arrange();
			addChild( hbox );

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xFF5100, 0xFF5100 ];
			hbox.background.alphas = [ 0.3, 0.3];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build();
			hbox.arrange();			
			addChild( hbox );

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xFFF300, 0xFFF300 ];
			hbox.background.alphas = [ 1, 1];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build();
			hbox.arrange();					
			addChild( hbox );
			
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill( 0xEEEEE );
			sp.graphics.drawRect(0, 0, 200, 50 );
			sp.graphics.endFill();
			addChild( sp );
			
			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xFFF300, 0xFFF300 ];
			hbox.background.alphas = [ 1, 1];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build();
			hbox.arrange();					
			addChild( hbox );			
		
			super.build();			
		}	
	}
}
