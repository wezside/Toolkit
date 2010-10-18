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

		public function RelativeLayout( decorated:IUIDecorator )
		{
			super( decorated );			
		}
	
		override public function arrange():void 
		{		
			
			super.arrange();
				
			var diffW:Number = _anchor.width - _target.width;
			var diffH:Number = _anchor.height - _target.height;
			
			switch ( placementState.stateKey )
			{
				case PLACEMENT_CENTER:
					_anchor.x = left;
					_anchor.y = top;
					_target.x = _anchor.x + ( diffW ) * 0.5;
					_target.y = _anchor.y + ( diffH ) * 0.5;
					width = _anchor.x + _anchor.width + right;
					height = _anchor.y + _anchor.height + bottom;
					break;
					
				case PLACEMENT_CENTER_LEFT:
					_target.x += left;
					_anchor.y = top;					
					_target.y = _anchor.y + ( diffH  ) * 0.5;
					_anchor.x = _target.x + _target.width;
					width = _anchor.x + _anchor.width + right;
					height = _anchor.y + _anchor.height + bottom;
					break;
					
				case PLACEMENT_CENTER_RIGHT:
					_anchor.x = left;
					_anchor.y = top;
					_target.x = _anchor.x + _anchor.width;
					_target.y = _anchor.y + ( diffH ) * 0.5;
					width = _anchor.x + _anchor.width + _target.width + right;
					height = _anchor.y + _anchor.height + bottom;
					break;
					
				case PLACEMENT_TOP_CENTER:
					_target.x = _anchor.x + ( diffW ) * 0.5;
					_target.y = top;
					_anchor.x = left;
					_anchor.y = _target.y + _target.height;
					width = _anchor.x + _anchor.width + right;
					height = _target.y +_target.height + _anchor.height + bottom;
					break;
					
				case PLACEMENT_TOP_RIGHT:
				    _anchor.x = left;
				    _anchor.y = _target.y + _target.height;
					_target.x = _anchor.x + _anchor.width;
					_target.y = top;
					width = _anchor.x + _anchor.width + _target.width + right;
					height = _anchor.y + _anchor.height + bottom;
					break;
					
				case PLACEMENT_TOP_LEFT:
					_target.x = left;
					_target.y = top;
					_anchor.x = _target.x + _target.width;
					_anchor.y = _target.y + _target.height;
					width = _anchor.x + _anchor.width + right;
					height = _anchor.y + _anchor.height + bottom;
					break;
					
				case PLACEMENT_BOTTOM_CENTER:
					_anchor.x = left;
					_anchor.y = top;
					_target.x = _anchor.x + ( diffW ) * 0.5;
					_target.y = _anchor.y + _anchor.height;
					width = _anchor.x + _anchor.width + right;
					height = _target.y + _target.height + bottom;
					break;

				case PLACEMENT_BOTTOM_LEFT:
					_target.x = left;
					_target.y = _anchor.y + _anchor.height;
					_anchor.x = _target.x + _target.width;
					_anchor.y = top;
					width = _anchor.x + _anchor.width + right;
					height = _target.y + _target.height + bottom;
					break;

				case PLACEMENT_BOTTOM_RIGHT:
					_anchor.x = left;
					_anchor.y = top;
					_target.x = _anchor.x + _anchor.width;
					_target.y = _anchor.y + _anchor.height;
					width = _target.x + _target.width + right;
					height = _target.y + _target.height + bottom;
					break;
			}
			
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
		}
	}
}
