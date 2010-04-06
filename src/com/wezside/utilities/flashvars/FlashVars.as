/*
	The MIT License

	Copyright (c) 2010 Wesley Swanepoel
	
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
