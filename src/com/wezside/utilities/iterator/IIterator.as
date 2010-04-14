package com.wezside.utilities.iterator 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IIterator 
	{
		
		function reset():void;
		function next():Object;
		function hasNext():Boolean;
		
	}
}
