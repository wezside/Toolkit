package test.com.wezside.components 
{
	import com.wezside.components.IUIElement;
	import com.wezside.components.UIElementFP9;

	import flash.display.DisplayObject;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MockUIElementFP9 extends UIElementFP9 
	{
		private var _antiAliasType:String = "";
		private var _child:IUIElement;

		public function MockUIElementFP9()
		{
			super( );
		}
		
		
		public function createChildren():void
		{
			child = new MockUIElement();
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
