package test.com.wezside.utilities.xml 
{
	import com.wezside.utilities.iterator.IDeserializable;

	/**
	 * @author Wesley.Swanepoel
	 */
	[Bindable(event="bindingPropertyChange")]
	public class TestPrefix implements IDeserializable 
	{
		
		public var id:String;
		
		public var url:String;
		
	}
}
