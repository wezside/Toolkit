package com.wezside.data.collection
{
	import com.wezside.data.iterator.IIterator;

	public interface ICollection
	{
		function get length():int;
		function addElement( value:* ):void;
		function addElementAt( value:*, index:int ):void;
		function getElementAt( index:int ):*;
		function clone():ICollection;		
		function cloneFromIndex( index:int, end:int = -1 ):ICollection;
		function removeElement( prop:* = "", value:* = null ):*;
		function removeElementAt( index:int ):void;
		function find( prop:* = "", value:* = null ):*;
		
		function ascending():ICollection;
		function descending():ICollection;
		function sortOn( property:String ):ICollection;		
		function elapsedSortTime():Number;
		function sortMethod( type:int = 0 ):ICollection;
		function sort():ICollection;

		function iterator():IIterator;
		function purge():void;
		function toString():String;
	}
}
