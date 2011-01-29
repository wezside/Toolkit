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
	 * <p></p>
	 * <p>
	 * A useful class to manage application or component state. The reserved property on an IState instance is used for 
	 * application state which should only affect itself. 
	 * </p>
	 * <p></p>
	 * <p><b>Reserved States</b></p>
	 * <p>
	 * Reserved states are not mutually exclusive, they are allowed to co exist with non-reserved and other reserved states. 
	 * </p>
	 * <p></p>
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
		
		
		private var _baseTwo:Number = 1;
		private var _state:IState = new State( "" );

		private var _states:Array = [];
		private var _history:Array = [];

		
		public function addState( key:String, reserved:Boolean = false ):void
		{
			var state:State = new State( key, reserved );
			state.value = _baseTwo << _states.length;
			_states.push( state );
		}
		
		public function removeState( key:String ):void
		{
			for ( var i:int = 0; i < _states.length; ++i )
				if ( _states[i].key  == key )
					_states.splice( i, 1 );
		}
						
		public function get state():IState
		{
			return _state;
		}
						
		/**				
		 * Set the state key. This method will adhere to the reserved vs non-reserved rules.
		 * Reserved states are not mutually exclusive, they are allowed to co exist with non-reserved 
		 * and other reserved states. 
		 */
		public function set stateKey( key:String ):void
		{
			var state:IState = stateByKey( key );
			if ( state )
			{
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
			else
			{
				_state.key = "";
				_state.value = 0;
			}
		}

		/**
		 * Contains the concatenated keys of all states which bits are true, i.e. 1 and not 0.
		 * Non-reserved states are mutually exclusive whereas reserved states is allowed to 
		 * co-exist with both reserved and non-reserved states. This String key will reflect this logic.
		 */
		public function get stateKey():String
		{
			var str:String = "";
			for ( var i:int = 0; i < _states.length; ++i ) 
				if (( _state.value & _states[i].value ) == _states[i].value )
					str += _states[i].key;			
			return str;
		}

		/**
		 * Get the current state base 2 value.
		 */
		public function get stateValue():Number
		{
			return _state.value;
		}		
		
		/**
		 * Return all state keys as Array.
		 */
		public function get stateKeys():Array
		{
			var arr:Array = [];
			for ( var i:int = 0; i < _states.length; ++i ) 
				if (( _state.value & _states[i].value ) == _states[i].value )
					arr.push( _states[i].key );			
			return arr;		
		}
		
		/**
		 * Returns a list of past states including the current state.
		 */
		public function get history():Array
		{
			return _history;
		}
				
		/**
		 * Returns the state before the current state, i.e. the last state in the history list.
		 */
		public function previousState():IState
		{
			if ( _history.length > 0 )
				return _history[ _history.length > 1 ? _history.length - 2 : 0 ];
			else
				return null; 
		}

		/**
		 * Use compare if the order of the concatenated states shouldn't matter. 
		 * Thus compare will return true if the state "abc" is compare to "cba".  
		 */
		public function compare( value:String ):Boolean 
		{
			for ( var i:int = 0; i < _states.length; ++i )
				if (( _state.value & _states[i].value ) == _states[i].value )
					if ( value.indexOf( _states[i].key ) != -1 )
						return true;
			return false;					
		}
		
		public function hasState( key:String ):Boolean
		{
			for ( var i:int = 0; i < _states.length; ++i ) 
				if ( _states[i].key == key )
					return true;
			return false;
		}

		public function purge():void
		{
			for ( var i:int = 0; i < _states.length; ++i )
				delete _states[i];
				
			for ( var k:int = 0; k < _history.length; ++k )
				delete _history[k];
			
			_state = null;
			_states = null;
			_history = null;
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
