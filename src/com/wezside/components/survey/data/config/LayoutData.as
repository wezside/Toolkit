package com.wezside.components.survey.data.config 
{
	import com.wezside.data.IDeserializable;
	import com.wezside.data.collection.ICollection;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class LayoutData implements IDeserializable 
	{
		
		public var id:String;
		public var decorators:ICollection;		
		
		public function layoutDecorator( id:String ):LayoutDecoratorData
		{
			return decorators ? decorators.find( "id", id ) as LayoutDecoratorData : null;
		}
				
	}
}
