package com.wezside.components.decorators.scroll 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.IUIElement;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;
	import com.wezside.utilities.manager.state.StateManager;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Scroll extends Sprite implements IScroll
	{
		
		private var _scrollHeight:int;
		private var _scrollWidth:int;
		private var _target:IUIDecorator;
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _thumb:IUIElement;
		private var _track:IUIElement;
		private var _horizontalGap:int;
		private var _verticalGap:int;
		private var _trackWidth:int = 20;
		private var _trackHeight:int = 20;
		private var _scrollBarVisible:Boolean;
		
		protected var decorated:IUIDecorator;

		public function Scroll( decorated:IUIDecorator = null )
		{
			this.decorated = decorated;
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
		}
										
		public function purge():void
		{
		}
		
		public function get scrollHeight():int
		{
			return _scrollHeight;
		}
				
		public function get scrollWidth():int
		{
			return _scrollWidth;
		}
		
		public function get target():IUIDecorator
		{
			return _target;
		}
		
		public function set scrollHeight( value:int ):void
		{
			_scrollHeight = value;
		}
		
		public function set scrollWidth( value:int ):void
		{
			_scrollWidth = value;
		}
		
		public function set target(value:IUIDecorator):void
		{
			_target = value;
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
		
		public function get horizontalGap():int
		{
			return _horizontalGap;
		}
		
		public function set horizontalGap(value:int):void
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
		
		public function get stateManager():StateManager
		{
			return null;
		}
		
		public function set stateManager(value:StateManager):void
		{
		}

		public function get scrollBarVisible():Boolean
		{
			return _scrollBarVisible;
		}

		public function set scrollBarVisible( value:Boolean ) : void
		{
			_scrollBarVisible = value;
		}
	}
}
