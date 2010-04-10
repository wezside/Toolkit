package com.wezside.components 
{


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

		// Visual States
		public static const STATE_VISUAL_UP:String = "stateVisualUp";
		public static const STATE_VISUAL_OVER:String = "stateVisualOver";
		public static const STATE_VISUAL_DOWN:String = "stateVisualDown";
		public static const STATE_VISUAL_SELECTED:String = "stateVisualSelected";
		public static const STATE_VISUAL_INVALID:String = "stateVisualInvalid";
		public static const STATE_VISUAL_DISABLED:String = "stateVisualDisabled";		


		public function setSkin( visibleStates:Array ):void
		{
			reset();
			for ( var i:int = 0; i < visibleStates.length; ++i )
			{ 
				switch ( visibleStates[i] )
				{
					case STATE_VISUAL_UP: if ( _upSkin ) show( _upSkin ); break; 
					case STATE_VISUAL_OVER: if ( _overSkin ) show( _overSkin ); break; 
					case STATE_VISUAL_DOWN: if ( _downSkin ) show( _downSkin ); break; 
					case STATE_VISUAL_SELECTED: if ( _selectedSkin ) show( _selectedSkin );	break;												 
					case STATE_VISUAL_INVALID: if ( _selectedSkin ) show( _invalidSkin ); break;											    
					case STATE_VISUAL_DISABLED: if ( _disabledSkin ) show( _disabledSkin ); break; 
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
	}
}
