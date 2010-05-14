package test.com.wezside.components.control 
{
	import test.com.wezside.sample.styles.LatinStyle;

	import com.wezside.components.UIElement;
	import com.wezside.components.control.Button;
	import com.wezside.components.layout.VerticalLayout;

	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MockButton extends UIElement 
	{
		
		private var button:Button;

		public function MockButton()
		{
			super( );			
			addEventListener( Event.ADDED_TO_STAGE, stageInit );
		}

		private function stageInit( event:Event ):void 
		{
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, styleReady );
		}

		private function styleReady( event:Event ):void 
		{
			build();
		}
		
		override public function build():void 
		{
			super.build();
			layout = new VerticalLayout( this );
			button = new Button();
			button.styleManager = styleManager;
			button.styleName = "button";
			button.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis justo in risus ultricies facilisis eget sit amet quam.";
			button.labelStyleName = "buttonLabel";
			button.build();
			button.setStyle();
			button.arrange();		
			addChild( button );
			button.activate();
			
			button.x = 50;
			button.y = 50;
		}
	}
}
