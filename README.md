Wezside Components/Utilities
============================

This is a hub for components I've written and re-use quite often. These include Actionscript and MXML components.

Latest release
=======

* Compiled with Flex 4 SDK build 10434 

Components
=======

* [Accordion](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/sample/accordion/AccordionAdvanced.mxml "Accordion") [Build 0.1.0031]

Utilities [Build 0.1.0012]
=======

* [StateManager](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/sample/stateManager/StateTest.as "StateManager") 
* [TimelineManager](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/sample/timelineManager/TimelineSample.as "TimelineManager")



Accordion
---------

A bare-bones Accordion component. Extend Accordion and AccordionItem to customise this component and add animations when 
state changes.

		var itemA:IAccordionItem = new AccordionItem();
		itemA.header = headerDisplayObject;
		itemA.content = contentDisplayObject; 
			
		var acc:Accordion = new Accordion();
		acc.addItem( itemA );
		addChild( acc );

StateManager
------------

A useful class to manage application state. The reserved property on an IState instance is used for 
application state that will only affect itself. Reserved states are not mutually exclusive, they are allowed to co-exist 
with non-reserved and other reserved states. 

		StateManager.addState( "Credentials", true );
		StateManager.addState( "Register" );
		StateManager.addState( "List" );
		StateManager.addState( "Search" );
		StateManager.addState( "Results" );
		
		StateManager.state = "Credentials";				// State == 1
		StateManager.state = "Credentials";				// State == 0
		StateManager.state = "Credentials";				// State == 1
		StateManager.state = "Register";				// State == 3
		StateManager.previousState()					// Result is "Credentials"	
		StateManager.state = "Credentials";				// State == 2


TimelineManager
---------------

A simple class to deal with timeline animations. Manage timeline animations playback, removal and 
end frame behaviour. A play policy exist to allow for playing back multiple animations at once or 
in sequence starting at a specific animation or simply play a single (default) animation.

		manager.push( id, mc );
		manager.push( id, mc );
		manager.push( id, mc );
		manager.push( id, mc );
		manager.playPolicy = TimelineManager.PLAY_POLICY_SEQUENTIAL; 
		manager.play();
