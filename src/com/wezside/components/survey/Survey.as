package com.wezside.components.survey 
{
	import com.wezside.components.survey.form.FormEvent;
	import com.wezside.components.survey.data.IFormData;
	import com.wezside.components.survey.data.ISurveyData;
	import com.wezside.components.survey.form.Form;
	import com.wezside.components.survey.form.IForm;
	import com.wezside.components.survey.form.IFormTransition;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Survey extends Sprite implements ISurvey  
	{
		
		
		public static const STATE_CREATION_COMPLETE:String = "stateSurveyCreationComplete";
		
		
		private var _data:ISurveyData;
		private var _state:String;

		
		public function Survey() 
		{
			visible = false;
		}		

		public function show():void
		{
			visible = true;
		}

		public function hide():void
		{
			visible = false;
		}		

		public function purge():void
		{
			while ( this.numChildren > 0 )
				removeChildAt( this.numChildren - 1 );
		}		

		public function get data():ISurveyData
		{
			return _data;
		}

		public function get pages():int
		{
			return 0;
		}

		public function get pageIndex():int
		{
			return 0;
		}

		public function get transition():IFormTransition
		{
			return null;
		}

		public function set data( value:ISurveyData ):void
		{
			_data = value;
		}

		public function set pages( value:int ):void
		{
		}

		public function set pageIndex( value:int ):void
		{
		}

		public function set transition( value:IFormTransition ):void
		{
		}	
		
		public function get state():String
		{
			return _state;
		}
		
		public function set state(value:String):void
		{
			_state = value;			
			switch( _state )
			{
				case STATE_CREATION_COMPLETE: 
					dispatchEvent( new SurveyEvent( SurveyEvent.CREATION_COMPLETE ));					
					break;
				default:
			}			
		}		

		public function create():void 
		{
			if ( _data.forms.length > 0 )
				createSingleForm( _data.forms[0]);
		}

		private function createSingleForm( data:IFormData ):void 
		{			
			var form:IForm = new Form();
			form.data = data;
			form.createChildren();
			form.addEventListener( FormEvent.CREATION_COMPLETE, formCreated );
			addChild( DisplayObject( form ));
		}		

		private function formCreated( event:FormEvent ):void 
		{
			_data.forms.shift();
			_data.forms.length > 0 ? createSingleForm( _data.forms[0] ) : allFormsCreated();			
		}

		private function allFormsCreated():void 
		{
			state = STATE_CREATION_COMPLETE;
		}

	}
}
