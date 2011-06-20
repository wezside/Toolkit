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

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IShape extends IUIDecorator 
	{
		
		function get colours():Array
		function set colours( value:Array ):void
		
		function get alphas():Array
		function set alphas( value:Array ):void
		
		function get ratios():Array;
		function set ratios( value:Array ):void;
		
		function get cornerRadius():int
		function set cornerRadius( value:int ):void
		
		function get borderAlpha():Number
		function set borderAlpha( value:Number ):void
		
		function get borderColor():uint;
		function set borderColor( value:uint ):void;
		
		function get borderThickness():int
		function set borderThickness( value:int ):void

		function get topLeftRadius():int;
		function set topLeftRadius( value:int ):void;
					
		function get topRightRadius():int;
		function set topRightRadius( value:int ):void;
					
		function get bottomLeftRadius():int;
		function set bottomLeftRadius( value:int ):void;
					
		function get bottomRightRadius():int;
		function set bottomRightRadius( value:int ):void;
		
		function get xOffset():int;
		function set xOffset( value:int ):void;
					
		function get yOffset():int;
		function set yOffset( value:int ):void;
					
		function get autoDetectWidth():Boolean;
		function set autoDetectWidth( value:Boolean ):void;
					
		function get autoDetectHeight():Boolean;
		function set autoDetectHeight( value:Boolean ):void;
					
		function draw():void
		function clear():void
	}
}
