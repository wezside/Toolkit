package test
{
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;

	import flash.display.Sprite;
	
	public class ToolkitTestRunner extends Sprite
	{
		private var core:FlexUnitCore;
		
		
		public function ToolkitTestRunner()
		{
			super();
			
			core = new FlexUnitCore();
			core.addListener( new TraceListener() );
			core.run( TestSuite );

		}
	}
}