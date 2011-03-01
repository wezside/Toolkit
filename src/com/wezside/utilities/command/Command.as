package com.wezside.utilities.command {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author Sean Lailvaux
	 */
	public class Command extends EventDispatcher implements ICommand {


		public function execute( event : Event ) : void {
			//
		}

		public function purge() : void {
			//
		}
		
		public function cancel() : void {}
	}
}