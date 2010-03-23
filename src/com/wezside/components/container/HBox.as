package com.wezside.components.container 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class HBox extends Box 
	{
		private var _horizontalGap:int;
		
		public function HBox()
		{
			super( );
			super.positionProp = PROP_X;
			super.dimensionProp = PROP_WIDTH;
		}

		public function get horizontalGap():int
		{
			return _horizontalGap;
		}
		
		public function set horizontalGap( value:int ):void
		{
			super.gap = value;
			_horizontalGap = value;			
		}
	}
}
