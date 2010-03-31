package com.wezside.components.media.data 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Media
	{
		
		public var id:String;
		public var url:String;
		public var href:String;
		public var items:Array;
		
		public function item( id:String ):Item
		{
			for ( var i:int = 0; i < items.length; ++i ) 
				if ( items[i].id == id )
					return Item( items[i] );
			return null;	
		}
	}
}
