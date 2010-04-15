package com.wezside.utilities.binding 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class BindingCollection implements IBindableCollection 
	{
		private var _collection:Array;

		public function BindingCollection() 
		{
			_collection = [];	
		}
		
		public function iterator():IBindingIterator
		{
			return new BindingIterator( _collection );
		}

		public function addElement( value:BindingMap ):void 
		{
			_collection.push( value );	
		}
		
		public function find(value:String):Object
		{
			// TODO: Auto-generated method stub
			return null;
		}
	}
}
