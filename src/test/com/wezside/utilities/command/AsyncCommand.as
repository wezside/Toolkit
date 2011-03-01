package test.com.wezside.utilities.command
{
	import com.wezside.utilities.command.Command;
	import com.wezside.utilities.command.CommandEvent;

	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * @author Sean Lailvaux
	 */
	public class AsyncCommand extends Command
	{
		private var delay:uint;

		override public function execute( event:Event ):void
		{
			trace( "AsyncCommand: " + event );
			delay = setTimeout( completed, 3000, event );
		}

		private function completed( event:Event ):void
		{
			clearTimeout( delay );

			var commandEvent:CommandEvent = new CommandEvent( CommandEvent.COMPLETE );
			commandEvent.commandClass = AsyncCommand;
			dispatchEvent( commandEvent );
		}
	}
}