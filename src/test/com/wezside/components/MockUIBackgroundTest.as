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
			
//			layout = new HorizontalLayout( this );
//			layout.horizontalGap = 5;
//							
			layout = new VerticalLayout( this );
			layout.verticalGap = 15;
			
			layout = new PaddedLayout( layout );
			layout.bottom = 5;		
			layout.left = 5;		
			layout.top = 5;		
			layout.right = 5;

			background = new Rectangle( this );
			background.colours = [ 0, 0 ];
			background.alphas = [ 1, 0 ];
						
			background = new Rectangle( this );
			background.colours = [ 0xFFFFFF, 0xFFFFFF ];
			background.alphas = [ 1, 1 ];
			
//			background = new Resizer( background );
//			background = new ShapeFilter( background ); 			
						
			super.update();
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
			hbox.background.colours = [ 0xffEFA, 0xffEFA ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			addChild( hbox );

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xAFEFDD, 0xAFEFDD ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			addChild( hbox );

		}
	
	}
}
