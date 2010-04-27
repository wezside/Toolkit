package com.wezside.components.scroll 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Scroll extends UIElement implements IScroll
	{
		
		private var _scrollHeight:int;
		private var _target:IUIDecorator;
		private var _width:Number;
		private var _height:Number;
		private var _horizontalGap:Number;

		protected var decorated:IUIDecorator;
		
		public function Scroll( decorated:IUIDecorator = null )
		{
			this.decorated = decorated;
		}
		
		override public function iterator( type:String = null ):IIterator
		{
			return new NullIterator();
		}
		
		override public function arrange( event:UIElementEvent = null ):void
		{
			super.arrange();
			draw();
		}
		
		public function draw():void
		{
		}				
		
		public function get scrollHeight():int
		{
			return _scrollHeight;
		}
		
		public function get target():IUIDecorator
		{
			return _target;
		}
		
		public function set scrollHeight(value:int):void
		{
			_scrollHeight = value;
		}
		
		public function set target(value:IUIDecorator):void
		{
			_target = value;
		}
		
		public function get horizontalGap():int
		{
			return _horizontalGap;
		}
		
		public function set horizontalGap( value:int ):void
		{
			_horizontalGap = value;
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
	}
}
