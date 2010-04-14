package test.com.wezside.utilities.xml 
{
	import com.wezside.utilities.iterator.IDeserializable;

	/**
	 * @author Wesley.Swanepoel
	 */
	[Bindable(event="bindingPropertyChange")]
	public class TestShare implements IDeserializable
	{
		
		[Required]
		public var label:String;
		
		public var items:Array;
	}
}
