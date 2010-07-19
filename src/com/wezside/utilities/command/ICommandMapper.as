package com.wezside.utilities.command {

	public interface ICommandMapper {
		
		function addCommand( eventType : String, commandClass : Class, groupID : String = "" ) : void;		function removeCommand( eventType : String ) : void;
		function purge() : void;
	}
}