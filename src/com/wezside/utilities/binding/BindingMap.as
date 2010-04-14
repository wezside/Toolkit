package com.wezside.utilities.binding 
{
	import com.wezside.utilities.logging.Tracer;

	import flash.events.IEventDispatcher;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class BindingMap implements IBindable
	{
		private var _src:Object;
		private var _srcProp:String;
		private var _target:Object;
		private var _targetProp:Object;

		public function get src():Object
		{
			return _src;
		}
		
		public function set src( value:Object ):void
		{
			_src = value;
		}
		
		public function get srcProp():String
		{
			return _srcProp;
		}
		
		public function set srcProp( value:String ):void
		{
			_srcProp = value;
		}
		
		public function get target():Object
		{
			return _target;
		}
		
		public function set target( value:Object ):void
		{
			_target = value;
		}
		
		public function get targetProp():Object
		{
			return _targetProp;
		}
		
		public function set targetProp( value:Object ):void
		{
			_targetProp = value;
		}
		
		public function listen():void
		{
			IEventDispatcher( _src ).addEventListener( BindingEvent.PROPERTY_CHANGE, update );
		}
		
		public function purge():void
		{
			IEventDispatcher( _src ).removeEventListener( BindingEvent.PROPERTY_CHANGE, update );
		}

		private function update(event:BindingEvent):void 
		{
			if ( event.property == srcProp )
			{
				target[ targetProp ] = event.newValue;				
				Tracer.output( true, " Updated '" + target + "' with new value '" + event.newValue, "" );
			} 			
		}
	}
}
