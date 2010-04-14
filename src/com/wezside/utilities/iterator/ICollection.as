package com.wezside.utilities.iterator 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ICollection 
	{
		function iterator( type:String = null ):IIterator;
	}
}
