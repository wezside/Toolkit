package com.wezside.utilities.factory.business 
{
	import com.wezside.data.parser.IParser;
	import com.wezside.utilities.business.rpc.IService;
	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IServiceResource 
	{
		function get id():String;
		function set id( value:String ):void;
		
		function get uri():String;
		function set uri( value:String ):void;
		
		function get qualifiedName():String;
		function set qualifiedName( value:String ):void;
		
		function get associateID():String;
		function set associateID( value:String ):void;
		
		function get instance():IService;
		function set instance( value:IService ):void;		
		
		function get type():int;
		function set type( value:int ):void;
		
		function get operationID():String;
		function set operationID( value:String ):void;
		
		function get params():Object;
		function set params( value:Object ):void;
		
		function get method():String;
		function set method( value:String ):void;
		
		function get requestHeaders():Array;
		function set requestHeaders( value:Array ):void;
		
		function get asyncToken():Number;
		function set asyncToken( value:Number ):void;
		
		function get dormant():Boolean;
		function set dormant( value:Boolean ):void;
		
		function get parser():IParser;
		function set parser( value:IParser ):void;
	}
}
