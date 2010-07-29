package com.wezside.components.survey.data.ui 
{
	import com.wezside.data.IDeserializable;
	import com.wezside.data.collection.Collection;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class UIItemData implements IDeserializable 
	{
		
		public var id:String;
		public var cssID:String;
		public var hiddenIDCollection:Collection = new Collection();

		private var _hiddenID:String;
				
		public function get hiddenID():String
		{
			return _hiddenID;
		}
		
		public function set hiddenID( value:String ):void
		{
			_hiddenID = value;
			var arr:Array = hiddenID.split( "," );
			for ( var i:int = 0; i < arr.length; ++i ) 
				hiddenIDCollection.addElement( arr[i] );
			arr = null;		
		}
	}
}
