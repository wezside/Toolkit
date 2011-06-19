package test
{
	import test.com.wezside.component.TestUIElement;
	import test.com.wezside.component.decorator.TestInteractiveDecorator;
	/**
	 * Project type: Flex 4
	 *  -target-player={playerVersion}
		-library-path+="{flexSDK}/frameworks/locale/en_US"
		-default-size=1000,600
		-static-link-runtime-shared-libraries
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite
	{
//		public var testCommandMapper:TestCommandMapper;
		public var testUIElement:TestUIElement;
		public var testInteractiveDecorator:TestInteractiveDecorator;
//		public var testDateUtil:TestDateUtil;
//		public var testStateManager:TestStateManager;
//		public var testURLUtil:TestURLUtil;
//		public var testUIDecorators:TestUIDecorators;
//		public var testTimelineManager:TestTimelineManager;
//		public var testLinkedList:TestLinkedListCollection;
//		public var testCollection:TestCollection;
//		public var testXMLDataMapper:TestXMLDataMapper;
//		public var testHTTPService:TestHTTPService;
	}
}