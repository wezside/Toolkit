package com.wezside.utilities.command {
	import com.wezside.data.collection.LinkedListCollection;
	import com.wezside.data.collection.LinkedListNode;
	import com.wezside.data.iterator.IIterator;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class CommandMapper extends EventDispatcher implements ICommandMapper {
		
		private var sequencedEvents : Array;
		private var commandsList : LinkedListCollection;		private var currentCommand : ICommand;		private var currentGroupID : String;
		
		
		public function CommandMapper() {
			commandsList = new LinkedListCollection();
			addCommand( CommandEvent.SEQUENCE, CommandMapper );
		}
		
		public function hasCommand( eventType : String ) : Boolean {
			if ( commandsList == null ) return false;
			return commandsList.find( eventType ) ? true : false;
		}
		
		public function addCommand( eventType : String, commandClass : Class, groupID : String = "" ) : void {
			
			if ( commandsList.length > 0 && commandsList.find( eventType ) ) {
				throw new Error( eventType + " already mapped to " + commandClass );
			}
			
			var element : CommandElement = new CommandElement();
			element.id = eventType;			element.eventType = eventType;			element.commandClass = commandClass;			element.groupID = groupID;
			element.callback = function( event : Event ) : void {
				execute( event, commandClass , groupID );
			};
			
			// add command
			commandsList.addElement( element );			
			addEventListener( element.eventType, element.callback, false, 0, true );
		}
		
		public function removeCommand( eventType : String ) : void {
			
			if ( commandsList ) {
				
				var it : IIterator = commandsList.iterator();
				
				var element : CommandElement;
				while ( it.hasNext() ) {
					element = CommandElement( LinkedListNode( it.next() ).data );
					if ( element && element.callback && element.eventType == eventType ) {
						removeEventListener( element.eventType, element.callback, false );
						commandsList.removeElement( element.id );
						element.eventType = "";						element.callback = null;
						element.commandClass = null;
					}
				}
				element = null;
				it.reset();
				it.purge();
				it = null;
			}
		}
		
		public function purge() : void {
			
			purgeCurrentCommand();
			
			if ( commandsList ) {
				var it : IIterator = commandsList.iterator();
				var element : CommandElement;
				while ( it.hasNext() ) {
					element = CommandElement( LinkedListNode( it.next() ).data );
					if ( element && element.callback && element.eventType ) {
						removeEventListener( element.eventType, element.callback, false );
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
		
		private function execute( event : Event, commandClass : Class, groupID : String ) : void {
			
			switch ( event.type ) {
				
				case CommandEvent.SEQUENCE : 
					sequenceEvents( CommandEvent( event ) );
					break;
					
				default : 
					
					if ( groupID != "" ) {
						purgeCurrentCommand();
						currentCommand = ICommand( new commandClass() );
						currentCommand.addEventListener( CommandEvent.COMPLETE, commandComplete );
						currentCommand.execute( event );
					}
					else {
						ICommand( new commandClass() ).execute( event );
					}
					break;
			}
		}
		
		private function purgeCurrentCommand() : void {
			if ( currentCommand ) {
				currentCommand.removeEventListener( CommandEvent.COMPLETE, commandComplete );
				currentCommand.purge();
				currentCommand = null;
			}
		}
		
		private function sequenceEvents( event : CommandEvent ) : void {
			
			sequencedEvents = new Array();
			currentGroupID = "";
			
			var events : Array = eventTypesFromGroupID( event.groupID );
			
			if ( events && events.length > 0 ) {
				
				if ( event.asynchronous ) {
					sequencedEvents = events;
					currentGroupID = event.groupID;
					dispatchEvent( new Event( events[0] ) );
				}
				else {
					
					var i : int;
					var len : int = events.length;
					for ( i=0; i<len; ++i ) {
						dispatchEvent( new Event( events[i] ) );
					}
					
					dispatchEvent( new CommandEvent( CommandEvent.SEQUENCE_COMPLETE, event.groupID ) );
				}
			}
		}
		
		private function eventTypesFromGroupID( groupID : String ) : Array {
			var it : IIterator = commandsList.iterator();
			var element : CommandElement;
			var events : Array = new Array();
			while ( it.hasNext() ) {
				element = CommandElement( LinkedListNode( it.next() ).data );
				if ( element && element.groupID == groupID ) {
					events.push( element.eventType );
				}
			}
			it.reset();
			it.purge();
			it = null;
			return events;
		}
		
		private function commandComplete( event : CommandEvent ) : void {
			
			purgeCurrentCommand();
			
			if ( sequencedEvents && sequencedEvents[0] == event.commandEventType ) {
				
				sequencedEvents.shift();
				
				if ( sequencedEvents.length > 0 ) {
					dispatchEvent( new Event( sequencedEvents[0] ) );
				}
				else {
					dispatchEvent( new CommandEvent( CommandEvent.SEQUENCE_COMPLETE, currentGroupID ) );
				}
			}
		}
	}
}