package test.com.wezside.utilities.xml 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface ICollection 
	{
		function iterator():IIterator;
		function find( value:String ):IDeserializable;
	}
}
