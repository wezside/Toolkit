package com.wezside.components.survey.form 
{
	import com.wezside.components.UIElement;
	import com.wezside.components.survey.data.IFormData;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Form extends UIElement implements IForm 
	{
		
		private var _data:IFormData;
		
		override public function build():void 
		{
			super.build( );
			
		}

		public function get data():IFormData
		{
			return _data;
		}
		
		public function set data( value:IFormData ):void
		{
			_data = value;
		}
		
	}
}
