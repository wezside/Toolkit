package test.com.wezside.component.decorator 
{
	import com.wezside.component.UIElement;
	import com.wezside.component.decorator.shape.ShapeRectangle;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestInteractive extends UIElement
	{

		public function VisualTestInteractive()
		{
			super( );
			
			background = new ShapeRectangle( this );
			background.width = 200;
			background.height = 200;
			background.colours = [ 0, 0 ];
			background.alphas = [ 1, 1 ];



			build();
			setStyle();
			arrange();
			activate();
		}
	
	}
}
