package com.wezside.components.control 
{
	import com.wezside.components.UIElement;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Icon extends UIElement 
	{
		public function Icon()
		{
			super( );
		}
				
		public function get paddingTop():int
		{
			return layout.top;
		}
		
		public function set paddingTop( value:int ):void
		{
			layout.top = value;
		}
		
		public function get paddingLeft():int
		{
			return layout.left;
		}
		
		public function set paddingLeft( value:int ):void
		{
			layout.left = value;
		}
		
		public function get paddingRight():int
		{
			return layout.right;
		}
		
		public function set paddingRight( value:int ):void
		{
			layout.right = value;
		}
		
		public function get paddingBottom():int
		{
			return layout.bottom;
		}
		
		public function set paddingBottom( value:int ):void
		{
			layout.bottom = value;
		}		
	}
}
