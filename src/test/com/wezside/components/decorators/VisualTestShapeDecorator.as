package test.com.wezside.components.decorators
{
	import flash.events.TimerEvent;
	import com.wezside.components.UIElement;
	import com.wezside.components.decorators.shape.ShapeRectangle;

	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestShapeDecorator extends UIElement
	{
		
		public function VisualTestShapeDecorator()
		{
			super();
			
			background = new ShapeRectangle( this );
			background.alphas = [1, 1];
			background.colours = [0, 0];
			background.width = 200;
			background.height = 200;
			background.cornerRadius = 40;
			background.scale9Grid = new Rectangle( 20, 20, 160, 160 );

			build();
			setStyle();
			arrange();
			
			x = 20;
			y = 20;
	
			background.height = 300;			
			var timer:Timer = new Timer( 1000, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, complete );
			timer.start();
		}
		
		private function complete( event:TimerEvent ):void
		{
			background.height = 50;						
		}
	}
}
