package test.com.wezside.utilities.command 
{
	import com.wezside.utilities.command.Command;

	import flash.events.Event;

	/**
	 * @author Sean Lailvaux
	 */
	public class SampleCommand extends Command {
		
		
		override public function execute( event : Event ) : void {
			trace( "SampleCommand: " + event );
		}
	}
}