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
		
		public static const ICON_PLACEMENT_TOP_LEFT:String = "iconPlacementTopLeft";
		public static const ICON_PLACEMENT_TOP_CENTER:String = "iconPlacementTopCenter";
		public static const ICON_PLACEMENT_TOP_RIGHT:String = "iconPlacementTopRight";
		
		public static const ICON_PLACEMENT_CENTER_LEFT:String = "iconPlacementCenterLeft";
		public static const ICON_PLACEMENT_CENTER_RIGHT:String = "iconPlacementCenterRight";
		public static const ICON_PLACEMENT_CENTER:String = "iconPlacementCenter";
		
		public static const ICON_PLACEMENT_BOTTOM_LEFT:String = "iconPlacementBottomLeft";
		public static const ICON_PLACEMENT_BOTTOM_CENTER:String = "iconPlacementBottomCenter";
		public static const ICON_PLACEMENT_BOTTOM_RIGHT:String = "iconPlacementBottomRight";


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
			_iconAlign.addState( ICON_PLACEMENT_TOP_LEFT );
			_iconAlign.addState( ICON_PLACEMENT_TOP_CENTER );
			_iconAlign.addState( ICON_PLACEMENT_TOP_RIGHT );
			_iconAlign.addState( ICON_PLACEMENT_CENTER_LEFT );
			_iconAlign.addState( ICON_PLACEMENT_CENTER_RIGHT );
			_iconAlign.addState( ICON_PLACEMENT_CENTER );
			_iconAlign.addState( ICON_PLACEMENT_BOTTOM_LEFT );
			_iconAlign.addState( ICON_PLACEMENT_BOTTOM_CENTER );
			_iconAlign.addState( ICON_PLACEMENT_BOTTOM_RIGHT );

		}
	
		override public function build():void 
		{
			super.build( );
			_icon.build();
			_icon.setStyle();
		}

		override public function arrange():void 
		{	
			
			// Copy the icon width + height to the Button's padding decorator properties
			switch ( _iconAlign.stateKey )
			{
				case ICON_PLACEMENT_TOP_CENTER:
					layout.top += _icon.height + _icon.layout.top + _icon.layout.bottom;
					break;
					
				case ICON_PLACEMENT_BOTTOM_CENTER:
					layout.bottom += _icon.height + _icon.layout.top + _icon.layout.bottom;
					break;
				
				case ICON_PLACEMENT_TOP_RIGHT:
				case ICON_PLACEMENT_CENTER_RIGHT:
				case ICON_PLACEMENT_BOTTOM_RIGHT:
					layout.right += _icon.width + _icon.layout.left + _icon.layout.right;
					break;
				
				case ICON_PLACEMENT_TOP_LEFT:
				case ICON_PLACEMENT_CENTER_LEFT:
				case ICON_PLACEMENT_BOTTOM_LEFT:
					layout.left += _icon.width + _icon.layout.left + _icon.layout.right;
					break;								
			}
			
			// Arrange the Label component to adjust the text field width and height based on the text
			super.arrange( ); 		
			
			switch ( _iconAlign.stateKey )
			{	
				case ICON_PLACEMENT_TOP_CENTER:
					_icon.x = field.x + ( field.width - _icon.width ) * 0.5;
					_icon.y = field.y - _icon.height - _icon.layout.bottom;
					break;					
				case ICON_PLACEMENT_BOTTOM_CENTER:
					_icon.x = field.x + ( field.width - _icon.width ) * 0.5;
					_icon.y = field.y + field.height + _icon.layout.top;
					break;					
				case ICON_PLACEMENT_TOP_RIGHT:
					_icon.x = field.x + field.width;
					_icon.y = field.y;
					break;
				case ICON_PLACEMENT_CENTER_RIGHT:
					_icon.x = field.x + field.width + _icon.layout.left;
					_icon.y = field.y + ( field.height - _icon.height ) * 0.5;
					break;
				case ICON_PLACEMENT_BOTTOM_RIGHT:
					_icon.x = field.x + field.width;
					_icon.y = field.y + field.height - _icon.height;
					break;
				case ICON_PLACEMENT_TOP_LEFT:
					_icon.x = field.x - _icon.width;
					_icon.y = field.y;
					break;
				case ICON_PLACEMENT_CENTER_LEFT:
					_icon.x = field.x - _icon.width - _icon.layout.right;
					_icon.y = field.y + ( field.height - _icon.height ) * 0.5;
					break;
				case ICON_PLACEMENT_BOTTOM_LEFT:
					_icon.x = field.x - _icon.width;
					_icon.y = field.y + field.height - _icon.height;
					break;
				default:
					_icon.x = field.x + ( field.width - _icon.width ) * 0.5;
					_icon.y = field.y + ( field.height - _icon.height ) * 0.5;
					break;
			}			
			
			var skinWidth:int = int( field.width + layout.left + layout.right );
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

