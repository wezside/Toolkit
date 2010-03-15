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
package com.wezside.components.accordion 
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IAccordionItem
	{
		

	
		function get name():String;
		function set name( value:String ):void;
		function get selected():Boolean;
		function set selected( value:Boolean ):void;
		function get x():Number;
		function set x( value:Number ):void;
		function get y():Number;
		function set y( value:Number ):void;
		function get alpha():Number;
		function set alpha( value:Number ):void;
		function get visible():Boolean;
		function set visible( value:Boolean ):void;
		function get currentY():Number;
		function set currentY( value:Number ):void;
		function get targetY():Number;
		function set targetY( value:Number ):void;
		function get width():Number;
		function set width( value:Number ):void;
		function get height():Number;
		function set height( value:Number ):void;
		function get header():DisplayObject;
		function set header( value:DisplayObject ):void;
		function get content():DisplayObject;
		function set content( value:DisplayObject ):void;
		
		function dispatchEvent( event:Event ):Boolean;
		function hasEventListener( type:String ):Boolean;
		function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void;
		function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void;
		
	}
}
