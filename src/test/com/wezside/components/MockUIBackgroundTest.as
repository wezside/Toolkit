package test.com.wezside.components 
{
	import flash.events.Event;
	import com.wezside.components.UIElement;
	import com.wezside.components.container.Box;
	import com.wezside.components.layout.HorizontalLayout;
	import com.wezside.components.layout.PaddedLayout;
	import com.wezside.components.layout.VerticalLayout;
	import com.wezside.components.shape.RoundedRectangle;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MockUIBackgroundTest extends UIElement 
	{
		private var hbox:Box;

		public function MockUIBackgroundTest()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, initStage );
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
						
			background = new RoundedRectangle( this );
			background.backgroundColours = [ 0xffffff, 0xffffff ];
			background.backgroundAlphas = [ 1, 1 ];
			
			var timer:Timer = new Timer( 1000, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, timerComplete );
			timer.start();
		}

		private function timerComplete(event:TimerEvent):void 
		{
			super.update();
		}

		override public function build():void
		{			
					
			super.build();
						
			hbox = new Box();
			hbox.width = 200;
			hbox.height = 50;
			hbox.backgroundColours = [ 0xff0000, 0xff0000 ];
			hbox.backgroundAlphas = [ 1, 1 ];			
			hbox.layout = new HorizontalLayout( hbox );
			addChild( hbox );
						
			hbox = new Box();
			hbox.width = 200;
			hbox.height = 50;
			hbox.backgroundColours = [ 0xffdfA, 0xffdfA ];
			hbox.backgroundAlphas = [ 1, 1 ];			
			hbox.layout = new HorizontalLayout( hbox );
			addChild( hbox );
						
			hbox = new Box();
			hbox.width = 200;
			hbox.height = 50;
			hbox.backgroundColours = [ 0xAEFFCC, 0xAEFFCC ];
			hbox.backgroundAlphas = [ 1, 1 ];			
			hbox.layout = new HorizontalLayout( hbox );
			addChild( hbox );

		}
	
	}
}
