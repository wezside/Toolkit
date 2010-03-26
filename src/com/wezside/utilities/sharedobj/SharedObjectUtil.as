package com.wezside.utilities.sharedobj 
{
	import flash.net.SharedObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class SharedObjectUtil 
	{
		

		private var _domain:String;
		private var so:SharedObject;

		
		public function SharedObjectUtil() 
		{
			_domain = "";	
		}		
		
		public function getValue( key:String ):String
		{
			if ( !so ) so = SharedObject.getLocal( _domain );
			return so.data[key] == null ? "" : so.data[key];
		}
		
		public function setValue( key:String, value:String ):void
		{
			if ( !so ) so = SharedObject.getLocal( _domain );
			so.data[key] = value;
			so.flush();
		}
		
		public function clear():void
		{
			so = SharedObject.getLocal( _domain );
			so.clear();
		}
		
		public function get domain():String
		{
			return _domain;
		}
		
		public function set domain( value:String ):void
		{
			_domain = value;
		}
	}
}
