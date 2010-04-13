package com.wezside.utilities.business 
{

	/**
	 * @author wesley.swanepoel
	 * @version .326
	 */

	public interface IResponder 
	{
		
		function fault( event:ResponderEvent ):void;
		function result( event:ResponderEvent ):void;

	}
}
