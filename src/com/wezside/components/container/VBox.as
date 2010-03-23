package com.wezside.components.container 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VBox extends Box 
	{
		
		
		private var _verticalGap:int;
		
		
		public function VBox()
		{
			super( );
			super.positionProp = PROP_Y;
			super.dimensionProp = PROP_HEIGHT; 
		}

		
		public function get verticalGap():int
		{
			return _verticalGap;
		}
		
		
		public function set verticalGap( value:int ):void
		{
			super.gap = value;
			_verticalGap = value;
		}
		
	}
}
