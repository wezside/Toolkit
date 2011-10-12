Wezside Toolkit
===============

This is a hub for components I've written and re-use quite often. All components are based on a component architecture with the core being 
UIElement. Read more on <a href="#uielement">UIElement</a> below. For Toolkit Components please go to the [Toolkit-Components](https://github.com/wezside/Toolkit-Components) repo. 

[Latest release](https://github.com/wezside/Toolkit/wiki/Latest-Release) 
=======
* Build 0.1.0290
* Compiled with Flex 0.1.0290 SDK build 21328

Documentation
=============

See the [Wiki](https://github.com/wezside/Toolkit/wiki) for all documentation.

Change log since tag 0270
=======

* IScroll updated with thumbHeight
* ICollection addElementAt() method implemented for all collections but LinkedList 
* DateUtil. Easier algorithm for determining the week day a month starts on. 

Change log since tag 0260
=======

* DateUtils extended to calculate daysFromMilliseconds(), hoursFromMilliseconds(), minutesFromMilliseconds(), secondsFromMilliseconds(), calculateStartDayOfTheWeek()

Change log since tag 0250
=======

* StyleManager ready() method removed. Only listening for Event.COMPLETE is accepted to check if StyleManager is ready.  
* XMLDataMapper purge added
* StyleManager now supports multiple CSS files. Simply just call parseCSSByteArray with the difference CSS file. Any duplicate properties will be overwritten, i.e. the last CSS class will be the active one.
* ImageResize refactored to Resizer. Added support to resize to width.

Change log since build 0200
=======

* This repo now only have the core toolkit. For Toolkit Components please go to the [Toolkit-Components](https://github.com/wezside/Toolkit-Components) repo. 
* GalleryComponent: If a data object is set in the individual item then the component will use this data object and pass it to the IGalleryItem. However, if the individual data object for a IGalleryItem is not set, the GalleryClassItem's data object will be used. 
* Collection now supports constructor injection for array provider. Easily convert any array into a Collection.
* ScrollHorizontal updated to reflect change sin ScrollVertical
* Fixed small issue regarding reset in ScrollVertical. ScrollVertical now has resetTrack() and resetThumb() methods 
* Added support for when a UIElement is resized and arrange is called again. 
* Fixed issue regarding the shape decorator not receiving the correct width and height from the UIElement. This was due to different values at different stages when arrange is called more than once. This is now fixed.
* New FlowLayout added. Needs testing though. Use at own risk.
* Updated HorizontalScroll decorator to function properly
* Applied Sean Lailvaux patch to UIElement 
* Changed Gallery ClassCollection to Dictionary to allow overwriting of custom classes. This wasn't working.
* Removed resizeValue property and replaced with thumbWidth and thumbHeight which will be passed to all IGalleryItems 
* Fixed ScrollVertical to update the width correctly
* Switched XMLDatamapper's collection to DictionaryCollection to avoid issues surrounding duplicate node names. If the same parser is used for different XML the same node should be allowed but mapped to different Data Classes. This is now possible.
* Fixed single leaf node mapping in XMLDatamapper to use localName() instead of namespaced name()
* Gallery component refactored to UIElement standard. Use of GridReflectionLayout and DistributeLayout decorator added.
* ICollection clone() and removeElementAt() methods added 
* XMLDataMapper Automatic leaf node mapping to parent variable typed String.
* Fixed XMLDatamapper recursion breaking when leaf node mapping is encountered.

Change log since build 0100
=======

* New Simple Combo component added com.wezside.components.combo.Combo
* New GraphicsEx class added to allow for concatenation of Graphics. Used specifically in ShapeRectangle to allow for chaining.
* Added purge for Scroll decorators. Will be automatically purged when UIELement.purge is called
* ICollection updated to reflect more of a standard approach
* New IDictionaryCollection interface for Dictionary Collections
* Fixed issue when height is less than Scrollheight, the padding was ignored.
* Added namespaces collection to XMLDataMapper. Updated Unit tests to reflect this change.
* Fixed issue with Scroll Decorator in ShapeRectangle. The width of the ShapeRectangle was incorrect.
* FillLayout layout decorator added (still in testing phase)
* XMLDataMapper now includessupport for percentage values in attributes 
* StyleManager has been updated to allow for instantiating the style class and listening for the EVENT.COMPLETE event. Previously the EVENT.COMPLETE was not invoked due to the instantiating happening so quickly.
* Label now supports a few more default properties
* Scale9 issue resolved when setting scale9Grid after arrange() is called. Now you can set either before or after arrange() on a ShapeRectangle Shape decorator.
* Support for scale9grid added to ShapeRectangle
* Rectangle Shape decorator refactored to ShapeRectangle
* Shape decorator width and height properties updated to set Sprite width and height if arrange() has been called before
* New Horizontal scroll decorator added. Minimum requirement is to set scrollWidth as with ScrollVertical where it is scrollHeight
* Fixed bug in XMLDataMapper when mapping nodes with CDATA to text property
* Fixed numChildren methods to return correct values
* Updated Shape decorator to include individual corner radius properties bottomRightRadius, bottomLeftRadius, topRightRadius, topLeftRadius
* Refactored decorators to namespace com.wezside.components.decorators
* Include new Interactive decorator InteractiveSelectable which behaves as a toggle. The default now is single click and button won't stay selected.
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

<a name="uielement"></a>
UIElement
---------

A component architecture for pure Actionscript components to allow for easy integration with Modulo's [StyleManager](http://github.com/wezside/Toolkit/blob/master/src/com/wezside/utilities/manager/styleManager/StyleManager.as "StyleManager").

*Features*

* Support for visual states and styling through CSS
* Decorator support for shape, layout, interactive and scrollbar

**The Architecture**

Each UIElement is considered to be a standalone component. The API allows for transformation through CSS and something known as decorator. A decorator simply 
decorates an object (in this case UIElement) into something different. Think of it as changing the behaviour of an object. 
Currently 4 types of decorators exist, ILayout, IShape, IInteractive and IScroll.

**Factory Methods**

*build()* A method used for adding children of a UIElement to the stage in the correct order. Children here refers to decorators and custom added children

*setStyle()* A method used to apply a CSS style. Requirement for usage is for the properties *styleManager* and *styleName* to be valid. 

*arrange()* A method that arranges children of a UIElement through a layout decorator. 

**UI Decorators**

All UIElement decorators are commutitative. This means the order does not matter. The order of the factory methods (build(), setStyle() and arrange()) does however 
matter. build() is required whereas setStyle() and arrange() is optional based on the usage of the component.

**Simple UI CSS Example**

A simple example showcasing the usage of the StyleManager and applying a CSS style to a UIElement. The order of the methods build(), setStyle() and arrange() is 
important for the decorators and children of the UIElement. 

	mockUIElement = new UIElement();
	mockUIElement.styleName = "title";
	mockUIElement.styleManager = styleManager;
	mockUIElement.build();
	mockUIElement.setStyle();
	mockUIElement.arrange();

**Vertical Layout Decorator Example**

The layout decorator as with any other decorator should always be applied before calling the factory methods build(), setStyle() and arrange(). 

	mockUIElement = new MockUIElement();
	mockUIElement.layout = new VerticalLayout( mockUIElement );
	mockUIElement.build();
	mockUIElement.arrange();
	
**Chaining Vertical and Padded Layout Decorator Example**

Layout decorators can be chained.

	mockUIElement = new MockUIElement();
	mockUIElement.layout = new VerticalLayout( mockUIElement );
	mockUIElement.layout.verticalGap = 5;
	mockUIElement.layout = new PaddedLayout( mockUIElement.layout );
	mockUIElement.layout.left = 5;
	mockUIElement.layout.right = 5;
	mockUIElement.build();
	mockUIElement.arrange();
	
**Decorator Shape for creating a background**

Each UIElement has a pre-built background decorator. It is reserved and therefore will always be at index 0. The background will automatically resize itself based on 
the UIElement's layout decorator if defined. Alternatively the size can be set through *width* and *height* properties. To show a background make sure *colors* and 
*alphas* is set with at least 2 values. Also make sure to call *arrange()* for the background to autosize if required. 
 
	mockUIElement = new MockUIElement();
	mockUIElement.background = new Rectangle( mockUIElement );
	mockUIElement.background.colours = [ 0, 0 ];
	mockUIElement.background.alphas = [ 1, 1 ];
	mockUIElement.build();
	mockUIElement.arrange();
	
**Decorator Scroll for creating a Vertical Scrollbar**
	mockUIElement = new MockUIElement();
	mockUIElement.scroll = new ScrollVertical( mockUIElement );
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

