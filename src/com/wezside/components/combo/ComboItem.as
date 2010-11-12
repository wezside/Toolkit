package com.wezside.components.combo 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class ComboItem 
	{
		
		public var index:int;
		public var selected:Boolean;
		public var text:String;
		public var styleName:String;

		
		public function ComboItem( text:String, styleName:String = "", selected:Boolean = false ) 
		{
			this.index = index;
			this.selected = selected;
			this.text = text;
			this.styleName = styleName;
		}		
	}
}
