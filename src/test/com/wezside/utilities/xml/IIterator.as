package test.com.wezside.utilities.xml 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public interface IIterator 
	{
		
		function reset():void;
		function next():Object;
		function hasNext():Boolean;
		
	}
}
