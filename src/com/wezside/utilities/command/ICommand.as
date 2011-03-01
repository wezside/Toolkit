// Generated from  wezside.toolkit.0.1.0205.swc
package com.wezside.utilities.command {
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public interface ICommand extends IEventDispatcher {
		function execute(event : Event) : void;

		function purge() : void;
		function cancel() : void;
	}
}
