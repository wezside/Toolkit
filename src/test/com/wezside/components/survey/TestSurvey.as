package test.com.wezside.components.survey 
{
	import flexunit.framework.Assert;

	import com.wezside.components.survey.ISurvey;
	import com.wezside.components.survey.Survey;
	import com.wezside.components.survey.SurveyEvent;
	import com.wezside.components.survey.data.FormData;
	import com.wezside.components.survey.data.FormItemData;
	import com.wezside.components.survey.data.IFormData;
	import com.wezside.components.survey.data.ISurveyData;
	import com.wezside.components.survey.data.SurveyData;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestSurvey 
	{
		

		private var survey:ISurvey;
		private var data:ISurveyData;
		private var formdata:IFormData;
		private var item:FormItemData;
		private var multipleFormData:SurveyData;

		[Before]
		public function setUp():void
		{			
			
			// individual form item data used to generate displayobject form item
			item = new FormItemData();
			item.label = "Age";
			item.type = "input";
			
			// data for each form including a list of all item data that is required within each form
			formdata = new FormData();
			formdata.heading = "My first form";
			formdata.body = "Integer nisl tellus, ornare ut ultricies et, rhoncus nec augue! Fusce et tempus massa.";
			formdata.submit = "Save";
			formdata.cta = "";
			formdata.items.push( item );
			
			multipleFormData = new SurveyData();
			multipleFormData.forms.push( formdata );
			multipleFormData.forms.push( formdata );
			multipleFormData.forms.push( formdata );
			multipleFormData.forms.push( formdata );
			
			data = new SurveyData();
			data.forms.push( formdata );
			survey = new Survey();
		}
		
		[After]
		public function tearDown():void
		{
			survey.purge();
			item = null;
			survey = null;
			formdata = null;
			multipleFormData = null;
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
		
		[Ignore][Test(async)] 
		public function testSurveyCreateMultipleForms():void
		{
			survey.data = multipleFormData;
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
