/**
 * Copyright (c) 2011 Wesley Swanepoel
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
package com.wezside.component.decorator.shape 
{
	import com.wezside.component.IUIDecorator;
	import com.wezside.component.UIElement;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.imaging.GraphicsEx;
	import com.wezside.utilities.manager.state.StateManager;
	import flash.display.Sprite;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class Shape extends Sprite implements IShape 
	{
		
		public static const TYPE_ISHAPE:String = "TYPE_ISHAPE";
		public static const TYPE_IUIELEMENT:String = "TYPE_IUIELEMENT";
		public static const SCROLL:String = "SCROLL";
		public static const AUTO_WIDTH:String = "AUTO_WIDTH";
		public static const AUTO_HEIGHT:String = "AUTO_HEIGHT";


		private var _cornerRadius:int = 0;
		private var _borderColor:uint = 0xffffff;
		private var _borderAlpha:int = 1;
		private var _borderThickness:int = 0;
		private var _colours:Array = [];
		private var _alphas:Array = [];
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _bottomRightRadius:int = 0;
		private var _bottomLeftRadius:int = 0;
		private var _topRightRadius:int = 0;
		private var _topLeftRadius:int = 0;
		private var _xOffset:int = 0;
		private var _yOffset:int = 0;
		private var _ratios:Array = [ 0, 255 ];

		protected var states:StateManager;
		protected var decorated:IUIDecorator;
		
		public var graphicsEx:GraphicsEx;
		private var _autoDetectHeight:Boolean;
		private var _autoDetectWidth:Boolean;

		/**
		 * Determine what properties the decorated has and update the state
		 */
		public function Shape( decorated:IUIDecorator = null ) 
		{					
			this.decorated = decorated;			
		}

		public function iterator( type:String = null ):IIterator
		{
			return decorated.iterator( UIElement.ITERATOR_CHILDREN );
		}
		
		public function arrange():void
		{
			clear();
			draw();
		}
				
		public function draw():void
		{			
			if ( decorated.iterator().hasNext()) 
				decorated.arrange();			
		}		

		public function clear():void
		{
			graphics.clear();
			if ( graphicsEx ) graphicsEx.clear();
		}		
		
		public function get colours():Array
		{
			return _colours;
		}
		
		public function set colours(value:Array):void
		{
			_colours = value;
		}
		
		public function get alphas():Array
		{
			return _alphas;
		}
		
		public function set alphas(value:Array):void
		{
			_alphas = value;
		}
		
		public function get cornerRadius():int
		{
			return _cornerRadius;
		}
		
		public function set cornerRadius(value:int):void
		{
			_cornerRadius = value;
		}
		
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}
		
		public function get borderThickness():int
		{
			return _borderThickness;
		}
		
		public function set borderAlpha(value:Number):void
		{
			_borderAlpha = value;
		}
		
		public function set borderThickness(value:int):void
		{
			_borderThickness = value;
		}
		
		public function get borderColor():uint
		{
			return _borderColor;
		}
		
		public function set borderColor( value:uint ):void
		{
			_borderColor = value;
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
		
		public function get topLeftRadius():int
		{
			return _topLeftRadius;
		}
		
		public function set topLeftRadius( value:int ):void
		{
			_topLeftRadius = value;
			_cornerRadius = value;
		}
		
		public function get topRightRadius():int
		{
			return _topRightRadius;
		}
		
		public function set topRightRadius( value:int ):void
		{
			_topRightRadius = value;
			_cornerRadius = value;
		}
		
		public function get bottomLeftRadius():int
		{
			return _bottomLeftRadius;
		}
		
		public function set bottomLeftRadius( value:int ):void
		{
			_bottomLeftRadius = value;
			_cornerRadius = value;
		}
		
		public function get bottomRightRadius():int
		{
			return _bottomRightRadius;
		}
		
		public function set bottomRightRadius( value:int ):void
		{
			_bottomRightRadius = value;
			_cornerRadius = value;
		}

		public function get xOffset():int
		{
			return _xOffset;
		}
		
		public function get yOffset():int
		{
			return _yOffset;
		}
		
		public function set xOffset(value:int):void
		{
			_xOffset = value;
		}
		
		public function set yOffset(value:int):void
		{
			_yOffset = value;
		}
		
		public function get ratios():Array
		{
			return _ratios;
		}
		
		public function set ratios( value:Array ):void
		{
			_ratios = value;
		}

		public function get autoDetectWidth():Boolean
		{
			return _autoDetectWidth;
		}

		public function get autoDetectHeight():Boolean
		{
			return _autoDetectHeight;
		}

		public function set autoDetectWidth( value:Boolean ):void
		{
			_autoDetectWidth = value;
		}

		public function set autoDetectHeight( value:Boolean ):void
		{
			_autoDetectHeight = value;
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
