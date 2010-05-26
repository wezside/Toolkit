Wezside Toolkit
===============

This is a hub for components I've written and re-use quite often. All components are based on a component architecture with the core being 
UIElement. Read more on UIElement below.

Latest release 
=======

* Build 0.1.0123
* Compiled with Flex 4 SDK build 14159 


Change log since build .0100
=======
* Fixed bug with setStyle() on UIElement with no styleName set
* UIElement purge() updated to remove scroll, arrange listener and stateManager purge()
* UIElement addChildAt() and addUIChildAt() methods added
* New Button + Label components added - better support for decorators through CSS 
* New decorator added: Interactive - changes any UIElement into a button. 
* Added support for automatically assigning Class names as styleNames
* Removed inheritCSS and parent injection of styleName and styleManager to children. Explicitely set what is needed on each UIElement instead. This proves
cleaner code and more readable from a third perspective.
* Refactor addSuperChild and remvoeSuperChild to addUIChild and removeUIChild to avoid confusion.
* UIELement update() method removed and no recursion. SetStyle() will still use its rules to inject styleManager instance and the 
inheritance of the parent styleName
* Basic Vertical Scroll decorator implemented
* Support for automatic CSS  prop lookup  in StyleManager
* Modulo inject styleManager instance into IModule 
* Swapped hierarchy of skin DisplayObject and childContainer
* StateManager fixed compare bug
* Added setSize( w, h ) method for UIElementSkin 
* Expose StateManager property in UIElement

Component 
=======
Component

* [Accordion](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/sample/accordion/AccordionAdvanced.mxml "Accordion")
* [Gallery](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/sample/gallery/GalleryBasic.as "Gallery")
* [UIElement](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/components/UIElement.as "UIElement")

Utilities
=======

* [DateUtil](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/date/DateUtil.as "DateUtil") 
* [FileUpload](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/file/FileUpload.as "FileUpload") 
* [FileUtil](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/file/FileUtil.as "FileUtil") 
* [FlashVars](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/flashvars/FlashVars.as "FlashVars") 
* [ImageResize](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/imaging/ImageResize.as "ImageResize") 
* [Reflection](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/imaging/Reflection.as "Reflection") 
* [SharedObjUtil](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/sharedobj/SharedObjUtil.as "SharedObjUtil") 
* [StateManager](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/manager/state/StateTest.as "StateManager") 
* [StringUtil](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/string/StringUtil.as "StringUtil") 
* [StyleManager](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/manager/style/StyleManager.as "StyleManager") 
* [TimelineManager](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/manager/timeline/TimelineSample.as "TimelineManager")
* [Tracer](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/logging/Tracer.as "Tracer")
* [TrackingUtil](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/tracking/TrackingUtil.as "TrackingUtil")
* [Validator](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/validator/Validator.as "Validator")



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
		
Gallery
-------

A framework for building advanced Gallery components. Supports grid layouts and custom transitions. Useful just as is or with extended functionality. 
The creation policy for this component is to construct and purge a gallery per page. This allows for only loading the images required on screen. This impacts
transitions where it is required to have the next items visible on screen before the current gallery items have been removed. 

[Example](http://www.sony.com/football/#/cfcfootballhd/ "Gallery Example")

		gallery = new Gallery( items, 
							   COLUMNS, 
							   ROWS,
							   0, 						// xOffset
							   0, 						// yOffset
							   2, 						// Horizontal Gap
							   2, 						// Vertical Gap
							   "left", 					// Horizontal Align
							   "custom",				// Click through target
							   1,   					// Reflection Height In Rows
							   0.3, 					// Reflection Alpha
							   Gallery.RESIZE_HEIGHT,	// Resize Policy 
							   80, 						// Resize Value
							   Gallery.DISTRIBUTE_H, 	// Distribute Policy
							   false, 					// Show Arrangement
							   550,  					// Stage width
							   500,  					// Stage height
							   true, 					// Disable CTA for all thumbnails
							   false );					// Debug
		gallery.x = 50;
		gallery.y = 30;
		gallery.addEventListener( GalleryEvent.ARRANGE_COMPLETE, galleryArrangeComplete );
		addChildAt( gallery, 0 );

		
StateManager
------------

A useful class to manage application state. The reserved property on an IState instance is used for 
application state that will only affect itself. Reserved states are not mutually exclusive, they are allowed to co-exist 
with non-reserved and other reserved states. 

		var sm:StateManager = new StateManager();
		sm.addState( "Credentials", true );
		sm.addState( "Register" );
		sm.addState( "List" );
		sm.addState( "Search" );
		sm.addState( "Results" );
		
		sm.state = "Credentials";				// State == 1
		sm.state = "Credentials";				// State == 0
		sm.state = "Credentials";				// State == 1
		sm.state = "Register";					// State == 3
		sm.previousState().key					// Result is "Credentials"	
		sm.state = "Credentials";				// State == 2


TimelineManager
---------------

A simple class to deal with timeline animations. Manage timeline animations playback, removal and 
end frame behaviour. A play policy exist to allow for playing back multiple animations at once or 
in sequence starting at a specific animation or simply play a single (default) animation.


		public function VisualTestTimelineManager()
		{
			tm = new TimelineManager();			
			
			mc1 = new Animation01();
			mc2 = new Animation02();		
			mc3 = new Animation03();
			tm.addEventListener( TimelineEvent.READY, ready );
			tm.addEventListener( TimelineEvent.SEQUENTIAL_COMPLETE, complete );
			tm.addElement( "1", mc1, 0, false,  TimelineManager.CHILD_POLICY_RECURSIVE );
			tm.addElement( "2", mc2, 0, false, TimelineManager.CHILD_POLICY_RECURSIVE );
			tm.addElement( "3", mc3, 0, false, TimelineManager.CHILD_POLICY_RECURSIVE );
												
			addChild( mc3 );
			addChild( mc2 );			
			addChild( mc1 );			
		}

		private function ready( event:TimelineEvent ):void 
		{
			if ( event.total == 3 )
			{
				tm.play();
			}
		}
		
UIElement
---------

A component architecture for pure Actionscript components to allow for easy integration with Modulo's [StyleManager](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/manager/styleManager/StyleManager.as "StyleManager").

*Features*

* Support for visual states and styling through CSS
* Decorator support for shape, layout, interactive and scrollbar


[Modulo](http://github.com/wezside/Modulo "Modulo") 
Supports the auto loading of such a style SWF and injects instances into modules for ease of use.

[VisualTestButton Example](http://github.com/wezside/Toolkit/blob/master/src/test/com/wezside/components/control/VisualTestButton.as  "VisualTestButton")

[StyleManager Example: LatinStyle](http://github.com/wezside/Toolkit/blob/master/src/test/com/wezside/sample/styles/LatinStyle.as  "LatinStyle")


**The UIElement Architecture**

Each UIElement is considered to be a standalone component. The API allows for transformation through CSS and something known as decorator. A decorator simply 
decorates an object (in this case UIElement) into something different. Currently 4 types of decorators exist, ILayout, IShape, IInteractive and IScroll.

*build()* A method used for adding children of a UIElement to the stage in the correct order. Children here refers to decorators and custom added children
*setStyle()* A method used to apply a CSS style. See StyleManager.
*arrange()* A method that arranges children of a UIElement through a layout decorator. 

All UIElement decorators are commutitative. This means the order does not matter. The order of the factory methods (build(), setStyle() and arrange()) does however 
matter. build() is required whereas setStyle() and arrange() is optional based on the usage of the component.

**Example**

A simple example showcasing the usage of the StyleManager and applying a CSS style to a UIElement. The order of the methods build(), setStyle() and arrange() is 
important for the decorators and children of the UIElement. 

	mockUIElement = new MockUIElement();
	mockUIElement.styleName = "title";
	mockUIElement.styleManager = styleManager;
	mockUIElement.build();
	mockUIElement.setStyle();
	mockUIElement.arrange();

**Decorator Vertical Layout Example**

The layout decorator as with any other decorator should always be applied before calling the factory methods build(), setStyle() and arrange(). 

	mockUIElement = new MockUIElement();
	mockUIElement.layout = new VerticalLayout( mockUIElement );
	mockUIElement.build();
	mockUIElement.arrange();
	
**Chaining Decorator Vertical Layout Example**

The layout decorator as with any other decorator should always be applied before calling the factory methods build(), setStyle() and arrange(). 

	mockUIElement = new MockUIElement();
	mockUIElement.layout = new VerticalLayout( mockUIElement );
	mockUIElement.build();
	mockUIElement.arrange();
	
**Decorator Shape for creating a background**

Each UIElement has a pre-built background decorator. It is reserved and therefore will always be at index 0. The background will automatically resize itself based on 
the UIElement's layout decorator if defined. Alternatively the size can be set through *width* and *height* properties. To show a background make sure *colors* and 
*alphas* is set with at least 2 values. Also make sure to call *arrange()* for the background to autosize. 
 
	mockUIElement = new MockUIElement();
	mockUIElement.background = new Rectangle( mockUIElement );
	mockUIElement.background.colours = [ 0, 0 ];
	mockUIElement.background.alphas = [ 1, 1 ];
	mockUIElement.build();
	mockUIElement.arrange();
	
**Decorator Scroll for creating a Vertical Scrollbar**
	mockUIElement = new MockUIElement();
	mockUIElement.scroll = new VScroll( mockUIElement );
	mockUIElement.scroll.scrollHeight = 150; 
	mockUIElement.scroll.horizontalGap = 2;
	mockUIElement.build();
	mockUIElement.arrange();
	
**Interactive Decorator Example**

Each UIElement has a default Interactive decorator which converts its behaviour into a button. 

	mockUIElement = new MockUIElement();
	mockUIElement.build();
	mockUIElement.arrange();
	mockUIElement.activate();

