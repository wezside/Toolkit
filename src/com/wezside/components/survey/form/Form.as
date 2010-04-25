package com.wezside.components.survey.form 
{
	import com.wezside.components.layout.VerticalLayout;
	import com.wezside.components.shape.Rectangle;
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.survey.data.FormItemData;
	import com.wezside.components.survey.data.IFormData;
	import com.wezside.components.survey.data.IFormItemData;
	import com.wezside.components.text.Label;
	import com.wezside.utilities.logging.Tracer;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Form extends Sprite implements IForm 
	{

		public static const STATE_CREATION_COMPLETE:String = "stateFormCreationComplete";
		
		
		private var _layout:IFormLayout;
		private var _state:String;
		private var _data:IFormData;
		private var _heading:Label;
		private var _subheading:Label;
		private var _body:Label;
		private var _maxRowLabelWidth:int;
		private var container:UIElement;

		
		public function Form() 
		{
			_maxRowLabelWidth = 150;
		}
		
		
		public function createChildren():void
		{
			
			var arr:Array = [];
			container = new UIElement();

			container.background = new Rectangle( container );
			container.layout = new VerticalLayout( container ); 
			container.layout.verticalGap = 5;
			addChild( container );
			
			if ( _data.heading != "" )
			{
				_heading = new Label();
				_heading.text = _data.heading;
				arr.push( _heading );
			}
			
			if ( _data.subheading != "" )
			{
				_subheading = new Label();
				_subheading.text = _data.subheading;
				arr.push( _subheading );
			}
			
			if ( _data.body != "" )
			{
				_body = new Label();
				_body.width = 200;
				_body.wordWrap = true;
				_body.text = _data.body;
				arr.push( _body );
			}			
			
			// Create form item from FormItemData
			var itemArr:Array = [];
			if ( IFormItemData( _data.items[0] ).type == "input" )
			{
				itemArr.push( createInputField( IFormItemData( _data.items[0] )));
			}
			
			// Add the new FormItem to the Layout
			for ( var i:int = 0; i <  itemArr.length; ++i ) 
				_layout.addItem( itemArr[i] );
				
			// Check if there is a layout
			if ( _data.items.length > 0 ) arr.push( _layout );
//			container.children = arr;

			containerCreated( new UIElementEvent( UIElementEvent.CREATION_COMPLETE ));
		}

		
		public function purge():void
		{
		}
		
		public function get layout():IFormLayout
		{
			return _layout;
		}
		
		public function set layout( value:IFormLayout ):void
		{
			_layout = value;
		}
		
		public function get state():String
		{
			return _state;
		}
		
		public function set state( value:String ):void
		{
			_state = value;
			switch( _state )
			{
				case STATE_CREATION_COMPLETE: dispatchEvent( new FormEvent( FormEvent.CREATION_COMPLETE ));					
					break;
				default:
			}
		}
		
		public function get data():IFormData
		{
			return _data;
		}
		
		public function set data( value:IFormData ):void
		{
			_data = value;
		}
		
		private function containerCreated( event:UIElementEvent ):void 
		{
			Tracer.output( true, " Form.containerCreated(event)", toString() );
			_layout.arrange();			
			container.update();
			container.removeEventListener( UIElementEvent.CREATION_COMPLETE, containerCreated );
			state = STATE_CREATION_COMPLETE;
		}
		
		public function get maxRowLabelWidth():int
		{
			return _maxRowLabelWidth;
		}
		
		public function set maxRowLabelWidth(value:int):void
		{
			_maxRowLabelWidth = value;
		}				
		
		private function createInputField( iFormItemData:IFormItemData ):IFormItem 
		{
			var data:IFormItemData = new FormItemData();
			return null;
		}

		

	}
}
