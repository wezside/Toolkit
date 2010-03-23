package com.wezside.components.survey.form 
{
	import com.wezside.utilities.managers.style.IStyleManager;
	import com.wezside.components.survey.data.IFormData;
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IForm 
	{
		
	
		function get data():IFormData;
		function set data( value:IFormData ):void;
		
		function get state():String;
		function set state( value:String ):void;
		
		function get items():Array;
		function set items( value:Array ):void;
				
		function get layout():IFormLayout;
		function set layout( value:IFormLayout ):void;
				
		function get styleManager():IStyleManager;
		function set styleManager( value:IStyleManager ):void;
		
		function purge():void;
		function createChildren():void;
		
		function dispatchEvent( event:Event ):Boolean;
		function hasEventListener( type:String ):Boolean;
		function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void;
		function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void;		
	}
}
