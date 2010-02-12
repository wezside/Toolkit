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
