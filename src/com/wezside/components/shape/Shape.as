package com.wezside.components.shape 
{
	import com.wezside.components.IUIDecorator;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.layout.ILayout;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Shape extends Sprite implements IShape 
	{
		
		private var _layout:ILayout;
		private var _backgroundColors:Array;
		private var _backgroundAlphas:Array;

		protected var decorated:IUIDecorator;
		private var _cornerRadius:int;
		private var _borderAlpha:int;
		private var _borderThickness:int;

		
		public function Shape( decorated:IUIDecorator = null ) 
		{
			this.decorated = decorated;	
			this.layout = decorated.layout;
		}
		
		public function iterator(type:String = null):IIterator
		{
			return new NullIterator( );
		}
		
		public function update():void
		{
			arrange();
		}
		
		public function arrange(event:UIElementEvent = null):void
		{
			draw();
		}
		
		public function get layout():ILayout
		{
			return _layout;
		}
		
		public function set layout(value:ILayout):void
		{
			_layout = value;
		}
		
		public function get backgroundColours():Array
		{
			return _backgroundColors;
		}
		
		public function set backgroundColours(value:Array):void
		{
			_backgroundColors = value;
		}
		
		public function get backgroundAlphas():Array
		{
			return _backgroundAlphas;
		}
		
		public function set backgroundAlphas(value:Array):void
		{
			_backgroundAlphas = value;
		}
		
		public function draw():void
		{
		}
		
		public function get background():IShape
		{
			return null;
		}
		
		public function set background(value:IShape):void
		{
		}
		
		public function get cornerRadius():int
		{
			return _cornerRadius;
		}
		
		public function set cornerRadius(value:int):void
		{
			_cornerRadius = value;
		}
		
		public function get borderAlpha():int
		{
			return _borderAlpha;
		}
		
		public function get borderThickness():int
		{
			return _borderThickness;
		}
		
		public function set borderAlpha(value:int):void
		{
			_borderAlpha = value;
		}
		
		public function set borderThickness(value:int):void
		{
			_borderThickness = value;
		}
	}
}
