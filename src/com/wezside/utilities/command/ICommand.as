package com.wezside.utilities.command {
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * @author Sean Lailvaux
	 */
	public interface ICommand extends IEventDispatcher {
		
		function execute( event : Event ) : void;		function purge() : void;
	}
}