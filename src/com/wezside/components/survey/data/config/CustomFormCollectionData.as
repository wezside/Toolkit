package com.wezside.components.survey.data.config 
{
	import com.wezside.data.IDeserializable;
	import com.wezside.data.collection.ICollection;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class CustomFormCollectionData implements IDeserializable 
	{
		public var id:String;
		public var customForm:ICollection;
		
		public function customFormItem( id:String ):CustomFormData
		{
			return customForm ? customForm.find( id ) as CustomFormData : null;
		}		
	}
}
