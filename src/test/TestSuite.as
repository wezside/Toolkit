package test
{
	import test.com.wezside.components.gallery.TestGallery;
	import test.com.wezside.components.survey.TestSurvey;
	import test.com.wezside.utilities.date.TestDateUtil;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite
	{
		public var testSurvey:TestSurvey;
		public var testDateUtil:TestDateUtil;
		public var testGallery:TestGallery;

	}
}