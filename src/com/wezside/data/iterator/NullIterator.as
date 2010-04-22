package com.wezside.data.iterator 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class NullIterator implements IIterator 
	{
		public function reset():void
		{
		}
		
		public function next():Object
		{
			return null;
		}
		
		public function hasNext():Boolean
		{
			return false;
		}
		
		public function index():int
		{
			return 0;
		}
		
		public function length():uint
		{
			return 0;
		}
	}
}
