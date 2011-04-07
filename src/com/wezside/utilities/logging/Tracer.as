/*
	The MIT License

	Copyright (c) 2011 Wesley Swanepoel
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
 */
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
