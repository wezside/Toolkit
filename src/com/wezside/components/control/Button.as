package com.wezside.components.control 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.layout.PaddedLayout;
	import com.wezside.components.text.Label;
	import com.wezside.utilities.manager.state.StateManager;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Button extends UIElement 
	{
		
		private static const ICON_PLACEMENT_LEFT:String = "ICON_PLACEMENT_LEFT";
		private static const ICON_PLACEMENT_RIGHT:String = "ICON_PLACEMENT_RIGHT";
		private static const ICON_PLACEMENT_CENTER:String = "ICON_PLACEMENT_CENTER";
		private static const ICON_PLACEMENT_BOTTOM:String = "ICON_PLACEMENT_BOTTOM";
		private static const ICON_PLACEMENT_TOP:String = "ICON_PLACEMENT_TOP";

		private var _label:Label;
		private var _icon:UIElement;
		private var iconAlign:StateManager;

		public function Button()
		{
			super( );
			layout = new PaddedLayout( this );
			_label = new Label();
			addChild( _label );		
			
			_icon = new UIElement();
			addChild( _icon );	
			iconAlign = new StateManager();
			iconAlign.addState( ICON_PLACEMENT_LEFT, true );
			iconAlign.addState( ICON_PLACEMENT_RIGHT, true );
			iconAlign.addState( ICON_PLACEMENT_CENTER, true );
			iconAlign.addState( ICON_PLACEMENT_BOTTOM, true );
			iconAlign.addState( ICON_PLACEMENT_TOP, true );
			iconAlign.stateKey = ICON_PLACEMENT_LEFT;
		}

		override public function build():void 
		{
			super.build( );
			_label.layout = new PaddedLayout( _label );
			_label.build();
			if ( _label.styleManager ) _label.setStyle();
			_label.arrange();					
		}
		
		override public function set state( value:String ):void 
		{
			super.state = value;
			_label.state = value;
		}		
		
		override public function arrange():void 
		{		
			var skinWidth:int = int( _label.width + layout.left + layout.right );
			var skinHeight:int = int( _label.height + layout.top + layout.bottom );
			skin.setSize( skinWidth, skinHeight );
			
			// Center icon on y-axis and x-axis
			_icon.x = - _icon.width;
			_icon.y = ( skinHeight - _icon.height ) * 0.5;
			
			if ( iconAlign.compare( ICON_PLACEMENT_RIGHT ))
			{
				_icon.x = skinWidth;
			}
			
			if ( iconAlign.compare( ICON_PLACEMENT_CENTER ))
			{
				_icon.x = ( skinWidth  - _icon.width ) * 0.5;
			}
			
			if ( iconAlign.compare( ICON_PLACEMENT_TOP ))
			{
				_icon.y = - _icon.height;
			}
			
			if ( iconAlign.compare( ICON_PLACEMENT_BOTTOM ))
			{
				_icon.y = - _icon.height;
			}			
			
			super.arrange( );				
		}
		
		override public function activate():void 
		{
			interactive.activate();
		}
		
		override public function deactivate():void 
		{
			interactive.deactivate();
		}

		public function get label():Label
		{
			return _label;
		}
		
		public function set label( value:Label ):void
		{
			_label = value;
		}

		public function get labelStyleName():String
		{
			return _label.styleName;
		}
		
		public function set labelStyleName( value:String ):void
		{
			_label.styleName = value;
			_label.styleManager = styleManager;
		}

		public function get text():String
		{
			return _label.text;
		}
		
		public function set text( value:String ):void
		{
			_label.text = value;
			_label.mouseChildren = false;
		}
		
		public function get labelWidth():int
		{
			return _label.width;
		}
		
		public function set labelWidth( value:int ):void
		{
			_label.width = value;
		}
		
		public function get labelHeight():int
		{
			return _label.height;
		}
		
		public function set labelHeight( value:int ):void
		{
			_label.height = value;
		}

		public function get paddingLeft():int
		{
			return layout.left;
		}
		
		public function set paddingLeft( value:int ):void
		{
			layout.left = value;
		}
		
		public function get paddingRight():int
		{
			return layout.right;
		}
		
		public function set paddingRight( value:int ):void
		{
			layout.right = value;
		}
		
		public function get paddingTop():int
		{
			return layout.top;
		}
		
		public function set paddingTop( value:int ):void
		{
			layout.top = value;
		}
		
		public function get paddingBottom():int
		{
			return layout.bottom;
		}
		
		public function set paddingBottom( value:int ):void
		{
			layout.bottom = value;
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
	}
}
