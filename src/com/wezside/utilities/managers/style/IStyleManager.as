package com.wezside.utilities.managers.style 
{
	import flash.text.StyleSheet;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IStyleManager 
	{
		
		function parseCSSByteArray( clazz:Class ):void;
		
		function getAssetByName( linkageClassName:String ):*; 
		
		function getStyleSheet( styleName:String ):StyleSheet;		

		function getLibraryItems( styleName:String ):Object;
		
		function getPropertyStyles( styleName:String ):Array;
		
		function get css():String;
	}
}
