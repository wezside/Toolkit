package test.com.wezside.component.decorator 
{
	import com.wezside.component.UIElement;

	import flash.events.MouseEvent;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestInteractive extends UIElement
	{

		public function VisualTestInteractive()
		{
			super( );

			build();
			setStyle();
			arrange();
			activate();
			
			addEventListener( MouseEvent.CLICK, click );
		}

		private function click( event:MouseEvent ):void
		{
			trace( this );
		}
	
	}
}
