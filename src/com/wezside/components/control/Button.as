package com.wezside.components.control 
{
	import com.wezside.components.layout.PaddedLayout;
	import com.wezside.components.UIElement;
	import com.wezside.components.text.Label;
	import com.wezside.utilities.manager.state.StateManager;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Button extends Label 
	{
		
		private static const ICON_PLACEMENT_TOP:String = "iconPlacementTop";
		private static const ICON_PLACEMENT_LEFT:String = "iconPlacementLeft";
		private static const ICON_PLACEMENT_RIGHT:String = "iconPlacementRight";
		private static const ICON_PLACEMENT_CENTER:String = "iconPlacementCenter";
		private static const ICON_PLACEMENT_BOTTOM:String = "iconPlacementBottom";

		private var _id:String;
		private var _icon:UIElement;
		private var _iconAlign:StateManager;

		public function Button()
		{
			super( );
			_icon = new Icon();
			_icon.debug = true;
			_icon.layout = new PaddedLayout( _icon.layout );
			addChild( _icon );	
			_iconAlign = new StateManager();
			_iconAlign.addState( ICON_PLACEMENT_LEFT, true );
			_iconAlign.addState( ICON_PLACEMENT_RIGHT, true );
			_iconAlign.addState( ICON_PLACEMENT_CENTER, true );
			_iconAlign.addState( ICON_PLACEMENT_BOTTOM, true );
			_iconAlign.addState( ICON_PLACEMENT_TOP, true );
			_iconAlign.stateKey = ICON_PLACEMENT_LEFT;
		}
	
		override public function build():void 
		{
			super.build( );
			_icon.build();
			_icon.setStyle();
		}

		override public function arrange():void 
		{	
			
			// Add the Icon's padding to the total left padding if Icon is aligned left
			layout.left += _icon.width + _icon.layout.left + _icon.layout.right;
			
			// Arrange the Label component to adjust the text field width and height based on the text
			super.arrange( ); 
									
			// Custom arrange for icon UIElement
			_icon.x = field.x - _icon.width - _icon.layout.right;
			_icon.y = field.y + ( field.height - _icon.height ) * 0.5;			

			var skinWidth:int = int( field.width + layout.left + layout.right + _icon.layout.left + _icon.layout.right );
			var skinHeight:int = int( field.height + layout.top + layout.bottom);
			skin.setSize( skinWidth, skinHeight );
						 
		}
		
		override public function set state( value:String ):void 
		{
			super.state = value;
			_icon.state = value;
		}

		public function get icon():UIElement
		{
			return _icon;
		}
		
		public function set icon( value:UIElement ):void
		{
			_icon = value;
		}
		
		public function get iconStyleName():String
		{
			return _icon.styleName;
		}
		
		public function set iconStyleName( value:String ):void
		{
			_icon.styleName = value;
			_icon.styleManager = styleManager;
		}				
		
		public function get iconAlign():String
		{
			return _iconAlign.stateKey;
		}
		
		public function set iconAlign( value:String ):void
		{
			_iconAlign.stateKey = value;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
	}
}

