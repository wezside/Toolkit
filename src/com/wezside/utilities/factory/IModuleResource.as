package com.wezside.utilities.factory
{
	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IModuleResource
	{
		
		function get id():String;
		function set id( value:String ):void;
		
		function get uri():String;
		function set uri( value:String ):void;
		
		function get qualifiedName():String;
		function set qualifiedName( value:String ):void;
		
		function get instance():IModule;
		function set instance( value:IModule ):void;
		
		function get dataID():String;
		function set dataID( value:String ):void;
		
		function get serviceID():String;
		function set serviceID( value:String ):void;
	}
}
