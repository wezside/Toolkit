package com.wezside.components 
{
	import com.wezside.components.decorators.layout.PaddedLayout;
	import com.wezside.utilities.manager.style.IStyleManager;

	import flash.text.StyleSheet;

	import com.wezside.components.decorators.shape.IShape;
	import com.wezside.components.decorators.layout.ILayout;
	import com.wezside.data.iterator.IIterator;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class UIElementSkin extends Sprite implements IUIElementSkin 
	{
		
		private var _upSkin:DisplayObject;
		private var _overSkin:DisplayObject;
		private var _downSkin:DisplayObject;
		private var _selectedSkin:DisplayObject;
		private var _invalidSkin:DisplayObject;
		private var _disabledSkin:DisplayObject;
		private var _layout:ILayout;

		public function UIElementSkin() 
		{
			layout = new PaddedLayout( this );	
		}

		public function setSkin( visibleStates:Array ):void
		{
			reset();
			for ( var i:int = 0; i < visibleStates.length; ++i )
			{ 
				switch ( visibleStates[i] )
				{
					case UIElementState.STATE_VISUAL_CLICK: 
					case UIElementState.STATE_VISUAL_UP: if ( _upSkin ) show( _upSkin ); break; 
					case UIElementState.STATE_VISUAL_OVER: if ( _overSkin ) show( _overSkin ); break; 
					case UIElementState.STATE_VISUAL_DOWN: if ( _downSkin ) show( _downSkin ); break; 
					case UIElementState.STATE_VISUAL_SELECTED: if ( _selectedSkin ) show( _selectedSkin );	break;												 
					case UIElementState.STATE_VISUAL_INVALID: if ( _invalidSkin ) show( _invalidSkin ); break;											    
					case UIElementState.STATE_VISUAL_DISABLED: if ( _disabledSkin ) show( _disabledSkin ); break; 
				}				
			}			
		}

		public function show( stateSkin:DisplayObject ):void
		{
			stateSkin.visible = true;
		}

		public function hide( stateSkin:DisplayObject ):void
		{
			stateSkin.visible = false;
		}

		public function reset():void
		{
			 if ( _upSkin ) hide( _upSkin );
			 if ( _overSkin ) hide( _overSkin );
			 if ( _downSkin ) hide( _downSkin );
			 if ( _selectedSkin ) hide( _selectedSkin );
			 if ( _invalidSkin ) hide( _invalidSkin );
			 if ( _disabledSkin ) hide( _disabledSkin );			
		}
		
		public function setSize( w:int, h:int ):void
		{
			for ( var i:int = 0; i < this.numChildren; ++i ) 
			{
				var skin:DisplayObject = getChildAt( i );
				skin.width = w;
				skin.height = h;
			}
		}

		public function hasSkinProperty( V:* = undefined ):Boolean
		{
			if ( V == "upSkin" ) return true;
			if ( V == "overSkin" ) return true;
			if ( V == "downSkin" ) return true;
			if ( V == "selectedSkin" ) return true;
			if ( V == "invalidSkin" ) return true;
			if ( V == "disabledSkin" ) return true;
			return false;
		}

		public function hasOwnProperty( V:* = undefined ):Boolean
		{			
			return super.hasOwnProperty( V );
		}
		
		public function get upSkin():DisplayObject
		{
			return _upSkin;
		}
		
		public function get overSkin():DisplayObject
		{
			return _overSkin;
		}
		
		public function get downSkin():DisplayObject
		{
			return _downSkin;
		}
		
		public function get selectedSkin():DisplayObject
		{
			return _selectedSkin;
		}
		
		public function get invalidSkin():DisplayObject
		{
			return _invalidSkin;
		}
		
		public function get disabledSkin():DisplayObject
		{
			return _disabledSkin;
		}
		
		public function set upSkin( value:DisplayObject ):void
		{
			_upSkin = value;
			_upSkin.visible = false;
			addChild( _upSkin );
		}
		
		public function set overSkin( value:DisplayObject ):void
		{
			_overSkin = value;
			_overSkin.visible = false;
			addChild( _overSkin );
		}
		
		public function set downSkin( value:DisplayObject ):void
		{
			_downSkin = value;
			_downSkin.visible = false;
			addChild( _downSkin );
		}
		
		public function set selectedSkin( value:DisplayObject ):void
		{
			_selectedSkin = value;
			_selectedSkin.visible = false;
			addChild( _selectedSkin );
		}
		
		public function set invalidSkin( value:DisplayObject ):void
		{
			_invalidSkin = value;
			_invalidSkin.visible = false;
			addChild( _invalidSkin );
		}
		
		public function set disabledSkin( value:DisplayObject ):void
		{
			_disabledSkin = value;
			_disabledSkin.visible = false;
			addChild( _disabledSkin );
		}
		
		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}
		
		public function build():void
		{
		}
		
		public function setStyle():void
		{
		}
		
		public function purge():void
		{
		}
		
		public function get styleManager():IStyleManager
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get styleName():String
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get styleSheet():StyleSheet
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get skin():IUIElementSkin
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get background():IShape
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get layout():ILayout
		{
			return _layout;
		}
		
		public function set styleManager(value:IStyleManager):void
		{
		}
		
		public function set styleName(value:String):void
		{
		}
		
		public function set styleSheet(value:StyleSheet):void
		{
		}
		
		public function set skin(value:IUIElementSkin):void
		{
		}
		
		public function set background(value:IShape):void
		{
		}
		
		public function set layout(value:ILayout):void
		{
			_layout = value;
		}
		
		public function iterator(type:String = null):IIterator
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function arrange():void
		{
		}
	}
}
