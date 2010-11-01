package com.wezside.data.collection 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IDictionaryCollection
	{
		function addElement( key:*, value:* ):void;
		function getElement( key:* ):*
		function hasElement( key:* ):Boolean;
		function removeElement( prop:String = "", value:* = null ):*
		function get length():int;
		function find( prop:String = "", value:* = null ):*
		function purge():void;
		function toString():String;				
	}
}
