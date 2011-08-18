package com.wezside.utilities.command
{
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.collection.LinkedListCollection;
	import com.wezside.data.collection.LinkedListNode;
	import com.wezside.data.iterator.IIterator;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class CommandMapper extends EventDispatcher implements ICommandMapper
	{
		private var sequencedEvents:Array;
		private var commandsList:LinkedListCollection;
		private var currentGroupID:String;
		private var currentElement:CommandElement;
		private var _debug:Boolean = false;

		public function CommandMapper()
		{
			commandsList = new LinkedListCollection();
			addCommand( CommandEvent.SEQUENCE, CommandMapper );
		}

		public function hasCommand( id:String ):Boolean
		{
			if ( commandsList == null ) return false;
			return commandsList.find( "eventType", id ) ? true : false;
		}

		public function addCommand( id:String, commandClass:Class, groupID:String = "", callbackEvents:ICollection = null ):void
		{
			if ( commandsList.length > 0 && commandsList.find( "eventType", id ) )
			{
				throw new Error( id + " already mapped to " + commandClass );
			}

			var element:CommandElement = new CommandElement();
			element.id = id;
			element.eventType = id;
			element.callbackEvents = callbackEvents;
			element.commandClass = commandClass;
			element.groupID = groupID;
			element.callback = function( event:Event ):void
			{
				execute( event, commandClass, groupID );
			};

			// add command
			commandsList.addElement( element );
			addEventListener( element.eventType, element.callback, false, 0, true );
		}

		public function purge():void
		{
			if ( commandsList )
			{
				var it:IIterator = commandsList.iterator();
				var element:CommandElement;
				while ( it.hasNext() )
				{
					element = CommandElement( LinkedListNode( it.next() ).data );
					if ( element && element.callback && element.eventType )
					{
						removeEventListener( element.eventType, element.callback, false );
						element.callback = null;
						if ( element.callbackEvents )
							element.callbackEvents.purge();
						element.callbackEvents = null;
						element.commandClass = null;
						element.eventType = null;
						element.groupID = null;
						element = null;						
					}
					
				}
				it.reset();
				it.purge();
				it = null;
				commandsList.purge();
				commandsList = null;
			}
			sequencedEvents = new Array();
			sequencedEvents = null;
		}
		
		public function purgeCommand( id:String ):void
		{ 
			var element:CommandElement = commandsList.find( "id", id ) as CommandElement;
			if ( !element ) return;
			else commandsList.removeElement( "id", id );
			log( "Trying to purge command", id, element, element.instance );
								
			var command:ICommand = element.instance;
			if ( command )
			{
				log( "Purging command instance", id );
				removeEventListener( element.eventType, element.callback, false );				
				element.callback = null;
				if ( element.callbackEvents )
				{
					element.callbackEvents.purge();
					element.callbackEvents = null;
				}
				element.commandClass = null;
				element.eventType = null;
				element.groupID = null;
				element = null;
				command.cancel();
				command.purge();
				command = null;
			}			 
			else
				element = null;			 
		}
		
		public function log( ...args ):void
		{
			var str:String = "";
			for ( var i:int = 0; i < args.length; ++i ) 
				str += args[i] + " ";
			if ( _debug ) trace( str );
		}							

		public function get debug():Boolean
		{
			return _debug;
		}
		
		public function set debug( value:Boolean ):void
		{
			_debug = value;
		}

		private function execute( event:Event, commandClass:Class, groupID:String ):void
		{
			switch ( event.type )
			{
				case CommandEvent.SEQUENCE :
					sequenceEvents( event );
					break;
				default :
//					purgeCommand( event.type );
					
					var command:ICommand = ICommand( new commandClass() );
					command.addEventListener( CommandEvent.COMPLETE, commandComplete );
					
					// Add custom callback event listeners
					var commandElement:CommandElement = commandsList.find( "id", event.type ) as CommandElement;
					if ( commandElement && commandElement.callbackEvents )
					{
						var it:IIterator = commandElement.callbackEvents.iterator();
						while ( it.hasNext() )
						{
							var object:Object = it.next();
							command.addEventListener( object.type, object.listener, false, 0 );
						}
						it.purge();
						it = null;
						commandElement.instance = command;
						currentElement = commandsList.find( "id", event.type ) as CommandElement;
					}
					else if ( commandElement ) commandElement.instance = command;
					command.execute( event );
					break;
			}
		}

		private function sequenceEvents( event:Event ):void
		{
			sequencedEvents = [];
			currentGroupID = "";

			var events:Array = eventTypesFromGroupID( CommandEvent( event ).groupID );
			if ( events && events.length > 0 )
			{
				if ( CommandEvent( event ).asynchronous )
				{
					sequencedEvents = events;
					currentGroupID = CommandEvent( event ).groupID;
					dispatchEvent( new Event( events[0] ) );
				}
				else
				{
					var i:int;
					var len:int = events.length;
					for ( i = 0; i < len; ++i )
						dispatchEvent( new Event( events[i] ));

					dispatchEvent( new CommandEvent( CommandEvent.SEQUENCE_COMPLETE, false, false, CommandEvent( event ).groupID ));
				}
			}
		}

		private function eventTypesFromGroupID( groupID:String ):Array
		{
			var it:IIterator = commandsList.iterator();
			var element:CommandElement;
			var events:Array = new Array();
			while ( it.hasNext() )
			{
				element = CommandElement( LinkedListNode( it.next() ).data );
				if ( element && element.groupID == groupID )
				{
					events.push( element.eventType );
				}
			}
			it.reset();
			it.purge();
			it = null;
			return events;
		}

		private function commandComplete( event:CommandEvent ):void
		{
			super.dispatchEvent( event );

			if ( sequencedEvents && sequencedEvents[0] == event.type )
			{
				sequencedEvents.shift();

				if ( sequencedEvents.length > 0 )
				{
					dispatchEvent( new Event( sequencedEvents[0] ) );
				}
				else
				{
					dispatchEvent( new CommandEvent( CommandEvent.SEQUENCE_COMPLETE, false, false, currentGroupID ));
				}
			}
		}

		public function willTriggerCallback( id:String, callbackEventID:String ):Boolean
		{
			var element:CommandElement = commandsList.find( "id", id ) as CommandElement;
			if ( element && element.callbackEvents )
			{
				var command:ICommand = element.instance as ICommand;
				if ( command )
				{
					return command.willTrigger( callbackEventID );
				}
			}
			return false;
		}
	}
}