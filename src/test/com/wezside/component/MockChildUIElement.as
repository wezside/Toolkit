package test.com.wezside.component 
{
	import com.wezside.component.IUIElement;
	import com.wezside.component.UIElement;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MockChildUIElement extends UIElement
	{
		private var _antiAliasType:String = "";
		private var _child:IUIElement;



		public function MockChildUIElement()
		{
			super( );
		}


		override public function build():void
		{
			super.build();
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
