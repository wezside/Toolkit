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

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IShape extends IUIDecorator 
	{
		function get shape():Sprite;
		function set shape( value:Sprite ):void;
		
		function get backgroundColours():Array
		function set backgroundColours( value:Array ):void
		
		function get backgroundAlphas():Array
		function set backgroundAlphas( value:Array ):void
		
		function get cornerRadius():int
		function set cornerRadius( value:int ):void
		
		function get borderAlpha():int
		function set borderAlpha( value:int ):void
		
		function get borderThickness():int
		function set borderThickness( value:int ):void

		function get backgroundWidth():int
		function set backgroundWidth( value:int ):void
		
		function get backgroundHeight():int
		function set backgroundHeight( value:int ):void
		
		function draw():void;
	}
}
