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
