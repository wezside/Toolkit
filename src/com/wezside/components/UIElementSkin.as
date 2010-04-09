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
		
		private var _up:DisplayObject;
		private var _over:DisplayObject;
		private var _down:DisplayObject;
		private var _selected:DisplayObject;
		private var _invalid:DisplayObject;
		private var _disabled:DisplayObject;

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
					case STATE_VISUAL_UP: if ( _up ) show( _up ); break; 
					case STATE_VISUAL_OVER: if ( _over ) show( _over ); break; 
					case STATE_VISUAL_DOWN: if ( _down ) show( _down ); break; 
					case STATE_VISUAL_SELECTED: if ( _selected ) show( _selected );	break;												 
					case STATE_VISUAL_INVALID: if ( _selected ) show( _invalid ); break;											    
					case STATE_VISUAL_DISABLED: if ( _disabled ) show( _disabled ); break; 
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
			 if ( _up ) hide( _up );
			 if ( _over ) hide( _over );
			 if ( _down ) hide( _down );
			 if ( _selected ) hide( _selected );
			 if ( _invalid ) hide( _invalid );
			 if ( _disabled ) hide( _disabled );			
		}

		public function hasOwnProperty( V:* = undefined ):Boolean
		{
			return super.hasOwnProperty( V );
		}
		
		public function get up():DisplayObject
		{
			return _up;
		}
		
		public function get over():DisplayObject
		{
			return _over;
		}
		
		public function get down():DisplayObject
		{
			return _down;
		}
		
		public function get selected():DisplayObject
		{
			return _selected;
		}
		
		public function get invalid():DisplayObject
		{
			return _invalid;
		}
		
		public function get disabled():DisplayObject
		{
			return _disabled;
		}
		
		public function set up(value:DisplayObject):void
		{
			_up = value;
			_up.visible = false;
			addChild( _up );
		}
		
		public function set over(value:DisplayObject):void
		{
			_over = value;
			_over.visible = false;
			addChild( _over );
		}
		
		public function set down(value:DisplayObject):void
		{
			_down = value;
			_down.visible = false;
			addChild( _down );
		}
		
		public function set selected(value:DisplayObject):void
		{
			_selected = value;
			_selected.visible = false;
			addChild( _selected );
		}
		
		public function set invalid(value:DisplayObject):void
		{
			_invalid = value;
			_invalid.visible = false;
			addChild( _invalid );
		}
		
		public function set disabled(value:DisplayObject):void
		{
			_disabled = value;
			_disabled.visible = false;
			addChild( _disabled );
		}
		
		override public function toString():String 
		{
			return getQualifiedClassName( this );
		}
	}
}
