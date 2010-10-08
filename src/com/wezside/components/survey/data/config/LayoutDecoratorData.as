package com.wezside.components.survey.data.config 
{
	import com.wezside.data.IDeserializable;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class LayoutDecoratorData implements IDeserializable 
	{
		public var id:String;
		public var top:int;
		public var left:int;
		public var bottom:int;
		public var right:int;
		public var horizontalGap:int;
		public var verticalGap:int;
		
		public function get width():Number
		{
			return isNaN( _width ) ? 0 : _width;
		}
		
		public function set width( value:Number ):void
		{
			_width = value;
		}		
		
		public function get height():Number
		{
			return isNaN( _height ) ? 0 : _height;
		}
		
		public function set height( value:Number ):void
		{
			_height = value;
		}
				
		public function get widthRatio():Number
		{
			return isNaN(_widthRatio) ? 0 : _widthRatio;
		}
		
		public function set widthRatio( value:Number ):void
		{
			_widthRatio = value;
		}
		
		public function get heightRatio():Number
		{
			return isNaN(_heightRatio) ? 0 : _heightRatio;
		}
		
		public function set heightRatio( value:Number ):void
		{
			_heightRatio = value;
		}
		
				
		private var _width:Number;
		private var _height:Number;
		private var _widthRatio:Number;
		private var _heightRatio:Number;		
	}
}
