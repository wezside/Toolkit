package com.wezside.utilities.logging 
{

	/**
	 * @author Wesley.Swanepoel
	 * @version .320
	 */
	public class Tracer 
	{
		
		public static const DEBUG:Boolean = true;		
		public static const INFO:String = "** INFO **";
		public static const ERROR:String = "-- ERROR --";
		public static const WARNING:String = "== Warning ==";
		public static const PROGRESS:String = "** PROGRESS **";
		public static const TIMEOUT:String = "** TIMEOUT **";
	
		
		/**
		 * A static method to output the trace statement. The type param is optional and 
		 * will default to INFO.
		 * @param debug Used to toggle trace statement on and off
		 * @param output The string to output
		 * @param type <optional> Can be of value INFO, ERROR, WARNING, PROGESS and TIMEOUT</optional>
		 */
		public static function output( debug:Boolean, output:String, classRef:String = null, type:String = INFO ):void
		{
			if ( debug ) trace ( type + ": " + classRef + " |" + output );
		}
		
	}
}
