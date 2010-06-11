package test.com.wezside.components.control 
{
	import test.com.wezside.sample.style.LatinStyle;

	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.UIElementState;
	import com.wezside.components.control.Button;
	import com.wezside.components.decorators.interactive.InteractiveSelectable;
	import com.wezside.components.decorators.layout.Layout;
	import com.wezside.components.decorators.layout.PaddedLayout;
	import com.wezside.components.decorators.layout.VerticalLayout;
	import com.wezside.components.decorators.shape.Rectangle;
	import com.wezside.components.text.Label;

	import flash.display.Sprite;
	import flash.events.Event;

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

		override public function build():void 
		{	
			label = new Label();
			label.text = "UIElement Button Example";
			label.styleName = "labelButton";
			label.styleManager = styleManager;
			label.width = 500;
			label.build();
			label.setStyle();
			label.arrange();
			label.activate();
			label.addEventListener( UIElementEvent.STATE_CHANGE, stateChange );
			addChild( label );			
			
			button = new Button();
			button.interactive = new InteractiveSelectable( button );
			button.addEventListener( UIElementEvent.STATE_CHANGE, stateChange );
			button.styleManager = styleManager;
			button.styleName = "button";
			button.text = "Lorem ipsum dolor sit amet, nunc a nonummy nec, nulla nibh sed class, sed duis suspendisse.Lorem ipsum dolor sit amet, nunc a nonummy nec, nulla nibh sed class, sed duis suspendisse.";
			button.width = 300;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_CENTER_LEFT;
			button.textPlacement = Layout.PLACEMENT_CENTER_LEFT;
			button.build();
			button.setStyle();
			button.arrange();		
			addChild( button );
			button.activate();
						
			y = 100;
			
			super.build();
		}

		
		private function stageInit( event:Event ):void 
		{			
			background = new Rectangle( this );
			background.colours = [ 0, 0 ];
			background.alphas = [ 0.01, 0.05 ];		
						
			layout = new PaddedLayout( this ); 
			layout.bottom = 15;		
			layout.left = 15;
			layout.top = 15;
			layout.right = 15;
			
			layout = new VerticalLayout( layout );
			layout.verticalGap = 5;
			
			styleManager = new LatinStyle();
			styleManager.addEventListener( Event.COMPLETE, styleReady );
		}

		private function styleReady( event:Event ):void 
		{
			build();
			arrange();
		}		

		private function stateChange( event:UIElementEvent ):void 
		{
			if ( event.state.key == UIElementState.STATE_VISUAL_CLICK ) 
			{

			}
		}
	}
}
