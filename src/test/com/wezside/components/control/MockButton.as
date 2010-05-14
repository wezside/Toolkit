package test.com.wezside.components.control 
{
	import flash.text.TextFieldAutoSize;
	import test.com.wezside.sample.styles.LatinStyle;

	import com.wezside.components.UIElement;
	import com.wezside.components.control.Button;
	import com.wezside.components.text.Label;

	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MockButton extends UIElement 
	{
		
		private var button:Button;
		private var label:Label;

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
			button = new Button();
			button.styleManager = styleManager;
			button.styleName = "button";
			button.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis justo in risus ultricies facilisis eget sit amet quam.";
			button.labelStyleName = "buttonLabel";
			button.labelWidth = 220;
			button.labelHeight = 20;
			button.build();
			button.setStyle();
			button.arrange();		
			addChild( button );
			button.activate();
			button.x = 50;
			button.y = 50;
			
			label = new Label();
			label.text = "Ut quis justo in risus ultricies facilisis eget";
			label.styleName = "buttonLabel";
			label.styleManager = styleManager;
			label.buttonMode = true;
			label.activate();
			label.build();
			label.setStyle();
			label.arrange();
			label.x = 50;
			label.y = 150;
			addChild( label );
		}
	}
}
