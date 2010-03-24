package test.com.wezside.components.survey 
{
	import com.wezside.components.survey.ISurvey;
	import com.wezside.components.survey.Survey;
	import com.wezside.components.survey.SurveyEvent;
	import com.wezside.components.survey.data.FormData;
	import com.wezside.components.survey.data.IFormData;
	import com.wezside.components.survey.data.ISurveyData;
	import com.wezside.components.survey.data.SurveyData;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class UITestSurvey extends Sprite 
	{
		

		private var survey:ISurvey;
		private var data:ISurveyData;
		private var formdata:IFormData;


		public function UITestSurvey() 
		{
			
			formdata = new FormData();
			formdata.heading = "My first form";
			formdata.subheading = "Sub heading form";
			formdata.body = "Integer nisl tellus, ornare ut ultricies et, rhoncus nec augue! Fusce et tempus massa.";
			formdata.submit = "Save";
			formdata.cta = "";
			
			
			
			
			data = new SurveyData();
			data.forms.push( formdata );
			
			survey = new Survey();		
			survey.data = data;
			survey.addEventListener( SurveyEvent.CREATION_COMPLETE, surveyCreated );
			survey.create();			
		}

		private function surveyCreated( event:SurveyEvent ):void 
		{
			addChild( survey as DisplayObject );
			survey.show();
		}
	}
}
