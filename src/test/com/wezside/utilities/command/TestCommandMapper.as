package test.com.wezside.utilities.command 
{
	import flexunit.framework.Assert;

	import test.com.wezside.utilities.command.event.SampleEvent;

	import com.wezside.utilities.command.CommandEvent;
	import com.wezside.utilities.command.CommandMapper;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.async.Async;

	/**
	 * @author Sean Lailvaux
	 */
	public class TestCommandMapper {
		
		private var commandMapper : CommandMapper;
		
		
		[Before]
		public function setUp() : void {
			commandMapper = new CommandMapper();
		}
		
		[After]
		public function tearDown() : void {
			commandMapper.purge();
			commandMapper = null;
		}
		
		[Test]
		public function testRemoveCommand():void
		{
			commandMapper.addCommand( SampleEvent.SAMPLE_2_EVENT, AsyncCommand, "mySequence" );
			commandMapper.addCommand( SampleEvent.SAMPLE_3_EVENT, AsyncCommand, "mySequence" );
			commandMapper.addCommand( SampleEvent.SAMPLE_4_EVENT, AsyncCommand, "mySequence" );
			
			// remove an event from the mapper
			commandMapper.debug = true;
			commandMapper.purgeCommand( SampleEvent.SAMPLE_3_EVENT );	
			assertFalse( commandMapper.hasCommand( SampleEvent.SAMPLE_3_EVENT ));			
		}
		
		[Test]
		public function testPurgeAll():void
		{
			commandMapper.addCommand( SampleEvent.SAMPLE_2_EVENT, AsyncCommand, "mySequence" );
			commandMapper.addCommand( SampleEvent.SAMPLE_3_EVENT, AsyncCommand, "mySequence" );
			commandMapper.addCommand( SampleEvent.SAMPLE_4_EVENT, AsyncCommand, "mySequence" );
			
			// remove an event from the mapper
			commandMapper.debug = true;
			commandMapper.purge();	
			assertFalse( commandMapper.hasCommand( SampleEvent.SAMPLE_2_EVENT ));			
			assertFalse( commandMapper.hasCommand( SampleEvent.SAMPLE_3_EVENT ));			
			assertFalse( commandMapper.hasCommand( SampleEvent.SAMPLE_4_EVENT ));			
		}
		
		[Test(async)]
		public function testCommandMapper() : void {
			
			commandMapper.addCommand( SampleEvent.SAMPLE_2_EVENT, AsyncCommand, "mySequence" );
			commandMapper.addCommand( SampleEvent.SAMPLE_3_EVENT, AsyncCommand, "mySequence" );
			commandMapper.addCommand( SampleEvent.SAMPLE_4_EVENT, AsyncCommand, "mySequence" );
			
			commandMapper.addEventListener( CommandEvent.SEQUENCE_COMPLETE, Async.asyncHandler( this, ready, 15000, null, timeout ), false, 0, true );
			
			// dispatch a sequence of command
			commandMapper.dispatchEvent( new CommandEvent( CommandEvent.SEQUENCE, false, false, "mySequence", false ) );
		}
		
		protected function ready( event:CommandEvent, object:Object ):void
		{
			assertEquals( "mySequence", event.groupID  );
		}		
		
		protected function timeout( object:Object ):void
		{
		   	Assert.fail( "Pending Event Never Occurred" );
		}			
	}
}