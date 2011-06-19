package com.wezside.component.decorator.layout {
	import com.wezside.component.IUIDecorator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class CenterOffsetLayout extends Layout {
		
		private var _stageWidth 	: Number = 0;
		private var _stageHeight 	: Number = 0;		private var _xOffset 		: Number = 0;		private var _yOffset 		: Number = 0;
		
		
		public function CenterOffsetLayout( decorated : IUIDecorator ) {
			super( decorated );
		}
		
		override public function arrange() : void {
			
			x = int( ( stageWidth - width ) * .5 ) + _xOffset;
			y = int( ( stageHeight - height ) * .5 ) + _yOffset;
			
			super.arrange();
		}
		
		public function get stageWidth() : Number {
			return _stageWidth;
		}
		
		public function set stageWidth( value : Number ) : void {
			_stageWidth = value;
		}
		
		public function get stageHeight() : Number {
			return _stageHeight;
		}
		
		public function set stageHeight( value : Number ) : void {
			_stageHeight = value;
		}
		
		public function get xOffset() : Number {
			return _xOffset;
		}
		
		public function set xOffset( value : Number ) : void {
			_xOffset = value;
		}
		
		public function get yOffset() : Number {
			return _yOffset;
		}
		
		public function set yOffset( value : Number ) : void {
			_yOffset = value;
		}
	}
}