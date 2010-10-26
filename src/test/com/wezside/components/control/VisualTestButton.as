package test.com.wezside.components.control 
{
	import test.com.wezside.sample.style.LatinStyle;

	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.UIElementState;
	import com.wezside.components.control.Button;
	import com.wezside.components.decorators.interactive.InteractiveSelectable;
	import com.wezside.components.decorators.layout.HorizontalLayout;
	import com.wezside.components.decorators.layout.Layout;
	import com.wezside.components.decorators.layout.PaddedLayout;
	import com.wezside.components.decorators.layout.VerticalLayout;
	import com.wezside.components.text.Label;

	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestButton extends UIElement 
	{
		
		private var button:Button;
		private var label:Label;
		private var autoSkinSizeButton:Button;

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
			label.selectable = false;
			label.build();
			label.setStyle();
			label.arrange();
			addChild( label );		
				
			var packageLabel:Label = new Label();
			packageLabel.text = "com.wezside.components.control.Button";
			packageLabel.styleName = "packageLabelButton";
			packageLabel.styleManager = styleManager;
			packageLabel.width = 400;
			packageLabel.selectable = false;
			packageLabel.build();
			packageLabel.setStyle();
			packageLabel.arrange();
			addChild( label );			
//			createPropertyButtons();

			button = new Button();
			button.interactive = new InteractiveSelectable( button );
			button.addEventListener( UIElementEvent.STATE_CHANGE, stateChange );
			button.styleManager = styleManager;
			button.styleName = "button";
			button.text = "Lorem ipsum doler et";
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_CENTER_RIGHT;
			button.autoSkinSize = true;
			button.build();
			button.setStyle();
			button.arrange();
			addChild( button );
			button.activate();
						
			x = 20;
			y = 20;
		
			super.build();
		}

		private function createPropertyButtons():void
		{
			var hbox:UIElement = new UIElement();
			hbox.layout = new HorizontalLayout( hbox );
			hbox.layout.horizontalGap = 10;
			hbox.layout = new PaddedLayout( hbox.layout );
			hbox.layout.top = 0;
						
			hbox.addChild( createAlignButton( "Top Left" ));
			hbox.addChild( createAlignButton( "Top Center" ));
			hbox.addChild( createAlignButton( "Top Right" ));
			hbox.build();
			hbox.arrange();
			addChild( hbox );
			
			hbox = new UIElement();
			hbox.layout = new HorizontalLayout( hbox );
			hbox.layout.horizontalGap = 10;
			hbox.layout = new PaddedLayout( hbox.layout );
			hbox.layout.top = 2;
			hbox.addChild( createAlignButton( "Center Left" ));
			hbox.addChild( createAlignButton( "Center" ));
			hbox.addChild( createAlignButton( "Center Right" ));
			hbox.build();
			hbox.arrange();
			addChild( hbox );
			
			hbox = new UIElement();
			hbox.layout = new HorizontalLayout( hbox );
			hbox.layout.horizontalGap = 10;
			hbox.layout = new PaddedLayout( hbox.layout );
			hbox.layout.top = 2;
			hbox.layout.bottom = 20;
			hbox.addChild( createAlignButton( "Bottom Left" ));
			hbox.addChild( createAlignButton( "Bottom Center" ));
			hbox.addChild( createAlignButton( "Bottom Right" ));
			hbox.build();
			hbox.arrange();
			addChild( hbox );
		}

		private function createAlignButton( text:String ):UIElement
		{
			var iconAlignButton:Button = new Button( );
			iconAlignButton.iconStyleName = "test";
			iconAlignButton.styleName = "alignButton";
			iconAlignButton.styleManager = styleManager;
			iconAlignButton.autoSkinSize = true;
			iconAlignButton.text = text;
			iconAlignButton.build();
			iconAlignButton.setStyle();
			iconAlignButton.arrange();
			iconAlignButton.activate();
			iconAlignButton.addEventListener( UIElementEvent.STATE_CHANGE, iconAlignButtonHandler );
			return iconAlignButton;
		}

		private function iconAlignButtonHandler( event:UIElementEvent ):void 
		{
			if ( event.state.key == UIElementState.STATE_VISUAL_CLICK ) 
			{
				switch ( event.currentTarget.text )
				{
					case "Top Right": button.iconPlacement = Layout.PLACEMENT_TOP_RIGHT; break;
					case "Top Center": button.iconPlacement = Layout.PLACEMENT_TOP_CENTER; break;
					case "Top Left": button.iconPlacement = Layout.PLACEMENT_TOP_LEFT; break;
					case "Bottom Left": button.iconPlacement = Layout.PLACEMENT_BOTTOM_LEFT; break;
					case "Bottom Right": button.iconPlacement = Layout.PLACEMENT_BOTTOM_RIGHT; break;
					case "Bottom Center": button.iconPlacement = Layout.PLACEMENT_BOTTOM_CENTER; break;
					case "Center Left": button.iconPlacement = Layout.PLACEMENT_CENTER_LEFT; break;
					case "Center": button.iconPlacement = Layout.PLACEMENT_CENTER; break;
					case "Center Right": button.iconPlacement = Layout.PLACEMENT_CENTER_RIGHT; break;
				}
				label.text = "Icon alignment " + event.currentTarget.text;
				button.arrange();
				arrange();
			}			
		}

		private function autoSkinSizeHandler( event:UIElementEvent ):void 
		{
			if ( event.state.key == UIElementState.STATE_VISUAL_SELECTED ) 
			{ 
				button.autoSkinSize = event.currentTarget.stateManager.compare( UIElementState.STATE_VISUAL_SELECTED );
				button.arrange();
				arrange();
				event.target.text = "AutoSizeSkin On";
			}
			else
			{
				event.target.text = "AutoSizeSkin Off";
			}
		}
		
		private function stageInit( event:Event ):void 
		{			
			layout = new VerticalLayout( this );
			layout.verticalGap = 10;						
			layout = new PaddedLayout( this.layout ); 
			layout.bottom = 15;		
			layout.left = 15;
			layout.top = 15;
			layout.right = 15;			
			
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
			if ( event.state.key == UIElementState.STATE_VISUAL_SELECTED ) 
			{
//				trace( event.currentTarget.stateManager.compare( event.state.key ));
			}
		}
	}
}
