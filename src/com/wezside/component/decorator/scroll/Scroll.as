package com.wezside.component.decorator.scroll
{
	import com.wezside.utilities.manager.state.StateManager;
	import com.wezside.component.IUIDecorator;
	import com.wezside.component.IUIElement;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;
	import flash.display.Sprite;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class Scroll extends Sprite implements IScroll
	{
		
		private var _target:IUIDecorator;
		private var _thumb:IUIElement;
		private var _track:IUIElement;
		private var _scrollWidth:int;
		private var _scrollHeight:int;
		private var _horizontalGap:int;
		private var _verticalGap:int;
		private var _width:Number = 0;
		private var _height:Number = 0;		
		private var _trackWidth:int = 20;
		private var _trackHeight:int = 20;		
		private var _thumbWidth:int;
		private var _thumbHeight:int;
		private var _trackColors:Array = [ 0xcccccc, 0xcccccc ];
		private var _thumbColors:Array = [ 0x666666, 0x666666 ];
		private var _thumbXOffset:Number = 2;
		private var _thumbYOffset:Number = 2;
		private var _trackMinY:Number = 2;
		private var _trackMaxY:Number = 2;				
		private var _trackMinX:Number = 2;
		private var _trackMaxX:Number = 2;				
		
		protected var decorated:IUIDecorator;

		public function Scroll( decorated:IUIDecorator = null )
		{
			this.decorated = decorated;
			visible = false;
		}

		public function iterator( type:String = null ):IIterator
		{
			return new NullIterator();
		}

		public function arrange():void
		{
			draw();
		}

		public function draw():void
		{
			//
		}

		public function reset():void
		{
		}

		public function resetTrack():void
		{
		}

		public function resetThumb():void
		{
		}

		public function purge():void
		{
			_thumb = null;
			_track = null;
			_target = null;
		}

		override public function set width(value:Number):void 
		{
			_width = value;
		}
		
		override public function get width():Number 
		{
			return _width;
		}
		
		override public function set height(value:Number):void 
		{
			_height = value;
		}
		
		override public function get height():Number 
		{
			return _height;
		}

		public function get target():IUIDecorator
		{
			return _target;
		}

		public function set target( value:IUIDecorator ):void
		{
			_target = value;
		}

		public function get thumb():IUIElement
		{
			return _thumb;
		}

		public function set thumb( value:IUIElement ):void
		{
			_thumb = value;
		}

		public function get track():IUIElement
		{
			return _track;
		}

		public function set track( value:IUIElement ):void
		{
			_track = value;
		}

		public function get scrollWidth():int
		{
			return _scrollWidth;
		}

		public function set scrollWidth( value:int ):void
		{
			_scrollWidth = value;
		}

		public function get scrollHeight():int
		{
			return _scrollHeight;
		}

		public function set scrollHeight( value:int ):void
		{
			_scrollHeight = value;
		}

		public function get horizontalGap():int
		{
			return _horizontalGap;
		}

		public function set horizontalGap( value:int ):void
		{
			_horizontalGap = value;
		}

		public function get verticalGap():int
		{
			return _verticalGap;
		}

		public function set verticalGap( value:int ):void
		{
			_verticalGap = value;
		}

		public function get thumbWidth():int
		{
			return _thumbWidth;
		}

		public function set thumbWidth( value:int ):void
		{
			_thumbWidth = value;
		}

		public function get thumbHeight():int
		{
			return _thumbHeight;
		}

		public function set thumbHeight( value:int ):void
		{
			_thumbHeight = value;
		}

		public function get trackWidth():int
		{
			return _trackWidth;
		}

		public function set trackWidth( value:int ):void
		{
			_trackWidth = value;
		}

		public function get trackHeight():int
		{
			return _trackHeight;
		}

		public function set trackHeight( value:int ):void
		{
			_trackHeight = value;
		}

		public function get scrollBarVisible():Boolean
		{
			return this.visible;
		}

		public function set scrollBarVisible( value:Boolean ):void
		{
			this.visible = value;
		}

		public function get thumbColors():Array
		{
			return _thumbColors;
		}

		public function get trackColors():Array
		{
			return _trackColors;
		}

		public function get thumbXOffset():Number
		{
			return _thumbXOffset;
		}
		
		public function get thumbYOffset():Number
		{
			return _thumbYOffset;
		}
		
		public function set thumbYOffset( value:Number ):void
		{
			_thumbYOffset = value;
		}

		public function get trackMinY():Number
		{
			return _trackMinY;
		}

		public function get trackMaxY():Number
		{
			return _trackMaxY;
		}

		public function get trackMaxX():Number
		{
			return _trackMaxX;
		}

		public function set trackMaxX( value:Number ):void
		{
			_trackMaxX = value;
		}

		public function set thumbColors( value:Array ):void
		{
			_thumbColors = value;
		}

		public function set trackColors( value:Array ):void
		{
			_trackColors = value;
		}

		public function set thumbXOffset( value:Number ):void
		{
			_thumbXOffset = value;
		}

		public function set trackMinY( value:Number ):void
		{
			_trackMinY = value;
		}

		public function set trackMaxY( value:Number ):void
		{
			_trackMaxY = value;
		}

		public function get trackMinX():Number
		{
			return _trackMinX;
		}

		public function set trackMinX( value:Number ):void
		{
			_trackMinX = value;
		}

		/**
		 * Scroll to a percentage value.
		 */
		public function to( value:Number ):void
		{
		}

		public function get state():String
		{
			return "";
		}

		public function set state( value:String ):void
		{
		}

		public function get stateManager():StateManager
		{
			return null;
		}

		public function set stateManager( value:StateManager ):void
		{
		}

	}
}
