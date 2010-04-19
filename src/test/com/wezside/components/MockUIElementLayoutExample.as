package test.com.wezside.components 
{
	import com.wezside.components.layout.VerticalLayout;
	import com.wezside.components.layout.ILayout;
	import com.wezside.components.layout.HorizontalLayout;
	import com.wezside.components.IUIElement;
	import com.wezside.components.UIElement;
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
	public class MockUIElementLayoutExample extends UIElement
	{


		private var styles:LatinStyle;
		private var mockUIElement:MockUIElement;
		private var timer:Timer;

		
		public function MockUIElementLayoutExample() 
		{

			styles = new LatinStyle();
			styles.addEventListener( Event.COMPLETE, styleReady );
		}

		
		private function styleReady( event:Event ):void
		{			
			styles.removeEventListener( Event.COMPLETE, styleReady );
			
			mockUIElement = new MockUIElement();		
			mockUIElement.x = 20;
			mockUIElement.y = 20;				
			mockUIElement.styleName = "title";
			mockUIElement.styleManager = styles;
			mockUIElement.setStyle();
			addChild( mockUIElement );
			mockUIElement.state = UIElementState.STATE_VISUAL_UP;			
			addListeners( mockUIElement );
					
			mockUIElement = new MockUIElement();		
			mockUIElement.x = 20;
			mockUIElement.y = 20;				
			mockUIElement.styleName = "title";
			mockUIElement.styleManager = styles;
			mockUIElement.setStyle();
			addChild( mockUIElement );
			mockUIElement.state = UIElementState.STATE_VISUAL_UP;					
			addListeners( mockUIElement );
			
			layout = new HorizontalLayout( this );
			arrange();
			
			layout = new VerticalLayout( this );
			arrangeTimer( layout );
		}
		
		private function arrangeTimer( layout:ILayout ):void
		{			
			var arrangeTimer:Timer = new Timer( 1000, 1 );
			arrangeTimer.addEventListener( TimerEvent.TIMER_COMPLETE, function():void { 
				
				if ( layout is VerticalLayout ) layout.verticalGap = 20;
				arrange();			
				
			 });
			arrangeTimer.start();			
		}
		
		private function addListeners( uiElement:UIElement ):void
		{			
			uiElement.buttonMode = true;
			uiElement.addEventListener( MouseEvent.ROLL_OVER, function():void { mockUIElement.state = UIElementState.STATE_VISUAL_OVER; });
			uiElement.addEventListener( MouseEvent.ROLL_OUT, function():void { mockUIElement.state = UIElementState.STATE_VISUAL_UP; });
			uiElement.addEventListener( MouseEvent.MOUSE_DOWN, down );
			uiElement.addEventListener( MouseEvent.MOUSE_UP, function():void { mockUIElement.state = UIElementState.STATE_VISUAL_UP; timer.reset(); } );			
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
