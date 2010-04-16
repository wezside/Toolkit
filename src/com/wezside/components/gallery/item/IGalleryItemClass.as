package com.wezside.components.gallery.item 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IGalleryItemClass 
	{		
		function get id():String;		
		function set id( value:String ):void;
		function get clazz():Class;		
		function set clazz( value:Class ):void;
		function get fileExtension():Array;
		function set fileExtension( value:Array ):void;
	}
}
