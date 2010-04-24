package test.com.wezside.components 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.layout.HorizontalLayout;
	import com.wezside.components.layout.PaddedLayout;
	import com.wezside.components.layout.VerticalLayout;
	import com.wezside.components.shape.Rectangle;
	import com.wezside.components.shape.ShapeFilter;

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
			
			layout = new HorizontalLayout( this );
			layout.horizontalGap = 5;
							
			layout = new VerticalLayout( this );
			layout.verticalGap = 5;
			
			layout = new PaddedLayout( layout );
			layout.bottom = 5;		
			layout.left = 5;		
			layout.top = 5;		
			layout.right = 5;

			background = new Rectangle( this );
			background.backgroundColours = [ 0xffffff, 0xffffff ];
			background.backgroundAlphas = [ 1, 1 ];
						
			background = new Rectangle( background );
			background.backgroundColours = [ 0, 0xffEFA ];
			background.backgroundAlphas = [ .5, .5 ];
			background.cornerRadius = 20;
			
//			background = new Resizer( background );
			background = new ShapeFilter( background ); 			
						
			super.update();
		}

		override public function build():void
		{			
					
			super.build();
								
			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.backgroundColours = [ 0xff0000, 0xff0000 ];
			hbox.background.backgroundAlphas = [ 1, 1 ];			
			hbox.background.backgroundWidth = 200;
			hbox.background.backgroundHeight = 50;
			hbox.layout = new HorizontalLayout( hbox );
			addChild( hbox );

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.backgroundColours = [ 0xffEFA, 0xffEFA ];
			hbox.background.backgroundAlphas = [ 1, 1 ];			
			hbox.background.backgroundWidth = 200;
			hbox.background.backgroundHeight = 50;
			hbox.layout = new HorizontalLayout( hbox );
			addChild( hbox );

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.backgroundColours = [ 0xEEEFFF, 0xEEEFFF ];
			hbox.background.backgroundAlphas = [ 1, 1 ];			
			hbox.background.backgroundWidth = 200;
			hbox.background.backgroundHeight = 50;
			hbox.layout = new HorizontalLayout( hbox );
			addChild( hbox );

		}
	
	}
}
