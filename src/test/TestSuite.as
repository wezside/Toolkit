package test
{
	import test.com.wezside.components.TestUIElement;
	import test.com.wezside.components.gallery.TestGallery;
	import test.com.wezside.components.survey.TestSurvey;
	import test.com.wezside.utilities.date.TestDateUtil;
	import test.com.wezside.utilities.stateManager.TestStateManager;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite
	{
		public var testUIElement:TestUIElement;
		public var testSurvey:TestSurvey;
		public var testDateUtil:TestDateUtil;
		public var testGallery:TestGallery;
		public var testStateManager:TestStateManager;

	}
}