package com.wezside.utilities.iterator 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ICollection 
	{
		function find( value:String ):Object;
		function iterator( type:String = null ):IIterator;
	}
}
