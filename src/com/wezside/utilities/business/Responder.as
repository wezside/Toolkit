package com.wezside.utilities.business 
{
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Responder extends Sprite implements IResponder 
	{
		
		private var _resultFlag:Boolean;

		public function fault( event:ResponderEvent ):void
		{
			_resultFlag = false;
		}
		
		public function result( event:ResponderEvent ):void
		{
			_resultFlag = true;
		}
		
		public function get resultFlag():Boolean
		{
			return _resultFlag;
		}
		
		public function set resultFlag( value:Boolean ):void
		{
			_resultFlag = value;
		}
	}
}
