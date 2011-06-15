package com.wezside.data.parser
{
	import com.wezside.data.collection.ICollection;

	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;


	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IParser extends IEventDispatcher
	{
		
		function get resourceID():String;
		function set resourceID( value:String ):void;
		
		function get raw():*;
		function set raw( value:* ):void;
		
		function get data():*;
		function get type():int;
		function set type( value:int ):void;
		
		function get locale():String
		function set locale( value:String ):void		
		
		function get appDomain():ApplicationDomain
		function set appDomain( value:ApplicationDomain ):void

		function get observers():ICollection;
		function set observers( value:ICollection ):void;
		
		function parse():void;
		function notifyObservers( data:* = null ):void;
		
	}
}
