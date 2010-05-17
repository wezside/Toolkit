package test.com.wezside.components.control 
{
	import com.wezside.components.UIElementState;
	import test.com.wezside.sample.styles.LatinStyle;

	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.control.Button;
	import com.wezside.components.layout.HorizontalLayout;
	import com.wezside.components.text.Label;

	import flash.events.Event;
	import flash.events.TimerEvent;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestButton extends UIElement 
	{
		
		private var button:Button;
		private var label:Label;

		public function VisualTestButton()
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
			arrange();
		}

		private function timerComplete(event:TimerEvent):void 
		{
			layout = new HorizontalLayout( this );
			layout.arrange();
		}

		override public function build():void 
		{	
			button = new Button();			
			button.addEventListener( UIElementEvent.STATE_CHANGE, stateChange );
			button.styleManager = styleManager;
			button.styleName = "button";
			button.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis justo in risus ultricies facilisis eget sit amet quam.";
			button.labelStyleName = "buttonLabel";
			button.labelWidth = 220;
			button.labelHeight = 20;
			button.iconStyleName = "buttonIcon";
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
			
			super.build();
		}

		private function stateChange(event:UIElementEvent):void 
		{
			if ( event.state.key == UIElementState.STATE_VISUAL_SELECTED ) 
				trace( "Clicked ");
		}
	}
}
