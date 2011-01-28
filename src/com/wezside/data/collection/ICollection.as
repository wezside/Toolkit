package com.wezside.data.collection
{
	import com.wezside.data.iterator.IIterator;

	public interface ICollection
	{
		function addElement( value:* ):void;
		function clone():ICollection;		
		function cloneFromIndex( index:int, end:int = -1 ):ICollection;
		function find( prop:* = "", value:* = null ):*;
		function getElementAt( index:int ):*;
		function iterator():IIterator;
		function get length():int;
		function purge():void;
		function removeElement( prop:* = "", value:* = null ):*;
		function removeElementAt( index:int ):void;
		function toString():String;
	}
}
