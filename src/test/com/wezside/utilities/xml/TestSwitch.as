package test.com.wezside.utilities.xml 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	[Bindable(event="bindingPropertyChange")]
	public class TestSwitch implements IDeserializable 
	{
		
		public var id:String;
		
		public var visible:String;
		
		public var quality:String;
		
	}
}
