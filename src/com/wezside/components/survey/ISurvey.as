package com.wezside.components.survey 
{
	import com.wezside.components.survey.data.ISurveyData;
	import com.wezside.components.survey.form.IFormTransition;

	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ISurvey 
	{
		
		function get state():String;
		function set state( value:String ):void;
		
		function get data():ISurveyData;
		function set data( value:ISurveyData ):void;
		
		function get pages():int;
		function set pages( value:int ):void;
		
		function get pageIndex():int;
		function set pageIndex( value:int ):void;
		
		function get transition():IFormTransition;
		function set transition( value:IFormTransition ):void;
		
		function get visible():Boolean;
		function set visible( value:Boolean ):void;
		
		function show():void;
		function hide():void;
		function purge():void;
		function create():void;
		function dispatchEvent( event:Event ):Boolean;
		function hasEventListener( type:String ):Boolean;
		function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void;
		function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void;				
	}
}
