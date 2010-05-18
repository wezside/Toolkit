package com.wezside.components.control 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.text.Label;
	import com.wezside.utilities.manager.state.StateManager;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Button extends Label 
	{
		
		private static const ICON_PLACEMENT_LEFT:String = "ICON_PLACEMENT_LEFT";
		private static const ICON_PLACEMENT_RIGHT:String = "ICON_PLACEMENT_RIGHT";
		private static const ICON_PLACEMENT_CENTER:String = "ICON_PLACEMENT_CENTER";
		private static const ICON_PLACEMENT_BOTTOM:String = "ICON_PLACEMENT_BOTTOM";
		private static const ICON_PLACEMENT_TOP:String = "ICON_PLACEMENT_TOP";

		private var _id:String;
		private var _icon:UIElement;
		private var iconAlign:StateManager;

		public function Button()
		{
			super( );
			_icon = new UIElement();
			_icon.build();
			addChild( _icon );	
			iconAlign = new StateManager();
			iconAlign.addState( ICON_PLACEMENT_LEFT, true );
			iconAlign.addState( ICON_PLACEMENT_RIGHT, true );
			iconAlign.addState( ICON_PLACEMENT_CENTER, true );
			iconAlign.addState( ICON_PLACEMENT_BOTTOM, true );
			iconAlign.addState( ICON_PLACEMENT_TOP, true );
			iconAlign.stateKey = ICON_PLACEMENT_LEFT;
		}

		override public function arrange():void 
		{		
			var skinWidth:int = int( field.width + layout.left + layout.right );
			var skinHeight:int = int( field.height + layout.top + layout.bottom );
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

