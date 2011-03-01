package com.wezside.utilities.command
{
	import com.wezside.data.collection.ICollection;

	public interface ICommandMapper
	{
		function addCommand( eventType:String, commandClass:Class, groupID:String = "", callbackEvents:ICollection = null ):void
//		function removeCommand( eventType:String ):void;
		
		function purge():void;
		function purgeCommand( id:String ):void;
	}
}
