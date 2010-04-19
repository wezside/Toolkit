package com.wezside.components.layout 
{
	import com.wezside.components.IUIDecorator;

	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ILayout extends IUIDecorator
	{
		
		function get horizontalGap():int;
		function set horizontalGap( value:int ):void;
		
		function get verticalGap():int;
		function set verticalGap( value:int ):void;
		
		function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		function dispatchEvent( event:Event ):Boolean;
		function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void;
		function hasEventListener( type:String ):Boolean;				
	}
}
