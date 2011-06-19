package test.com.wezside.component.decorator
{
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;

	import com.wezside.component.IUIElement;
	import com.wezside.component.UIElementEvent;
	import com.wezside.component.UIElementState;
	import com.wezside.component.decorator.interactive.Interactive;

	import org.flexunit.async.Async;

	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestInteractiveDecorator
	{
		private var interactive:Interactive;
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			Async.proceedOnEvent( this, prepare( IUIElement ), Event.COMPLETE );	
		}
		
		[After]
		public function tearDown():void
		{
		}
				
		[Test(async)]
		public function testActivate():void
		{
			
			// Collaborators
			var decorator:IUIElement = strict( IUIElement );
		
			// Expectations
			mock( decorator ).setter( "buttonMode" ).arg( true );
			mock( decorator ).setter( "mouseChildren" ).arg( false );
			mock( decorator ).setter( "state" ).arg( UIElementState.STATE_VISUAL_UP );
			mock( decorator ).method( "addEventListener" ).args( "rollOver", Function );
			mock( decorator ).method( "addEventListener" ).args( "rollOut", Function );
			mock( decorator ).method( "addEventListener" ).args( "mouseDown", Function );
			mock( decorator ).method( "addEventListener" ).args( "mouseUp", Function );
			mock( decorator ).method( "addEventListener" ).args( "click", Function );
			mock( decorator ).method( "addEventListener" ).args( UIElementEvent.STATE_CHANGE, Function );

						
			interactive = new Interactive( decorator );
			interactive.activate();
//			interactive.click( new MouseEvent( MouseEvent.CLICK ));
//			mock( decorator ).asEventDispatcher().eventDispatcher.dispatchEvent( new MouseEvent( MouseEvent.CLICK ));
			
		}
	}
}
