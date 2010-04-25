package test.com.wezside.components 
{
	import com.wezside.utilities.logging.Tracer;
	import com.wezside.components.IUIElement;
	import com.wezside.components.UIElement;

	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MockUIElement extends UIElement
	{
		private var _antiAliasType:String = "";
		private var _child:IUIElement;



		public function MockUIElement()
		{
			super( );
		}

		
		
		override public function update(recurse:Boolean = false):void 
		{
			Tracer.output( true, " MockUIElement.update()", toString() );
			super.update( );
		}

		override public function build():void
		{
			_child = new MockChildUIElement();
			addChild( _child as DisplayObject );
		}
		
		
		public function get child():IUIElement
		{
			return _child;
		}
		
		public function set child( value:IUIElement ):void
		{
			_child = value;
		}
		
		
		public function get antiAliasType():String
		{
			return _antiAliasType;
		}
		
		public function set antiAliasType( value:String ):void
		{
			_antiAliasType = value;
		}
	}
}
