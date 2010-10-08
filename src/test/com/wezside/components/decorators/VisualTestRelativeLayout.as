package test.com.wezside.components.decorators
{
	import com.wezside.components.UIElement;
	import com.wezside.components.decorators.layout.RelativeLayout;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestRelativeLayout extends UIElement
	{
		public function VisualTestRelativeLayout()
		{
			super();
			
			var sp:UIElement = new UIElement();
			sp.graphics.beginFill( 0xfff000 );
			sp.graphics.drawRect( 0, 0, 200, 20 );
			sp.graphics.endFill();
			addChild( sp );
			
			layout = new RelativeLayout( this );
			RelativeLayout( layout ).target = sp;
			RelativeLayout( layout ).anchor = stage;
			
			
			build();
			setStyle();
			arrange();
			
		}
		
		
	}
}
