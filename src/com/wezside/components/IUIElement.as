package com.wezside.components 
{
	import com.wezside.utilities.manager.style.IStyleManager;

	import flash.text.StyleSheet;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IUIElement 
	{
		
		 function update():void
		 function get children():Array
		 function set children( value:Array ):void
		 function get styleManager():IStyleManager
		 function set styleManager( value:IStyleManager ):void
		 function get styleName():String
		 function set styleName( value:String ):void
		 function get styleSheet():StyleSheet
		 function set styleSheet( value:StyleSheet ):void
		 function purge():void;
	
	}
}
