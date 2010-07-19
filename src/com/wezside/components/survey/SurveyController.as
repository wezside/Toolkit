package com.wezside.components.survey 
{
	import flash.utils.getQualifiedClassName;
	import com.wezside.utilities.logging.Tracer;
	import com.wezside.components.survey.data.SurveyData;
	import com.ogilvy.facebooksurvey.components.FacebookStartForm;
	import com.ogilvy.survey.components.ui.FormUITypes;
	import com.wezside.components.UIElement;
	import com.wezside.components.decorators.layout.VerticalLayout;
	import com.wezside.components.survey.data.IFormData;
	import com.wezside.components.survey.data.ISurveyData;
	import com.wezside.components.survey.data.router.Route;
	import com.wezside.components.survey.data.router.SurveyRouter;
	import com.wezside.components.survey.form.Form;
	import com.wezside.components.survey.form.FormEvent;
	import com.wezside.components.survey.form.FormValidator;
	import com.wezside.components.survey.form.IForm;
	import com.wezside.components.survey.form.IFormItem;

	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class SurveyController extends UIElement
	{
		
		private var _data:ISurveyData;
		private var _currentForm:IForm;
		private var _nextRoute:Route;		
		private var _router:SurveyRouter;
		private var _currentFormID:String;
		private var _validator:FormValidator;
		private var _history:Array = [];
		
		private var responseLevelRoute:Route;
		private var responseLevelID:String;
		private var responseLevelRoutes:Dictionary = new Dictionary( );

		
		public function SurveyController() 
		{
			super();			
			_nextRoute = null; 
			_history.push( "Start" );			
			_validator = new FormValidator( );
			addEventListener( FormEvent.FORM_STATE_CHANGE, onFormItemChange );
			addEventListener( FormEvent.TEXT_INPUT, onFormItemChange );
			addEventListener( FormEvent.FORM_FOCUS_OUT, onFormItemChange );			
		}
		
		override public function purge():void 
		{
			super.purge( );						
		}	
	

		public function createForm( id:String ):void
		{
			var formData:IFormData = data.getFormData( id );
			if ( !formData )
			{
				Tracer.output( debug, "ERROR : SurveyController.createForm :: Form data could not be retrieved.", getQualifiedClassName( this ));
				return;
			}
			
			if ( _currentForm )
			{
				// A form page already exists
				if( formData.id == _currentForm.data.id ) 
				{
					//The requested form page is the one that is currently displayed
					//Tracer.output( _debug, "WARN : FormController.createForm :: requested form ID is current form - ID: " + formData.id );
					return;
				}
				else
				{
					//Clear old form so that new form can be created
					//Tracer.output( _debug, "WARN : FormController.createForm :: Clearing old form ID:" + _currentForm.data.id );
					purge( );
				}
			}
			
			// TODO: Determine the type of form based on the custom form type specified in config.xml
			//		 This is where we introduce 
			switch( formData.id )
			{
				case "Start": 
					_currentForm = getFormClassFromID( "StartForm" );
					break;
				default: 
					_currentForm = new Form( );

			}
			
			_currentForm.styleManager = styleManager;
			_currentForm.data = formData;
			
			// TODO: Externalise layout decorator to XML config
			_currentForm.layout = new VerticalLayout( _currentForm );
			_currentForm.build( );
			_currentForm.arrange( );
			addChild( _currentForm as DisplayObject );
			
			//Dispatch form ready an a boolean of the forms isValid state
			//Forms without "submittable values" form items are default isValid=true
			//Forms with "submittable values" which have previously had required data added are also isValid=true
			// TODO: Remove this if not needed
			var evt:FormEvent = new FormEvent( FormEvent.FORM_VALIDATION_CHECK );
			evt.data = formData.isValid;
			dispatchEvent( evt );
		}		
		
		public function get data():ISurveyData
		{
			return _data ? _data : new SurveyData();
		}
		
		public function set data( value:ISurveyData ):void
		{
			_data = value;
		}
		
		public function get router():SurveyRouter
		{
			return _router;
		}
		
		public function set router( value:SurveyRouter ):void
		{
			_router = value;
		}		
		
		/**
		 * Invoked from FormEvent.FORM_VALIDATION_CHECK
		 */
		private function onFormEvent( evt:FormEvent ):void
		{
			evt.stopPropagation( );
			var isFormValid:Boolean;
			
			switch( evt.type )
			{
				case FormEvent.FORM_VALIDATION_CHECK:
					isFormValid = evt.data as Boolean;
//					var surveyEvent:SurveyEvent = new SurveyEvent( SurveyEvent.FORM_VALIDATION );
//					surveyEvent.data = isFormValid;
//					dispatchEvent( surveyEvent );
					break;
				case FormEvent.FORM_STATE_CHANGE:
					var formItem:IFormItem = evt.target as IFormItem;

					switch( formItem.type )
					{
						case FormUITypes.ITEM_CALL_TO_ACTION:
						case FormUITypes.ITEM_TYPE_STATIC_TEXT:
							break;
						default:
							//The action for all interactive elements
							//Validation performed in the FORM CONTROLLER when the FormItem event is fired
							isFormValid = formItem.parentGroup.parentForm.data.isValid;
							//Determine the navigation path based on user choices							

							//The form is valid AND the router is being used (_useRouter is a debug tool for dev, if switched of the navigation path is linear)
							_nextRoute = _router.next( formItem.data.parent.id );
							if ( _router.hasChild( formItem.id ))
							{			
								//Routing is a response level for this item
								responseLevelRoute = router.next( formItem.id );
								responseLevelID = responseLevelRoute.nextpath;
								responseLevelRoutes[ _currentFormID ] = { id: formItem.data.parent.id, responseLevelID: responseLevelID };
							}
							else
							{
								if ( responseLevelRoutes[ _currentFormID ])
								{
									if ( formItem.data.parent.id == responseLevelRoutes[ _currentFormID ].id )
									{							
										responseLevelID = "";
										responseLevelRoute = null;
										responseLevelRoutes[formItem.parentGroup.parentForm.data.id] = null;
									}
								}
							}
					}
			}
		}
		
		private function onFormItemChange( evt:FormEvent ):void
		{
			var formItem:IFormItem = evt.target as IFormItem;
			//trace("==================================================================");
			//trace("=========== FORM CONTROLLER : onFormItemChange : " + formItem.id );
			//trace("==================================================================");
			switch( formItem.type )
			{
				case FormUITypes.ITEM_CALL_TO_ACTION:
					//OPEN POP-UP
					//_currentForm.metaItemSelected( formItem.id );
					break;
					
				default:
					//The action for all elements with "submitable values"
					//Validate current form
					var isFormValid:Boolean = _validator.validate( formItem );
					var event:FormEvent = new FormEvent( FormEvent.FORM_VALIDATION_CHECK );
					event.data = isFormValid;
					dispatchEvent( event );
					break;
			}
		}		

		private function getFormClassFromID( string:String ):IForm 
		{
			return new Form();
		}
	}
}
