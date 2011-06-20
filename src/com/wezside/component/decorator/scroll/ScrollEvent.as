package com.wezside.component.decorator.scroll {
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ScrollEvent extends Event {
		
		public static const CHANGE : String = "scrollValueChange";
		
		public var percent : Number;
		public var scrollValue : int;
		public var prop : String;
		
		
		public function ScrollEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false, percent : Number = 0, scrollValue : int = 0, prop : String = "y" ) {
			super( type, bubbles, cancelable );
			this.percent = percent;
			this.scrollValue = scrollValue;
			this.prop = prop;
		}
		
		override public function clone() : Event {
			return new ScrollEvent( type, bubbles, cancelable, percent, scrollValue, prop );
		}
	}
}