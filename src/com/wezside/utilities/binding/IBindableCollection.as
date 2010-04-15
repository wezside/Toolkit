package com.wezside.utilities.binding 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IBindableCollection 
	{
		function iterator():IBindingIterator;
		function find( value:String ):Object;
	}
}
