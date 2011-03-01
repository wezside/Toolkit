package com.wezside.utilities.command {
	import com.wezside.data.collection.ICollection;
	public class CommandElement extends Object {
		public var id : String;
		public var eventType : String;
		public var commandClass : Class;
		public var groupID : String;
		public var callbackEvents : ICollection;
		public var constructor : Function;
		public var callback:Function;
		public var instance:ICommand;
	}
}
