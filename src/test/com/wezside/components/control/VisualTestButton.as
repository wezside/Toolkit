package test.com.wezside.components.control 
{
	import test.com.wezside.sample.style.LatinStyle;

	import com.wezside.components.UIElementEvent;
	import com.wezside.components.UIElementState;
	import com.wezside.components.control.Button;
	import com.wezside.components.text.Label;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestButton extends Sprite 
	{
		
		private var button:Button;
		private var label:Label;
		private var styleManager:LatinStyle;

		public function VisualTestButton()
		{
			super( );			
			addEventListener( Event.ADDED_TO_STAGE, stageInit );
		}

		public function build():void 
		{	
			button = new Button();			
			button.addEventListener( UIElementEvent.STATE_CHANGE, stateChange );
			button.styleManager = styleManager;
			button.styleName = "button";
			button.text = "Lorem ipsum dolor sit amet, nunc a nonummy nec, nulla nibh sed class, sed duis suspendisse.";
			button.width = 300;
			button.height = 15;
			button.iconStyleName = "iconStylename";
			button.iconAlign = Button.ICON_PLACEMENT_CENTER_LEFT;
			button.build();
			button.setStyle();
			button.arrange();		
			addChild( button );
			button.activate();
			button.x = 50;
			button.y = 50;		
			
			label = new Label();
			label.text = "UIElement Button Example";
			label.styleName = "labelButton";
			label.styleManager = styleManager;
			label.width = 500;
			label.build();
			label.setStyle();
			label.arrange();
			label.activate();
			label.x = 50;
			label.y = 150;
			addChild( label );
			
			
			button.text = "Lorem ipsum dolor sit amet, nunc a nonummy nec, nulla nibh sed clas";
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

		private function stateChange( event:UIElementEvent ):void 
		{
			if ( event.state.key == UIElementState.STATE_VISUAL_SELECTED ) 
				trace( "Clicked", event.currentTarget );
		}
	}
}
