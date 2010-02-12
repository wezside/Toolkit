package com.wezside.components.accordion 
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class AccordionContent extends Sprite 
	{
		
		
		private var _title:DisplayObject;
		private var _bg:DisplayObject;
		private var _hitTestInstance:DisplayObject;
		private var _body:DisplayObject;

		
		public function AccordionContent() 
		{
			super();
		}
		
		public function get title():DisplayObject 
		{
			return _title;
		}
		
		public function set title( value:DisplayObject ):void
		{
			_title = value;
			addChildAt( value, this.numChildren );
		}
		
		public function set body( value:DisplayObject ):void
		{
			_body = value;
			_body.y = _title.y + _title.height;
			addChild( _body );
		}
		
		public function get body():DisplayObject 
		{
			return _body;
		}
		
		public function get background():DisplayObject 
		{
			return _bg;
		}
		
		public function set background( value:DisplayObject ):void
		{
			_bg = value;
			addChild( value );
		}
		
		public function get hitTestInstance():DisplayObject
		{
			return _hitTestInstance;
		}
		
		public function set hitTestInstance( value:DisplayObject ):void
		{
			_hitTestInstance = value;
		}
		
	}
}
