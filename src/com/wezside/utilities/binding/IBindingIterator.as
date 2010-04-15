package com.wezside.utilities.binding 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IBindingIterator 
	{
		
		function reset():void;
		function next():Object;
		function hasNext():Boolean;
		
	}
}
