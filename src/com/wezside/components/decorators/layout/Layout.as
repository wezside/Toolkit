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
package com.wezside.components.decorators.layout 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.IUIElement;
	import com.wezside.components.UIElement;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.manager.state.StateManager;

	import flash.events.EventDispatcher;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Layout extends EventDispatcher implements ILayout
	{	
		// Top placement
		public static const PLACEMENT_TOP_LEFT:String = "placementTopLeft";
		public static const PLACEMENT_TOP_CENTER:String = "placementTopCenter";
		public static const PLACEMENT_TOP_RIGHT:String = "placementTopRight";
		
		// Center placement
		public static const PLACEMENT_CENTER_LEFT:String = "placementCenterLeft";
		public static const PLACEMENT_CENTER_RIGHT:String = "placementCenterRight";
		public static const PLACEMENT_CENTER:String = "placementCenter";
		
		// Bottom placement
		public static const PLACEMENT_BOTTOM_LEFT:String = "placementBottomLeft";
		public static const PLACEMENT_BOTTOM_CENTER:String = "placementBottomCenter";
		public static const PLACEMENT_BOTTOM_RIGHT:String = "placementBottomRight";		

		private var _verticalGap:int;
		private var _horizontalGap:int;
		private var _top:int;
		private var _bottom:int;
		private var _left:int;
		private var _right:int;
		private var _width:int;
		private var _height:int;
		
		protected var decorated:IUIDecorator;
		protected var placementState:StateManager;
		
		public function Layout( decorated:IUIDecorator ) 
		{			
			this.decorated = decorated;
			placementState = new StateManager();
			placementState.addState( PLACEMENT_TOP_LEFT );
			placementState.addState( PLACEMENT_TOP_CENTER );
			placementState.addState( PLACEMENT_TOP_RIGHT );
			placementState.addState( PLACEMENT_CENTER_LEFT );
			placementState.addState( PLACEMENT_CENTER_RIGHT );
			placementState.addState( PLACEMENT_CENTER );
			placementState.addState( PLACEMENT_BOTTOM_LEFT );
			placementState.addState( PLACEMENT_BOTTOM_CENTER );
			placementState.addState( PLACEMENT_BOTTOM_RIGHT );	
		}
		
		public function arrange():void
		{
			// Copy property values from previous ILayout decorator only if it wasn't explicitely set
			if ( decorated is ILayout )
			{
				if ( left != 0 ) ILayout( decorated ).left = left;
				if ( top != 0 ) ILayout( decorated ).top = top;
				if ( right != 0 ) ILayout( decorated ).right = right;
				if ( bottom != 0 ) ILayout( decorated ).bottom = bottom;
				if ( verticalGap != 0 ) ILayout( decorated ).verticalGap = verticalGap;
				if ( horizontalGap != 0 ) ILayout( decorated ).horizontalGap = horizontalGap;
				
			}
			if ( decorated is IUIElement )
			{
				if ( left != 0 ) IUIElement( decorated ).layout.left = left;
				if ( top != 0 ) IUIElement( decorated ).layout.top = top;
				if ( right != 0 ) IUIElement( decorated ).layout.right = right;
				if ( bottom != 0 ) IUIElement( decorated ).layout.bottom = bottom;
				if ( verticalGap != 0 ) IUIElement( decorated ).layout.verticalGap = verticalGap;
				if ( horizontalGap != 0 ) IUIElement( decorated ).layout.horizontalGap = horizontalGap;
			}
		
			// Test for children
			// ILayout won't have any children because it doesn't extend DisplayObjectContainer
			if ( decorated.iterator().hasNext( )) decorated.arrange();
		}
		
		public function reset():void
		{
		}
		
		public function iterator( type:String = null ):IIterator
		{
			return decorated.iterator( UIElement.ITERATOR_CHILDREN );
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
		
		public function get placement():String
		{
			return placementState.stateKey;
		}
		
		public function set placement( value:String ):void
		{
			placementState.stateKey = value;
		}
	}
}