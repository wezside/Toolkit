package test.com.wezside.utilities.command.event 
{
	import flash.events.Event;

	/**
	 * @author Sean Lailvaux
	 */
	public class SampleEvent extends Event {
		
		public static const SAMPLE_1_EVENT : String = "SAMPLE_1_EVENT";		public static const SAMPLE_2_EVENT : String = "SAMPLE_2_EVENT";		public static const SAMPLE_3_EVENT : String = "SAMPLE_3_EVENT";		public static const SAMPLE_4_EVENT : String = "SAMPLE_4_EVENT";		
		
		public function SampleEvent( type : String ) {
			super( type );
		}
		
		override public function clone() : Event {
			return new SampleEvent( type );
		}
	}
}
