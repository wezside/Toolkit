package com.wezside.utilities.factory
{
	import com.wezside.data.parser.IParser;

	import flash.system.LoaderContext;
	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IResource
	{
		
		function get id():String;
		function set id( value:String ):void;
		
		function get type():int;
		function set type( value:int ):void;

		function get uri():String;
		function set uri( value:String ):void;
		
		function get bytesLoaded():Number;
		function set bytesLoaded( value:Number ):void;
		
		function get bytesTotal():Number;
		function set bytesTotal( value:Number ):void;
		
		function get data():*;
		function set data( value:* ):void;
		
		function get parser():IParser;
		function set parser( value:IParser ):void;
		
		function get xmlns():Namespace;
		function set xmlns( value:Namespace ):void;
		
		function get context():LoaderContext
		function set context( value:LoaderContext ):void

	}
}
