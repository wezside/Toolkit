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

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ILayout extends IUIDecorator
	{
		
		function get top():int
		function set top( value:int ):void
		
		function get bottom():int
		function set bottom( value:int ):void
		
		function get left():int
		function set left( value:int ):void
		
		function get right():int
		function set right( value:int ):void
		
		function get horizontalGap():int
		function set horizontalGap( value:int ):void
		
		function get verticalGap():int
		function set verticalGap( value:int ):void		
		
		function get placement():String;
		function set placement( value:String ):void;
	
	}
}
