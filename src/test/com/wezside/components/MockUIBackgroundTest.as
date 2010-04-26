package test.com.wezside.components 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.layout.HorizontalLayout;
	import com.wezside.components.layout.PaddedLayout;
	import com.wezside.components.layout.VerticalLayout;
	import com.wezside.components.shape.Rectangle;

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


		private function initStage(event:Event):void 
		{
			x = 20;
			y = 20;
			
			/*
			var sp:Sprite = new Sprite();
			addChild( sp );
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( width, height, 90 / 180 * Math.PI );
			sp.graphics.beginGradientFill( GradientType.LINEAR,  [ 0xFF00FB, 0xFFFFFF ], [1,1], [ 0,255 ], matrix );
			sp.graphics.drawRoundRect( 0, 0, 200, 100, 10 );			

			matrix = new Matrix();
			matrix.createGradientBox( width, height, 90 / 180 * Math.PI );
			sp.graphics.beginGradientFill( GradientType.LINEAR,  [ 0xFFFFFF, 0 ], [0, 1], [0,255 ], matrix );
			sp.graphics.drawRoundRect( 0, 30, 200, 100, 10 );				
			sp.filters = [ new DropShadowFilter()];
			*/
			
			layout = new HorizontalLayout( this );
			layout.horizontalGap = 20;
						
			background = new Rectangle( this );
			background.colours = [ 0, 0 ];
			background.alphas = [ 1, 1 ];
			
			layout = new VerticalLayout( this );
			layout.verticalGap = 10;
			
			layout = new PaddedLayout( layout ); 
			layout.verticalGap = 3;
			layout.bottom = 15;		
			layout.left = 15;
			layout.top = 15;
			layout.right = 15;

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
			
		}
	
	}
}
