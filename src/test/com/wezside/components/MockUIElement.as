package test.com.wezside.components 
{
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

		override public function build():void
		{
			super.build();
			_child = new MockChildUIElement();
			_child.build();
			_child.arrange();
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
