package com.wezside.utilities.xml 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IXMLDataItem 
	{
		
		function get clazz():Class;
		function set clazz( value:Class ):void;
		
		function get nodeName():String;
		function set nodeName( value:String ):void;
		
		function get parentCollectionProperty():String;
		function set parentCollectionProperty( value:String ):void;
	}
	
	
	
}
