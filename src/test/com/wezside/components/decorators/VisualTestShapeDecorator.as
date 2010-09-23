package test.com.wezside.components.decorators
{
	import gs.TweenLite;
	import gs.easing.Cubic;

	import com.wezside.components.UIElement;
	import com.wezside.components.decorators.shape.ShapeRectangle;

	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
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
	
			TweenLite.to( DisplayObject( background ), 1.5, { delay: 1, height: 300, ease: Cubic.easeOut, onComplete: complete });
		}
		
		private function complete():void
		{
			TweenLite.to( DisplayObject( background ), 1.5, { delay: .5, height: 100, ease: Cubic.easeInOut });						
		}
	}
}
