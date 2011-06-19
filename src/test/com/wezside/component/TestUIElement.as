package test.com.wezside.component
{
	import com.wezside.component.UIElementState;
	import org.flexunit.asserts.assertEquals;
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	import mockolate.verify;

	import com.wezside.component.IUIElement;
	import com.wezside.component.UIElement;
	import com.wezside.component.decorator.interactive.IInteractive;

	import org.flexunit.async.Async;

	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestUIElement
	{
		 
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			Async.proceedOnEvent( this, prepare( IUIElement, IInteractive ), Event.COMPLETE );	
		}
		
		[After] 
		public function tearDown():void
		{
		}
				
		/**
		 * Behaviour verification test.
		 */ 				
		[Test]
		public function testSetup():void
		{
			// Set up Collaborators
			var ui:IUIElement = strict( IUIElement );
			
			// Expectations
			mock( ui ).method( "build" );
			mock( ui ).method( "setStyle" );
			mock( ui ).method( "arrange" );
						
			ui.build();
			ui.setStyle();
			ui.arrange();
		
			verify ( ui );
		}
		
		[Test]
		public function testActivate():void
		{			
			// Collaborators
			var decorator:IInteractive = strict( IInteractive );
			
			// Expectation
			mock( decorator ).setter( "buttonMode" ).arg( true );
			mock( decorator ).setter( "mouseChildren" ).arg( false );
			mock( decorator ).method( "activate" );
			mock( decorator ).method( "addEventListener" ).args( "rollOver", Function );
			mock( decorator ).method( "addEventListener" ).args( "rollOut", Function );
			mock( decorator ).method( "addEventListener" ).args( "mouseDown", Function );
			mock( decorator ).method( "addEventListener" ).args( "mouseUp", Function );			
			mock( decorator ).method( "addEventListener" ).args( "click", Function );
		
			mock( decorator ).method( "click" ).args( new MouseEvent( MouseEvent.CLICK ));	
			mock( decorator ).dispatches( new MouseEvent( MouseEvent.CLICK ));
			mock( decorator ).asEventDispatcher().eventDispatcher.dispatchEvent( new MouseEvent( MouseEvent.CLICK ));
			
			// Actual
			var ui:UIElement = new UIElement();
			ui.interactive = decorator;
			ui.build();
			ui.setStyle();
			ui.arrange();
			ui.activate();
			
			assertEquals( ui.state, UIElementState.STATE_VISUAL_UP );
		}
	}
}
