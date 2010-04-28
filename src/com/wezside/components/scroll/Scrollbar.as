package com.wezside.components.scroll 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	import com.wezside.components.UIElement;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Scrollbar extends UIElement
	{
		private var _thumb:DisplayObjectContainer;
		private var _trackHeight:Number;
		
		private var yMax:Number;
		private var yMin:int;
		private var yOffset:Number;

		
		public function Scrollbar()
		{
			yMin = 0;
			yMax = _trackHeight - _thumb.height;
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown );			
			stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp );			
		}
		
		private function thumbUp( event:MouseEvent ):void
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, thumbMove );	
		}

		private function thumbDown( event:MouseEvent ):void
		{
			stage.addEventListener( MouseEvent.MOUSE_MOVE, thumbMove );
			yOffset = mouseY - _thumb.y;
		}

		private function thumbMove( event:MouseEvent ):void 
		{
			_thumb.y = mouseY - yOffset;
			if ( _thumb.y <= yMin ) _thumb.y = yMin;
			if ( _thumb.y >= yMax ) _thumb.y = yMax;
			
			var sp:Number = _thumb.y / yMax;
			dispatchEvent( new ScrollEvent( ScrollEvent.CHANGE, false, false, sp ));			
			event.updateAfterEvent();
		}
		
		
	}
}
