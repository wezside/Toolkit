package test.com.wezside.components 
{
	import test.com.wezside.sample.styles.LatinStyle;

	import com.wezside.components.UIElementState;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MockUIElementExample extends Sprite
	{


		private var styles:LatinStyle;
		private var mockUIElement:MockUIElement;
		private var timer:Timer;

		
		public function MockUIElementExample() 
		{
			mockUIElement = new MockUIElement();		
			mockUIElement.x = 20;
			mockUIElement.y = 20;	
			styles = new LatinStyle();
			styles.addEventListener( Event.COMPLETE, styleReady );			
		}

		
		private function styleReady( event:Event ):void
		{			
			styles.removeEventListener( Event.COMPLETE, styleReady );
			
			mockUIElement.styleName = "title";
			mockUIElement.styleManager = styles;
			mockUIElement.setStyle();
			addChild( mockUIElement );
			mockUIElement.state = UIElementState.STATE_VISUAL_UP;					
			
			mockUIElement.buttonMode = true;
			mockUIElement.addEventListener( MouseEvent.ROLL_OVER, function():void { mockUIElement.state = UIElementState.STATE_VISUAL_OVER; });
			mockUIElement.addEventListener( MouseEvent.ROLL_OUT, function():void { mockUIElement.state = UIElementState.STATE_VISUAL_UP; });
			mockUIElement.addEventListener( MouseEvent.MOUSE_DOWN, down );
			mockUIElement.addEventListener( MouseEvent.MOUSE_UP, function():void { mockUIElement.state = UIElementState.STATE_VISUAL_UP; timer.reset(); } );
		}

		private function click(event:MouseEvent):void 
		{
			mockUIElement.state = UIElementState.STATE_VISUAL_SELECTED;
		}

		private function down( event:MouseEvent ):void 
		{
			mockUIElement.state = UIElementState.STATE_VISUAL_DOWN;
			timer = new Timer( 1500, 1);
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, function():void { mockUIElement.state = UIElementState.STATE_VISUAL_SELECTED;	});
			timer.start();
		}

	}
}
