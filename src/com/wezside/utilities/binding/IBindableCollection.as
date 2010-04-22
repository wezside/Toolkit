package com.wezside.utilities.binding 
{
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IBindableCollection 
	{
		function iterator():IIterator;
		function find( value:String ):Object;
	}
}
