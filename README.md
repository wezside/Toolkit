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

		var itemA:IAccordionItem = new AccordionItem();
		itemA.header = headerDisplayObject;
		itemA.content = contentDisplayObject; 
			
		var acc:Accordion = new Accordion();
		acc.addItem( itemA );
		addChild( acc );

StateManager
------------

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


		manager.push( id, mc );
		manager.push( id, mc );
		manager.push( id, mc );
		manager.push( id, mc );
		manager.playPolicy = TimelineManager.PLAY_POLICY_SEQUENTIAL; 
		manager.play();
