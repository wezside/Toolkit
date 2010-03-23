package test.com.wezside.components.survey 
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import com.wezside.components.survey.SurveyEvent;
	import flexunit.framework.Assert;

	import com.wezside.components.survey.ISurvey;
	import com.wezside.components.survey.Survey;
	import com.wezside.components.survey.data.FormData;
	import com.wezside.components.survey.data.IFormData;
	import com.wezside.components.survey.data.ISurveyData;
	import com.wezside.components.survey.data.SurveyData;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestSurvey 
	{
		

		private var survey:ISurvey;
		private var data:ISurveyData;
		private var formdata:IFormData;


		[Before]
		public function setUp():void
		{			
			formdata = new FormData();
			formdata.heading = "My first form";
			formdata.body = "Integer nisl tellus, ornare ut ultricies et, rhoncus nec augue! Fusce et tempus massa.";
			formdata.submit = "Save";
			formdata.cta = "";
			
			data = new SurveyData();
			data.forms.push( formdata );
			survey = new Survey();
		}
		
		[After]
		public function tearDown():void
		{
			survey.purge();
			survey = null;
			formdata = null;
		}
		
		[Test] 
		public function testSurveyShow():void
		{
			survey.show();		
			Assert.assertTrue( survey.visible );	
		}		
		
		[Test(async)] 
		public function testSurveyCreate():void
		{
			survey.data = data;
			survey.addEventListener( SurveyEvent.CREATION_COMPLETE, Async.asyncHandler( this, surveyCreated, 3000, null, timeout ), false, 0, true);
			survey.create();			
		}
		
		protected function surveyCreated( event:SurveyEvent, object:Object ):void
		{
			assertEquals( Survey.STATE_CREATION_COMPLETE, survey.state );	
		}
		
		protected function timeout( object:Object ):void
		{
	    	Assert.fail( "Pending Event Never Occurred" );
		}		
	}
}
