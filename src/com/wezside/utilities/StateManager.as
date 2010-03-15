package com.wezside.utilities 
{

	/**
	 * @author Wesley.Swanepoel
	 * 
	 *  	Have A Go Module: States
	 *		=======================
	 *			
	 *		0	 // 00000000 Not Logged In
	 *		1	 // 00000001 Logged In
	 *		2	 // 00000010 Show Register
	 *		4	 // 00000100 Show Moment
	 *		8    // 00001000 Show All Comments      
	 *		16   // 00010000 Show Single Comment
	 *		33   // 00100001 Create Moment (depends on 1)
	 *		65   // 01000001 Create Comment (depends on 1)
	 *		128  // 10000000 Search Moment
	 *		
	 *  getPreviousState() Usecase for clicking on moment, comment and then close:
	 *  
	 *  XOR  
	 *      00001101 (8+4+1)				
	 *    ^ 00001000 (8)						
	 *      --------
	 *      00000101 (5)	
	 *  
	 *  
	 *  Logout usecase:  
	 *  	 00001001 (1)
	 *     & 00001000 (0)
	 *       --------
	 *       00001000 (0)
	 *  
	 *  OR:
	 *  	1101				00001100
		  | 0100			|	00000100
		  ------				--------
  			0100				00000100
  			 
	 *	Further Reading on Bitwise operators:		 
	 *  http://www.moock.org/asdg/technotes/bitwise/
	 *  
	 *  TODO: Implement an addState() method to dynamically push states into the manager as oppose to having const with values base 2 just adding
	 *  	  up and up. The const usage is not feasible for larger projects with a large amount of states. It works well for identification of state
	 *  	  but not for creating multiples. Maybe the addState uses a string identifier which is mapped to the base 2 equivelent.
	 *  	  
	 *  	  Example:
	 *  	  addState( key:String, reserved:Boolean = false ); 
	 */
	public class StateManager 
	{
		
		
		private static var _state:Number = 0;	
		private static var _history:Array = [];
		private static var _credentialState:Number;

		
		public static function setState( value:Number, data:* = null ):Number
		{
			_state = value ^ _credentialState;
			if ( _history[ _history.length - 1  ] != value )
				_history.push( _state );
			return _state;
		}
		
		public static function setCredentialState( value:Number ):Number
		{
			_credentialState = value == 1 ? _credentialState | value : _credentialState & value;
			_state = _state ^ _credentialState;
			return _state;
		}
		
		public static function getState():Number
		{
			return _state;
		}
		
		public static function getStateFlag( value:Number ):Number
		{
			return _state & value;
		}
		
		public static function getStateData( historyIndex:int ):*
		{
			return _history[ historyIndex ].data;
		}

		public static function getPreviousState():Number
		{
			 _history.pop();
			return isNaN( _history[ _history.length - 1 ] ) ? 2 : _history[ _history.length - 1 ];
		}
	}
}
