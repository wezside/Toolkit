package com.wezside.components.layout 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElementEvent;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;
	import com.wezside.utilities.logging.Tracer;

	import flash.events.EventDispatcher;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Layout extends EventDispatcher implements ILayout, IUIDecorator 
	{

		protected var decorated:IUIDecorator;
		private var _verticalGap:int;
		private var _horizontalGap:int;
		private var _top:int;
		private var _bottom:int;
		private var _left:int;
		private var _right:int;

		public function Layout( decorated:IUIDecorator = null ) 
		{
			this.decorated = decorated;
		}

		public function update():void
		{
			Tracer.output( true, " Layout.update()", toString() );
			arrange();
		}
		
		public function arrange( event:UIElementEvent = null ):void
		{			
			if ( decorated.iterator().hasNext( ) ) decorated.arrange();
			dispatchEvent( new UIElementEvent( UIElementEvent.ARRANGE_COMPLETE ));
		}
		
		public function iterator( type:String = null ):IIterator
		{
			return new NullIterator( );
		}
		
		public function get top():int
		{
			return _top;
		}
		
		public function get bottom():int
		{
			return _bottom;
		}
		
		public function get left():int
		{
			return _left;
		}
		
		public function get right():int
		{
			return _right;
		}
		
		public function get horizontalGap():int
		{
			return _horizontalGap;
		}
		
		public function get verticalGap():int
		{
			return _verticalGap;
		}
		
		public function set top(value:int):void
		{
			_top = value;
		}
		
		public function set bottom(value:int):void
		{
			_bottom = value;
		}
		
		public function set left(value:int):void
		{
			_left = value;
		}
		
		public function set right(value:int):void
		{
			_right = value;
		}
		
		public function set horizontalGap(value:int):void
		{
			_horizontalGap = value;
		}

		public function set verticalGap(value:int):void
		{
			_verticalGap = value;
		}
		
		public function get layout():ILayout
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function set layout(value:ILayout):void
		{
		}
	}
}