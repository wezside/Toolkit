package com.wezside.utilities.factory
{
	import com.wezside.data.IDeserializable;
	import com.wezside.data.collection.ICollection;

	import flash.events.IEventDispatcher;


	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IModule extends IEventDispatcher
	{		
		function get id():String;
		function set id( value:String ):void;
		
		function get dataID():String;
		function set dataID( value:String ):void;
		
		function get data():IDeserializable
		function set data( value:IDeserializable ):void
		
		function get resources():ICollection;
		function set resources( value:ICollection ):void;
				
		function get state():String;
		function set state( value:String ):void;
				
		function show():void;
		function hide():void;
		function hasState( id:String ):Boolean;
		function resize():void;
		function purge():void;

	}
}
