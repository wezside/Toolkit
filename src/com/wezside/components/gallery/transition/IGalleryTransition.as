/*
	The MIT License

	Copyright (c) 2010 Wesley Swanepoel
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
 */
package com.wezside.components.gallery.transition 
{
	import com.wezside.components.IUIDecorator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IGalleryTransition extends IUIDecorator
	{
		
		function get rows():Number;
		function set rows( value:Number ):void;
		function get columns():Number;
		function set columns( value:Number ):void;
		function get stageWidth():Number;
		function set stageWidth( value:Number ):void;
		function get stageHeight():Number;
		function set stageHeight( value:Number ):void;
		function get reflectionHeightInRows():int;
		function set reflectionHeightInRows( value:int ):void;
		
		function get total():uint;
		function set total( value:uint ):void;
		function get totalPages():Number;
		function set totalPages( value:Number ):void;
		
		function transitionIn():void;		
		function transitionOut():void;		
		function perform( type:String = "intro" ):void;				
	}
}
