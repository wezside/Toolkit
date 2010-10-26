package com.wezside.components.decorators.layout 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.IUIElement;

	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

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
			
			var targetPaddingLeft:Number = _target is IUIElement ? IUIElement( _target ).layout.left : 0;
			var targetPaddingRight:Number = _target is IUIElement ? IUIElement( _target ).layout.right : 0;
			var targetPaddingTop:Number = _target is IUIElement ? IUIElement( _target ).layout.top : 0;
			var targetPaddingBottom:Number = _target is IUIElement ? IUIElement( _target ).layout.bottom : 0;

			var targetRect:Rectangle = new Rectangle( 0, 0, _target.width + targetPaddingLeft + targetPaddingRight, _target.height + targetPaddingTop + targetPaddingBottom );
			var anchorRect:Rectangle = new Rectangle( 0, 0, _anchor.width + left + right, _anchor.height + top + bottom );
			
			var maxW:Number = 0;
			var maxH:Number = 0;			
			
			switch ( placementState.stateKey )
			{
				case PLACEMENT_CENTER:
				case PLACEMENT_CENTER_LEFT:
				case PLACEMENT_CENTER_RIGHT:
				case PLACEMENT_TOP_CENTER:
				case PLACEMENT_BOTTOM_CENTER:
					maxW = Math.max( targetRect.width, anchorRect.width );
					maxH = Math.max( targetRect.height, anchorRect.height );
					break;
				case PLACEMENT_TOP_LEFT:
				case PLACEMENT_TOP_RIGHT:
				case PLACEMENT_BOTTOM_LEFT:
				case PLACEMENT_BOTTOM_RIGHT:
					maxW = targetRect.width + anchorRect.width;
					maxH = targetRect.height + anchorRect.height;
					break;
			}
			
			switch ( placementState.stateKey )
			{
				case PLACEMENT_CENTER:
				
					// align correctly relative to each other
					_target.x = ( maxW - _target.width ) * 0.5;
					_target.y = ( maxH - _target.height ) * 0.5;					
					_anchor.x = ( maxW - _anchor.width ) * 0.5;
					_anchor.y = ( maxH - _anchor.height ) * 0.5;
					
					// set width and height
					width = maxW;
					height = maxH;
					break;
					
				case PLACEMENT_TOP_CENTER:				
					_target.x = ( maxW - _target.width ) * 0.5;
					_target.y = targetPaddingTop;					
					_anchor.x = ( maxW - _anchor.width ) * 0.5;
					_anchor.y = _target.y + _target.height + targetPaddingBottom + top;				
					width = maxW;
					height =  _anchor.y + _anchor.height + bottom;
					break;
					
				case PLACEMENT_BOTTOM_CENTER:
					_anchor.x = ( maxW - _anchor.width ) * 0.5;
					_anchor.y = top;
					_target.x = ( maxW - _target.width ) * 0.5;
					_target.y = _anchor.y + _anchor.height + targetPaddingTop + bottom;
					width = maxW;
					height =  _target.y + _target.height + targetPaddingBottom;
					break;

				case PLACEMENT_CENTER_LEFT:
					_target.x = targetPaddingLeft;
					_target.y = ( maxH - _target.height ) * 0.5;
					_anchor.x = _target.x + _target.width + targetPaddingRight + left;
					_anchor.y = ( maxH - _anchor.height ) * 0.5;					
					width = _anchor.x + _anchor.width + right;
					height = maxH;
					break;
					
				case PLACEMENT_CENTER_RIGHT:				
					_anchor.x = left;
					_anchor.y = ( maxH - _anchor.height ) * 0.5;
					_target.x = _anchor.x + _anchor.width + right + targetPaddingLeft;
					_target.y = ( maxH - _target.height ) * 0.5;
					width = _target.x + _target.width + targetPaddingRight;
					height = maxH;				
					break;					
					
				case PLACEMENT_TOP_RIGHT:				
					_anchor.x = left;					
					_target.x = _anchor.x + _anchor.width + right + targetPaddingLeft;
					_target.y = targetPaddingTop;
					_anchor.y = _target.y + _target.height + targetPaddingBottom + top;					
					width = maxW;
					height = maxH;				
					break;
					
				case PLACEMENT_TOP_LEFT:
					_target.x = targetPaddingLeft;
					_target.y = targetPaddingTop;					
					_anchor.x = _target.x + _target.width + targetPaddingRight + left;
					_anchor.y = _target.y + _target.height + targetPaddingBottom + top;				
					width = maxW;
					height = maxH;				
					break;
					
				case PLACEMENT_BOTTOM_LEFT:				
					_anchor.y = top;
					_target.x = targetPaddingLeft;					
					_target.y = _anchor.y + _anchor.height + targetPaddingTop + bottom;
					_anchor.x = _target.x + _target.width + targetPaddingRight + left;				
					width = maxW;
					height = maxH;				
					break;

				case PLACEMENT_BOTTOM_RIGHT:				
					_anchor.x = left;
					_anchor.y = top;
					_target.x = _anchor.x + _anchor.width + right + targetPaddingLeft;
					_target.y = _anchor.y + _anchor.height + bottom + targetPaddingTop;				
					width = maxW;
					height = maxH;				
					break;
			}
			
			// enforce LEFT padding
			if ( _anchor.x < left ) _anchor.x = left;
			if ( _target.x < targetPaddingLeft ) _target.x = targetPaddingLeft;
			
			// enforce TOP padding
			if ( _anchor.y < top ) _anchor.y = top;
			if ( _target.y < targetPaddingTop ) _target.y = targetPaddingTop;
			
			// enforce RIGHT padding
			if ( _anchor.x > width - right - _anchor.width ) _anchor.x = width - right - _anchor.width;
			if ( _target.x > width - targetPaddingRight - _target.width ) _target.x = width - targetPaddingRight - _target.width;
			
			// enforce BOTTOM padding
			if ( _anchor.y > height - bottom - _anchor.height ) _anchor.y = height - bottom - _anchor.height;
			if ( _target.y > height - targetPaddingBottom - _target.height ) _target.y = height - targetPaddingBottom - _target.height;
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
