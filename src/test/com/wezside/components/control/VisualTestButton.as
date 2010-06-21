package test.com.wezside.components.control 
{
	import com.wezside.components.decorators.layout.HorizontalLayout;
	import com.wezside.components.UIElementSkin;
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
			label.width = 500;
			label.selectable = false;
			label.build();
			label.setStyle();
			label.arrange();
			addChild( label );		
				
			label = new Label();
			label.text = "com.wezside.components.control.Button";
			label.styleName = "packageLabelButton";
			label.styleManager = styleManager;
			label.width = 500;
			label.selectable = false;
			label.build();
			label.setStyle();
			label.arrange();
			addChild( label );			
			
			var hbox:UIElement = new UIElement();
			hbox.layout = new HorizontalLayout( hbox );
			hbox.layout.horizontalGap = 10;
			hbox.layout = new PaddedLayout( hbox.layout );
			hbox.layout.top = 20;
			hbox.background = new Rectangle( hbox );
			hbox.background.alphas = [ 0 ];
			hbox.background.colours = [ 0 ]; 
						
			autoSkinSizeButton = new Button( );
			autoSkinSizeButton.interactive = new InteractiveSelectable( autoSkinSizeButton );
			autoSkinSizeButton.styleName = "button";
			autoSkinSizeButton.styleManager = styleManager;
			autoSkinSizeButton.text = "AutoSizeSkin Off";
			autoSkinSizeButton.build();
			autoSkinSizeButton.setStyle();
			autoSkinSizeButton.arrange();
			autoSkinSizeButton.activate( );
			autoSkinSizeButton.addEventListener( UIElementEvent.STATE_CHANGE, autoSkinSizeHandler );
			addChild( autoSkinSizeButton );			
			
			hbox.addChild( createAlignButton( "Top Left" ));
			hbox.addChild( createAlignButton( "Center Left" ));
			hbox.addChild( createAlignButton( "Bottom Left" ));
			hbox.build();
			hbox.arrange();
			addChild( hbox );
			
			hbox = new UIElement();
			hbox.layout = new HorizontalLayout( hbox );
			hbox.layout.horizontalGap = 10;
			hbox.layout = new PaddedLayout( hbox.layout );
			hbox.layout.top = 2;
			hbox.layout.bottom = 20;
			hbox.background = new Rectangle( hbox );
			hbox.background.alphas = [ 0 ];
			hbox.background.colours = [ 0 ]; 
			hbox.addChild( createAlignButton( "Top Right" ));
			hbox.addChild( createAlignButton( "Center Right" ));
			hbox.addChild( createAlignButton( "Bottom Right" ));
			hbox.build();
			hbox.arrange();
			addChild( hbox );

			
			button = new Button();
			button.interactive = new InteractiveSelectable( button );
			button.addEventListener( UIElementEvent.STATE_CHANGE, stateChange );
			button.styleManager = styleManager;
			button.styleName = "button";
			button.text = "Lorem ipsum dolor sit amet, nunc a nonummy nec, nulla nibh sed class, sed duis suspendisse.Lorem ipsum dolor sit amet, nunc a nonummy nec, nulla nibh sed class, sed duis suspendisse.";
			button.width = 300;
			button.iconStyleName = "iconStylename";
			button.iconPlacement = Layout.PLACEMENT_CENTER_LEFT;
			button.autoSkinSize = false;
			button.build();
			button.setStyle();
			button.arrange();		
			addChild( button );
			button.activate();
						
			x = 20;
			y = 20;
		
			super.build();
		}

		private function createAlignButton( text:String ):UIElement
		{
			var iconAlignButton:Button = new Button( );
			iconAlignButton.styleName = "button";
			iconAlignButton.styleManager = styleManager;
			iconAlignButton.text = text;
			iconAlignButton.width = 100;
			iconAlignButton.build();
			iconAlignButton.setStyle();
			iconAlignButton.arrange();
			iconAlignButton.activate( );
			iconAlignButton.addEventListener( UIElementEvent.STATE_CHANGE, iconAlignButtonHandler );
			return iconAlignButton;
		}

		private function iconAlignButtonHandler( event:UIElementEvent ):void 
		{
			if ( event.state.key == UIElementState.STATE_VISUAL_CLICK ) 
			{
				switch ( event.currentTarget.text )
				{					
					case "Center Left": button.iconPlacement = Layout.PLACEMENT_CENTER_LEFT; break;
					case "Top Left": button.iconPlacement = Layout.PLACEMENT_TOP_LEFT; break;
					case "Bottom Left": button.iconPlacement = Layout.PLACEMENT_BOTTOM_LEFT; break;
					case "Top Right": button.iconPlacement = Layout.PLACEMENT_TOP_RIGHT; break;
					case "Center Right": button.iconPlacement = Layout.PLACEMENT_CENTER_RIGHT; break;
					case "Bottom Right": button.iconPlacement = Layout.PLACEMENT_BOTTOM_RIGHT; break;
				}
//				button.autoSkinSize = true;
				button.arrange();
			}			
		}

		private function autoSkinSizeHandler( event:UIElementEvent ):void 
		{
			if ( event.state.key == UIElementState.STATE_VISUAL_SELECTED ) 
			{ 
				button.autoSkinSize = event.currentTarget.stateManager.compare( UIElementState.STATE_VISUAL_SELECTED );
				button.arrange();
				event.target.text = "AutoSizeSkin On";
			}
			else
			{
				event.target.text = "AutoSizeSkin Off";
			}
		}

		
		private function stageInit( event:Event ):void 
		{			
			background = new Rectangle( this );
			background.colours = [ 0, 0 ];
			background.alphas = [ 0.01, 0.05 ];
			background.borderColor = 1;
			background.borderThickness = 1;
			background.borderAlpha = 1;
						
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
			if ( event.state.key == UIElementState.STATE_VISUAL_SELECTED ) 
			{
//				trace( event.currentTarget.stateManager.compare( event.state.key ));
			}
		}
	}
}
