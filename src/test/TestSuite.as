package test
{
	import test.com.wezside.components.TestUIDecorators;
	import test.com.wezside.components.TestUIElement;
	import test.com.wezside.components.control.TestButton;
	import test.com.wezside.components.gallery.TestGallery;
	import test.com.wezside.data.collection.TestCollection;
	import test.com.wezside.data.collection.TestLinkedListCollection;
	import test.com.wezside.data.mapping.TestXMLDataMapper;
	import test.com.wezside.utilities.command.TestCommandMapper;
	import test.com.wezside.utilities.date.TestDateUtil;
	import test.com.wezside.utilities.manager.state.TestStateManager;
	import test.com.wezside.utilities.manager.timeline.TestTimelineManager;
	import test.com.wezside.utilities.string.TestURLUtil;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite
	{
		public var testCommandMapper:TestCommandMapper;
		public var testUIElement:TestUIElement;
		public var testDateUtil:TestDateUtil;
		public var testGallery:TestGallery;
		public var testStateManager:TestStateManager;
		public var testURLUtil:TestURLUtil;
		public var testUIDecorators:TestUIDecorators;
		public var testTimelineManager:TestTimelineManager;
		public var testLinkedList:TestLinkedListCollection;
		public var testCollection:TestCollection;
		public var testXMLDataMapper:TestXMLDataMapper;
//		public var testRelativeLayout:TestButton;
	}
}