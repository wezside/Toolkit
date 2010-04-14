package test.com.wezside.utilities.xml 
{

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
