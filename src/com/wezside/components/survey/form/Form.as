package com.wezside.components.survey.form 
{
	import com.wezside.components.accordion.AccordionItem;
	import com.wezside.components.accordion.IAccordionItem;
	import com.wezside.components.container.ContainerEvent;
	import com.wezside.components.container.HBox;
	import com.wezside.components.container.VBox;
	import com.wezside.components.survey.data.IFormData;
	import com.wezside.components.text.Label;
	import com.wezside.utilities.managers.style.IStyleManager;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Form extends Sprite implements IForm 
	{

		public static const STATE_CREATION_COMPLETE:String = "stateFormCreationComplete";
		
		
		private var _items:Array = [];
		private var _layout:IFormLayout;
		private var _state:String;
		private var container:VBox;
		private var _data:IFormData;
		private var _heading:Label;
		private var _styleManager:IStyleManager;
		private var _subheading:Label;
		private var _body:Label;
		private var _maxRowLabelWidth:int;

		
		public function Form() 
		{
			_maxRowLabelWidth = 150;
		}
		
		
		public function createChildren():void
		{
			container = new VBox();
			container.borderAlpha = 0;
			container.backgroundAlphas = [0,0];
			container.verticalGap = 5;
			container.addEventListener( ContainerEvent.CREATION_COMPLETE, containerCreated );
			addChild( container );
			
			if ( _data.heading != "" )
			{
				_heading = new Label();
				_heading.text = _data.heading;
			}
			
			if ( _data.subheading != "" )
			{
				_subheading = new Label();
				_subheading.text = _data.subheading;
			}
			
			if ( _data.body != "" )
			{
				_body = new Label();
				_body.width = 200;
				_body.wordWrap = true;
				_body.text = _data.body;
			}
			
			
			for ( var i:int = 0; i < _items.length; ++i ) 
				_layout.addItem( _items[0] );
				
			container.children = [ _heading, _subheading, _body, _layout ];
		}
		
		public function purge():void
		{
		}
		
		public function get items():Array
		{
			return _items;
		}
		
		public function get layout():IFormLayout
		{
			return _layout;
		}
		
		public function set items( value:Array ):void
		{
			_items = value;
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
		

		private function containerCreated( event:ContainerEvent ):void 
		{
			container.update();
			container.removeEventListener( ContainerEvent.CREATION_COMPLETE, containerCreated );
			state = STATE_CREATION_COMPLETE;
		}
		
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
		}		
		
		
		public function get maxRowLabelWidth():int
		{
			return _maxRowLabelWidth;
		}
		
		public function set maxRowLabelWidth(value:int):void
		{
			_maxRowLabelWidth = value;
		}				

		private function createFormRow( item:IFormItem ):void 
		{
			
			var row:HBox = new HBox();
			var rowLabel:Label = new Label();
			rowLabel.text = item.rowLabel;
			
			row.children = [ rowLabel ];
			/*
		 	var itemA:IAccordionItem = new AccordionItem();
		    itemA.header = headerDisplayObject;
		    itemA.content = contentDisplayObject; 
		
		    var acc:Accordion = new Accordion();
		    acc.addItem( itemA );
		    addChild( acc );
		     */
		}

	}
}
