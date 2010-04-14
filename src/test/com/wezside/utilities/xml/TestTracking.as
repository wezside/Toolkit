package test.com.wezside.utilities.xml 
{
	import com.wezside.utilities.iterator.IDeserializable;

	/**
	 * @author Wesley.Swanepoel
	 */
	[Bindable(event="bindingPropertyChange")]
	public class TestTracking implements IDeserializable 
	{
		
		public var items:Array;
		
	}
}
