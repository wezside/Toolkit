package com.wezside.utilities.business 
{
	import com.wezside.utilities.business.rpc.IService;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 * @version .326
	 */
	public class Services
	{
		
		private var services:Dictionary = new Dictionary();
		
		
		public function register( id:String, service:IService ):Boolean
		{
			if ( services[id] == null )
			{
				services[id] = service;
				return true;
			}
			else return false;
		}


		public function getService( id:String ):IService
	    {
	    	return services[id] || null;
	    }		
		
		
		public function toString():String
		{
			return getQualifiedClassName( this );
		}
	}
}
