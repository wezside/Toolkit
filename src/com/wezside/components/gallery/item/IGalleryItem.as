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
package com.wezside.components.gallery.item 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IGalleryItem
	{
		
		function load( url:String, livedate:Date, linkage:String = "", thumbWidth:int = 80, thumbHeight:int = 80 ):void;		
		function rollOver():void;		
		function rollOut():void;		
		function play():void;		
		function stop():void;		
		function purge():void;
				
		function set name( value:String ):void;		
		function get name():String;		
		function set type( value:String ):void;		
		function get type():String;		
		function set selected( value:Boolean ):void;		
		function get selected():Boolean;		
		function set state( value:String ):void;		
		function get state():String;		
		function get width():Number;		
		function get height():Number;		
		function set x( value:Number ):void;		
		function get x():Number;		
		function set y( value:Number ):void;		
		function get y():Number;		
		function set visible( value:Boolean ):void;		
		function get visible():Boolean;
		function get data():*;
		function set data( value:* ):void;
				
		function reset():void;
		function update( dob:IGalleryItem ):void;		
		function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		function dispatchEvent( event:Event ):Boolean;
		function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void;
		function hasEventListener( type:String ):Boolean;			
	}
}
