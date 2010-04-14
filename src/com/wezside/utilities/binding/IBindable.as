package com.wezside.utilities.binding 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IBindable 
	{
		
		function get src():Object
		function set src( value:Object ):void
		function get srcProp():String
		function set srcProp( value:String ):void
		function get target():Object
		function set target( value:Object ):void
		function get targetProp():Object
		function set targetProp( value:Object ):void		
		
		function listen():void;
		function purge():void;
		
	}
}
