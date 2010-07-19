package com.wezside.components.survey.data 
{
	import com.wezside.components.UIElementState;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class FormItemData implements IFormItemData 
	{
		private var _id:String;
		private var _type:String;
		private var _value:String;
		private var _label:String;
		private var _sublabel:String;
		private var _styleName:String;
		private var _iconStyleName:String;
		private var _selectedState:Boolean;
		private var _isValid:Boolean;
		private var _state:String;
		public var debug:Boolean = true;

		
		public function get id():String 
		{
			return _id;
		}

		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get type():String 
		{
			return _type;
		}

		public function set type(value:String):void 
		{
			_type = value;
		}
				
		public function get value():String 
		{
			return _value;
		}

		public function set value( newValue:String):void 
		{
			_value = newValue;
		}
		
		public function get label():String 
		{
			return _label;
		}

		public function set label(value:String):void 
		{
			_label = value;
		}	
		
		public function get sublabel():String 
		{
			return _sublabel;
		}

		public function set sublabel(value:String):void 
		{
			_sublabel = value;
		}	
		
		public function get styleName():String 
		{
			return _styleName;
		}

		public function set styleName(value:String):void 
		{
			_styleName = value;
		}
		
		public function get iconStyleName():String 
		{
			return _iconStyleName;
		}

		public function set iconStyleName(value:String):void 
		{
			_iconStyleName = value;
		}
		
		public function get selectedState():Boolean 
		{
			return _selectedState;
		}

		public function set selectedState(value:Boolean):void 
		{
			_selectedState = value;
		}
		
		public function get isValid():Boolean 
		{
			return _isValid;
		}

		public function set isValid(value:Boolean):void 
		{
			_isValid = value;
		}
		
		public function purgeData():void 
		{
			_value = null;
			_selectedState = false;
			_state = UIElementState.STATE_VISUAL_UP;
//			if ( parent.isInteractive ) _isValid = false;
		}
		
		public function get state():String 
		{
			return _state;
		}

		public function set state(value:String):void 
		{
			_state = value;
		}
	}
}
