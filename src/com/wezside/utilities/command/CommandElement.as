package com.wezside.utilities.command {

	/**
	 * @author Sean Lailvaux
	 */
	public class CommandElement {
		
		public var id : String;		public var eventType : String;
		public var commandClass : Class;
		public var groupID : String;
		public var callback : Function;
		
		
		public function CommandElement() {
			groupID = "";
		}
	}
}