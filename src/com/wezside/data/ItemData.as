package com.wezside.data
{
	import com.wezside.data.IDeserializable;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class ItemData implements IDeserializable
	{
		
		public var id:String;		
		public var text:String;	
		public var date:Date;	
		public var href:String;		
		public var type:String;		
		public var width:Number;	
		public var height:Number;
		public var handle:String;
		
				
		private var _uri:String;

		public function get uri():String
		{
			return _uri;
		}
		
		public function set uri( value:String ):void
		{
			_uri = value;
			id = parseID( _uri );
		}
		
		public function parseID( uri:String ):String
		{
			var pattern:RegExp = /[^\/][\w-]+\.[\w]+/gi;
			var ext:Array = uri.match( pattern );
			return ext.length == 0 ? "" : ext[ext.length-1];
		}		
		
		public function purge():void
		{
			id = null;
			text = null;
			uri = null;
			date = null;
			href = null;
			type = null;
		}	
	}
}
