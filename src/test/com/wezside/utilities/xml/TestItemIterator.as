package test.com.wezside.utilities.xml 
{
	import com.wezside.utilities.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestItemIterator implements IIterator 
	{
		
		private var _index:uint = 0;
		private var _collection:Array;
		
		
		public function TestItemIterator( collection:Array ) 
		{
			_collection = collection;
		}		
		
		public function reset():void
		{
			_index = 0;
		}
		
		public function next():Object
		{
			return _collection[ _index++ ];
		}
		
		public function hasNext():Boolean
		{
			return _index < _collection.length;
		}
	}
}
