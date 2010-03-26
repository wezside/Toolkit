/**
 * Copyright (c) 2010 Wesley Swanepoel
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.wezside.utilities.manager.state 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class State implements IState 
	{
		private var _key:String;
		private var _reserved:Boolean;
		private var _value:Number;

		
		public function State( key:String, reserved:Boolean = false ) 
		{
			_key = key;
			_reserved = reserved;	
		}
		
		public function clone():IState
		{
			var state:IState = new State( _key, _reserved );
			state.value = _value;
			return state;
		}

		public function get key():String
		{
			return _key;
		}
		
		public function get reserved():Boolean
		{
			return _reserved;
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function set key( value:String ):void
		{
			_key = value;
		}
		
		public function set reserved( value:Boolean ):void
		{
			_reserved = value;
		}

		public function set value( value:Number ):void
		{
			_value = value;
		}
		
		
	}
}
