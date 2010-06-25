package com.wezside.components.decorators.layout 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.IUIElement;

	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 * 
	 * A layout decorator to use a 9 point layout around an anchor:
	 * 		TOP_LEFT
	 *		TOP_CENTER
	 *		TOP_RIGHT
	 *		CENTER_LEFT
	 *		CENTER_RIGHT
	 *		CENTER
	 *		BOTTOM_LEFT
	 * 		BOTTOM_CENTER
	 *		BOTTOM_RIGHT
	 */
	public class RelativeLayout extends Layout 
	{

		private var _target:DisplayObject;
		private var _anchor:DisplayObject;		
		private var _originY:Number;
		private var _originX:Number;

		public function RelativeLayout( decorated:IUIDecorator )
		{
			super( decorated );			
		}
	
		override public function arrange():void 
		{				
			_anchor.x = 0;
			_anchor.y = 0;
			_target.x = 0;
			_target.y = 0;
						
			switch ( placementState.stateKey )
			{
				case PLACEMENT_CENTER:
					_target.x = _anchor.x + ( _anchor.width - _target.width ) * 0.5;
					_target.y = _anchor.y + ( _anchor.height - _target.height ) * 0.5;
					break;
				case PLACEMENT_CENTER_LEFT:
					_target.x = IUIElement( _target ).layout.left;
					_target.y = _anchor.y + ( _anchor.height - _target.height ) * 0.5;
					_anchor.x = _target.x + _target.width + IUIElement( _target ).layout.right;
					right = _target.x + _target.width + IUIElement( _target ).layout.right;					
					break;
				case PLACEMENT_CENTER_RIGHT:
					_target.x = _anchor.x + _anchor.width + IUIElement( _target ).layout.left;	
					_target.y = _anchor.y + ( _anchor.height - _target.height ) * 0.5;
					right = _target.width + IUIElement( _target ).layout.left + IUIElement( _target ).layout.right;
					break;
				case PLACEMENT_TOP_CENTER:
					_target.x = _anchor.x + ( _anchor.width - _target.width ) * 0.5;
					_target.y = IUIElement( _target ).layout.top;
					_anchor.y = _target.y + _target.height + IUIElement( _target ).layout.bottom;
					bottom = _target.height + IUIElement( _target ).layout.top + IUIElement( _target ).layout.bottom;
					break;
				case PLACEMENT_TOP_LEFT:
					_target.x = IUIElement( _target ).layout.left;
					_target.y = IUIElement( _target ).layout.top;
					_anchor.x = _target.x + _target.width + IUIElement( _target ).layout.right;
					right = _target.width + IUIElement( _target ).layout.left + IUIElement( _target ).layout.right;
					break;
				case PLACEMENT_TOP_RIGHT:
					_target.x = _anchor.x + _anchor.width + IUIElement( _target ).layout.left;
					_target.y = IUIElement( _target ).layout.top;
					right = _target.width + IUIElement( _target ).layout.left + IUIElement( _target ).layout.right;
					break;
				case PLACEMENT_BOTTOM_CENTER:
					_target.x = _anchor.x + ( _anchor.width - _target.width ) * 0.5;
					_target.y = _anchor.y + _anchor.height + IUIElement( _target ).layout.top;
					bottom = _target.height + IUIElement( _target ).layout.top +  + IUIElement( _target ).layout.bottom;
					break;
				case PLACEMENT_BOTTOM_LEFT:
					_target.x = IUIElement( _target ).layout.left;
					_target.y = _anchor.height - _target.height - IUIElement( _target ).layout.bottom;
					_anchor.x = _target.x + _target.width + IUIElement( _target ).layout.right;
					right = _target.width + IUIElement( _target ).layout.left + IUIElement( _target ).layout.right;
					break;
				case PLACEMENT_BOTTOM_RIGHT:
					_target.x = _anchor.x + _anchor.width + IUIElement( _target ).layout.left;
					_target.y = _anchor.height - _target.height - IUIElement( _target ).layout.bottom;
					right = _target.width + IUIElement( _target ).layout.left + IUIElement( _target ).layout.right;
					break;
			}
			super.arrange( );
		}
		
		public function get target():DisplayObject
		{
			return _target;
		}
		
		public function set target( value:DisplayObject ):void
		{
			_target = value;
		}

		public function get anchor():DisplayObject
		{
			return _anchor;
		}
		
		public function set anchor( value:DisplayObject ):void
		{
			_anchor = value;
			_originX = _anchor.x;
			_originY = _anchor.y;			
		}
		
		override public function reset():void 
		{
			super.reset( );
			if ( _anchor )
			{
				_anchor.x = _originX;	
				_anchor.y = _originY;				
			}
		}
	}
}
