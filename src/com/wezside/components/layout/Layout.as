package com.wezside.components.layout 
{
	import com.wezside.components.UIElementEvent;
	import flash.events.EventDispatcher;
	import com.wezside.components.IUIDecorator;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Layout extends EventDispatcher implements ILayout, IUIDecorator 
	{
		
		protected var decorated:IUIDecorator;

		
		public function Layout( decorated:IUIDecorator ) 
		{
			this.decorated = decorated;
		}

		public function update():void
		{
			arrange();
		}
		
		public function get layout():ILayout
		{
			return this;
		}
		
		public function set layout( value:ILayout ):void
		{
		}
		
		public function arrange( event:UIElementEvent = null ):void
		{			
			dispatchEvent( new UIElementEvent( UIElementEvent.ARRANGE_COMPLETE ));
		}
		
		public function iterator( type:String = null ):IIterator
		{
			return new NullIterator( );
		}
		
		public function get horizontalGap():int
		{
			return 0;
		}
		
		public function get verticalGap():int
		{
			return 0;
		}
		
		public function set horizontalGap(value:int):void
		{
		}
		
		public function set verticalGap(value:int):void
		{
		}
	}
}
