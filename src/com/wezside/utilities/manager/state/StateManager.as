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
	 * 
	 * <p>
	 * A useful class to manage application or component state. The reserved property on an IState instance is used for 
	 * application state which should only affect itself. 
	 * </p>
	 * 
	 * <p><b>Reserved States</b></p>
	 * <p>
	 * Reserved states are not mutually exclusive, they are allowed to co exist with non-reserved and other reserved states. 
	 * </p>
	 * 
	 * <p><b>Example</b></p>
	 * <p>
	 * An example of this is the Credential state, i.e. logged in vs not logged in.
	 * Multiple other states could exist with both of these application states however to each other the two
	 * are mutually exclusive. Therefore a single state is used to indicate if a user is logged in or not. If a user is logged in 
	 * the state in question's value will be added to the current state. If not logged in the state's value won't be added. 
	 * </p>
	 * Further Reading on Bitwise operators:		 
	 * http://www.moock.org/asdg/technotes/bitwise/  
	 */
	public class StateManager 
	{
		
		
		private var _state:IState = new State( "" );
		private var _baseTwo:Number = 1;

		private var _states:Vector.<IState> = new Vector.<IState>();
		private var _history:Vector.<IState> = new Vector.<IState>();
				
		
		public function addState( key:String, reserved:Boolean = false ):void
		{
			var state:State = new State( key, reserved );
			state.value = _baseTwo << _states.length;
			_states.push( state );
		}
		
		
		public function set state( key:String ):void
		{
			var state:IState = stateByKey( key );
			var lastIndex:int = _history.length - 1;
			if ( lastIndex > 0 && _history[ lastIndex > 0 ? lastIndex : 0 ].key != state.key )
				_history.push( state );
			
			// If the state is reserved for specific use then XOR else OR
			if ( state.reserved ) 
			{
				_state.key = state.key;
				_state.value ^= state.value;
			}
			else 
			{
				// Clear all non reserved bits
				var nonReserved:Number = isNaN( _state.value ) ? state.value : _state.value;
				for ( var i : int = 0; i < _states.length; ++i ) 
					if ( !IState( _states[i] ).reserved )
						nonReserved &= ~IState( _states[i] ).value;

				_state.key = state.key;
				_state.value = state.value;
				_state.value = state.value ^ nonReserved;			
			}
		}

		public function get state():String
		{
			return _state.key;
		}
		
		public function get stateValue():Number
		{
			return _state.value;
		}
		
		public function get stateKey():String
		{
			var str:String = "";
			for ( var i:int = 0; i < _states.length; ++i ) 
				if (( _state.value & _states[i].value ) == _states[i].value )
					str += _states[i].key;
			
			return str;
		}
		
		public function get history():Vector.<IState>
		{
			return _history;
		}
		
		public function previousState():String
		{
			for ( var i:int = 0; i < _history.length; ++i ) 
				if (  _history[ i ].key == _state.key )
					return _history[ i > 0 ? i - 1 : 0 ].key;
			return "";
		}

		public function purge():void
		{
			_history = null;
			_state = null;
		}
	
		
		private function stateByKey( key:String ):IState 
		{
			for ( var i : int = 0; i < _states.length; ++i ) 
				if ( _states[i].key == key )
					return _states[i];
			return null;
		}
		
	}
}
