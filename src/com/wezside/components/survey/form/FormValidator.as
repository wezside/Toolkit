package com.wezside.components.survey.form 
{
	import com.ogilvy.facebooksurvey.commands.validation.ValidateFormCommand;
	import com.ogilvy.facebooksurvey.commands.validation.ValidateFormGroupCommand;
	import com.ogilvy.facebooksurvey.commands.validation.ValidateFormItemCommand;

	/**
	 * @author DaSmith
	 */
	public class FormValidator 
	{
		public function FormValidator() 
		{
		}

		public function validate( formItem:IFormItem ):Boolean
		{
			validateItem( formItem );
			validateGroup( formItem );
			var result:Boolean = validateForm( formItem );
			
			return result;
		}

		//######  FORM VALIDATION FUNCTIONS  ######
		//The commands act upon the data objects of each Item/Group/Form
		//The only result returned is the final valid state (true/false) of the current form itself.
		private function validateItem( formItem:IFormItem ):void
		{
			var cmd:ValidateFormItemCommand = new ValidateFormItemCommand( );
			cmd.execute( formItem );
		}

		private function validateGroup( formItem:IFormItem ):void
		{
			var cmd:ValidateFormGroupCommand = new ValidateFormGroupCommand( );
			cmd.execute( formItem );
		}

		private function validateForm( formItem:IFormItem ):Boolean
		{
			var cmd:ValidateFormCommand = new ValidateFormCommand( );
			cmd.execute( formItem );
			
			var form:IForm = formItem.parentGroup.parentForm;
			
			return form.data.isValid;
		}
	}
}
