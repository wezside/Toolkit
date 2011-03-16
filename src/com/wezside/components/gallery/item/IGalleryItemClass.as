package com.wezside.components.gallery.item 
{
	import com.wezside.data.collection.ICollection;
	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IGalleryItemClass 
	{		
		function get id():String;		
		function set id( value:String ):void;
		function get clazz():Class;		
		function set clazz( value:Class ):void;
		function get fileExtension():ICollection;
		function set fileExtension( value:ICollection ):void;
	}
}
