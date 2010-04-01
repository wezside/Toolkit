package com.wezside.utilities.flashvars 
{

	/**
	 * @author Wesley.Swanepoel
	 * @version .320
	 */

	public class FlashVars 
	{

		private static var vars:Object;
		
		
		public function FlashVars( _vars:Object ) 
		{
			vars = _vars;	
		}

		
		public function setArgs( arg_vars:Object ):void 
		{
			vars = arg_vars;
		}


		public function getValue( key:String ):String
		{
			if ( vars != null ) return vars[key]; 						
			return null;	
		}


		public function setValue( key:String, value:String ):void
		{
			if ( vars != null ) vars[key] = value;
			else throw new Error( " Collection object doesn't exist." );
		}
		
		
		public function getParams():Object
		{
			return vars;	
		}

	}
}
