package test.com.wezside.components 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.layout.PaddedLayout;
	import com.wezside.components.layout.VerticalLayout;
	import com.wezside.components.shape.Rectangle;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MockUIBackgroundTest extends UIElement 
	{
		
		private var hbox:UIElement;


		public function MockUIBackgroundTest()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, initStage );
		}

		private function initStage( event:Event ):void 
		{
			x = 20;
			y = 20;			
			
			layout = new VerticalLayout( this );
			layout.verticalGap = 3;

			layout = new PaddedLayout( layout ); 
			layout.bottom = 15;		
			layout.left = 15;
			layout.top = 15;
			layout.right = 15;
			
			background = new Rectangle( this );
			background.colours = [ 0, 0 ];
			background.alphas = [ 1, 1 ];
			
//			layout = new HScroller( layout );
//			layout = new VScroller( layout );
//			background = new Resizer( background );
//			background = new ShapeFilter( background ); 				
						
			super.update( true );
		}

		override public function build():void
		{			
					
			super.build();

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xff0000, 0xff0000 ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			addChild( hbox );

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xFF5100, 0xFF5100 ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			addChild( hbox );

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xFFF300, 0xFFF300 ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			addChild( hbox );
			
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill( 0xAEFBB );
			sp.graphics.drawRect(0, 0, 200, 50 );
			sp.graphics.endFill();
			addChild( sp );
			
		}
	
	}
}
