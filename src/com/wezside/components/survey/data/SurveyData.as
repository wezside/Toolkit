package com.wezside.components.survey.data 
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.IIterator;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class SurveyData implements ISurveyData 
	{
		
		private var forms:ICollection = new Collection();
		
		
		public function getFormData( id:String ):IFormData
		{
			return forms.find( id ) as IFormData;
		}
		
		
		public function purgeData():void
		{
			var iterator:IIterator = forms.iterator();
			while ( iterator.hasNext())
			{
				var formData:IFormData = iterator.next() as IFormData;
				formData.purgeData();
			}
		}
	}
}
