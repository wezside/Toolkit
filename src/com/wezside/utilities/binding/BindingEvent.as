package com.wezside.utilities.binding 
{
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class BindingEvent extends Event 
	{
		
		public static const PROPERTY_CHANGE:String = "bindingPropertyChange";
		
		public var property:Object;
		public var newValue:Object;
		public var source:Object;

		public function BindingEvent( type:String, 
									  bubbles:Boolean = false,
	                                  cancelable:Boolean = false,	                                  
	                                  property:Object = null, 
	                                  newValue:Object = null,
	                                  source:Object = null )
	    {
	        super( type, bubbles, cancelable );
	
	        this.property = property;
	        this.newValue = newValue;
	        this.source = source;
	    }
	}
}
