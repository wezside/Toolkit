/**
 * Copyright (c) 2010 Wesley Swanepoel
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.wezside.components.layout 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElementEvent;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;

	import flash.events.EventDispatcher;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Layout extends EventDispatcher implements ILayout
	{

		private var _verticalGap:int;
		private var _horizontalGap:int;
		private var _top:int;
		private var _bottom:int;
		private var _left:int;
		private var _right:int;
		private var _width:int;
		private var _height:int;
		
		
		protected var decorated:IUIDecorator;

		
		public function Layout( decorated:IUIDecorator ) 
		{			
			this.decorated = decorated;
		}
		
		public function arrange( event:UIElementEvent = null ):void
		{			
			if ( decorated is ILayout )
			{
				if ( left != 0 ) ILayout( decorated ).left = left;
				if ( top != 0 ) ILayout( decorated ).top = top;
				if ( right != 0 ) ILayout( decorated ).right = right;
				if ( bottom != 0 ) ILayout( decorated ).bottom = bottom;
				if ( verticalGap != 0 ) ILayout( decorated ).verticalGap = verticalGap;
				if ( horizontalGap != 0 ) ILayout( decorated ).verticalGap = horizontalGap;
			}
			decorated.width = width;
			decorated.height = height;

			// Test for children
			// ILayout won't have any children because it doesn't extend DisplayObjectContainer
			if ( decorated.iterator().hasNext( )) decorated.arrange();
		}
		
		public function iterator( type:String = null ):IIterator
		{
			return new NullIterator( );
		}
		
		public function get top():int
		{
			return _top;
		}
		
		public function get bottom():int
		{
			return _bottom;
		}
		
		public function get left():int
		{
			return _left;
		}
		
		public function get right():int
		{
			return _right;
		}
		
		public function get horizontalGap():int
		{
			return _horizontalGap;
		}
		
		public function get verticalGap():int
		{
			return _verticalGap;
		}
		
		public function set top(value:int):void
		{
			_top = value;
		}
		
		public function set bottom(value:int):void
		{
			_bottom = value;
		}
		
		public function set left(value:int):void
		{
			_left = value;
		}
		
		public function set right(value:int):void
		{
			_right = value;
		}
		
		public function set horizontalGap(value:int):void
		{
			_horizontalGap = value;
		}

		public function set verticalGap(value:int):void
		{
			_verticalGap = value;
		}

		public function get width():Number
		{
			return _width;
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		public function set width(value:Number):void
		{
			_width = value;
		}
		
		public function set height(value:Number):void
		{
			_height = value;
		}

	}
}