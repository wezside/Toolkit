package test.com.wezside.component.decorator 
{
	import com.wezside.component.UIElement;
	import com.wezside.component.UIElementState;
	import com.wezside.component.decorator.interactive.InteractiveSelectable;
	import com.wezside.component.decorator.shape.ShapeRectangle;
	import com.wezside.utilities.observer.IObserverDetail;

	import flash.events.MouseEvent;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestInteractive extends UIElement
	{
		private static const MY_NEW_STATE:String = "MY_NEW_STATE";
		
		public function VisualTestInteractive()
		{
			super( );
			
			interactive = new InteractiveSelectable( this );

			background = new ShapeRectangle( this );
			background.alphas = [ 1 ];
			background.colours = [ 1 ];
			background.width = 200;
			background.height = 50;
			
			stateManager.addState( MY_NEW_STATE );
				
			// Internal state specific handler
			setObserveState( MY_NEW_STATE, myNewStateChange );
			setObserveState( UIElementState.STATE_VISUAL_UP, upStateChange );
			setObserveState( UIElementState.STATE_VISUAL_SELECTED, selectedStateChange );

			build();
			setStyle();
			arrange();
			activate();
			addEventListener( MouseEvent.CLICK, click );
		}

		private function click( event:MouseEvent ):void
		{
			trace( "click" );
			state = MY_NEW_STATE;
		}

		private function myNewStateChange( detail:IObserverDetail ):void
		{
			trace( "myNewStateChange ");
		}

		private function selectedStateChange( detail:IObserverDetail ):void
		{
			background.colours = [ 0xFF0000 ];
			background.arrange();
		}
		
		public function upStateChange( detail:IObserverDetail ):void
		{
			background.colours = [ 0 ];
			background.arrange();			
		}
			
		override public function notify( detail:IObserverDetail ):void
		{
			trace( detail.state.key );
		}
	}
}
