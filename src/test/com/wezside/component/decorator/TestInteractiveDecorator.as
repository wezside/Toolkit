package test.com.wezside.component.decorator
{
	import com.wezside.component.UIElementState;
	import flash.events.MouseEvent;
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;

	import com.wezside.component.decorator.interactive.IInteractive;
	import com.wezside.component.decorator.interactive.Interactive;

	import org.flexunit.async.Async;

	import flash.events.Event;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestInteractiveDecorator
	{
		private var interactive:Interactive;
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			Async.proceedOnEvent( this, prepare( IInteractive ), Event.COMPLETE );	
		}
		
		[After]
		public function tearDown():void
		{
		}
				
		[Test(async)]
		public function testActivate():void
		{
			
			// Collaborators
			var decorator:IInteractive = strict( IInteractive );
		
			// Expectations
			mock( decorator ).setter( "buttonMode" ).arg( true );
			mock( decorator ).setter( "mouseChildren" ).arg( false );
			mock( decorator ).setter( "state" ).arg( UIElementState.STATE_VISUAL_UP );
			mock( decorator ).method( "addEventListener" ).args( "rollOver", Function );
			mock( decorator ).method( "addEventListener" ).args( "rollOut", Function );
			mock( decorator ).method( "addEventListener" ).args( "mouseDown", Function );
			mock( decorator ).method( "addEventListener" ).args( "mouseUp", Function );
			mock( decorator ).method( "addEventListener" ).args( "click", Function );
						
			interactive = new Interactive( decorator );
			interactive.activate();
			interactive.addEventListener( MouseEvent.CLICK, Async.asyncHandler( this, clickHandler, 3000 ));
			mock( decorator ).dispatches( new MouseEvent( MouseEvent.CLICK ));
		}

		private function clickHandler():void
		{
			
		}
		
	}
}
