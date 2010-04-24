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
package com.wezside.components.shape 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.layout.ILayout;
	import com.wezside.data.iterator.IIterator;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Shape extends Sprite implements IShape 
	{
		
		private var _layout:ILayout;
		private var _backgroundColors:Array;
		private var _backgroundAlphas:Array;
		private var _cornerRadius:int;
		private var _borderAlpha:int;
		private var _borderThickness:int;
		private var _shape:Sprite;
		private var _backgroundWidth:int;
		private var _backgroundHeight:int;

		protected var decorated:IUIDecorator;

		
		public function Shape( decorated:IUIDecorator = null ) 
		{					
			this.decorated = decorated;	
			this.layout = decorated.layout;
			
			if ( decorated is IShape )
			{
				shape = IShape( decorated ).shape;
				backgroundWidth = IShape( decorated ).backgroundWidth;
				backgroundHeight = IShape( decorated ).backgroundHeight;
			}
			else
			{
				shape = new Sprite();
			}
			addChild( shape );
		}

		public function iterator(type:String = null):IIterator
		{
			return decorated.iterator( UIElement.ITERATOR_CHILDREN );
		}
		
		public function update():void
		{
			arrange();
		}
		
		public function arrange(event:UIElementEvent = null):void
		{
			draw();
		}
		
		public function get layout():ILayout
		{
			return _layout;
		}
		
		public function set layout(value:ILayout):void
		{
			_layout = value;
		}
		
		public function get backgroundColours():Array
		{
			return _backgroundColors;
		}
		
		public function set backgroundColours(value:Array):void
		{
			_backgroundColors = value;
		}
		
		public function get backgroundAlphas():Array
		{
			return _backgroundAlphas;
		}
		
		public function set backgroundAlphas(value:Array):void
		{
			_backgroundAlphas = value;
		}
		
		public function draw():void
		{
		}
		
		public function get background():IShape
		{
			return null;
		}
		
		public function set background( value:IShape ):void
		{
		}
		
		public function get cornerRadius():int
		{
			return _cornerRadius;
		}
		
		public function set cornerRadius(value:int):void
		{
			_cornerRadius = value;
		}
		
		public function get borderAlpha():int
		{
			return _borderAlpha;
		}
		
		public function get borderThickness():int
		{
			return _borderThickness;
		}
		
		public function set borderAlpha(value:int):void
		{
			_borderAlpha = value;
		}
		
		public function set borderThickness(value:int):void
		{
			_borderThickness = value;
		}
		
		public function get shape():Sprite
		{
			return _shape;
		}
		
		public function set shape(value:Sprite):void
		{
			_shape = value;
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
		}
		
		override public function get width():Number 
		{
			return super.width;
		}

		override public function set height(value:Number):void 
		{
			super.height = value;
		}
		
		override public function get height():Number 
		{
			return super.height;
		}
		
		public function get backgroundWidth():int
		{
			return _backgroundWidth;
		}
		
		public function get backgroundHeight():int
		{
			return _backgroundHeight;
		}
		
		public function set backgroundWidth(value:int):void
		{
			_backgroundWidth = value;	
		}

		public function set backgroundHeight(value:int):void
		{
			_backgroundHeight = value;
		}
	}
}
