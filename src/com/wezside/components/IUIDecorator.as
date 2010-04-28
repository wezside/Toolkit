package com.wezside.components 
{
	import com.wezside.data.iterator.IIterator;

	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IUIDecorator 
	{

		function get width():Number
		function set width( value:Number ):void
		
		function get height():Number
		function set height( value:Number ):void		
		
	 	function iterator( type:String = null ):IIterator;
		function arrange( event:UIElementEvent = null ):void;

		function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		function dispatchEvent( event:Event ):Boolean;
		function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void;
		function hasEventListener( type:String ):Boolean;	
		
	}
}