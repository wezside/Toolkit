package com.wezside.components.survey.data 
{
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.IDeserializable;
	import com.wezside.data.collection.Collection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.logging.Tracer;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class SurveyData implements ISurveyData, IDeserializable 
	{
				
		public var layout:ICollection;
		public var customCSS:ICollection;
		public var components:ICollection;
		
		private var _forms:Collection = new Collection();
		
		public function getFormData( id:String ):IFormData
		{
			return _forms.find( id ) as IFormData;
		}
				
		public function purgeData():void
		{
			var iterator:IIterator = _forms.iterator();
			while ( iterator.hasNext())
			{
				var formData:IFormData = iterator.next() as IFormData;
				formData.purge();
			}
			iterator.purge();
		}
		
		public function addFormData( formData:IFormData ):void
		{
			_forms.addElement( formData );
		}
		
		public function get iterator():IIterator
		{
			return _forms.iterator( );
		}
		
		public function debug():void
		{
			Tracer.output( true, " --------------------- SURVEY DATA ----------------------", getQualifiedClassName( this ));
			var iterator:IIterator = _forms.iterator();
			while ( iterator.hasNext())
			{
				var formData:IFormData = iterator.next() as IFormData;
				formData.debug();
			}		
			iterator.purge();
			trace( "\r" );
			Tracer.output( true, " --------------------- END ----------------------", getQualifiedClassName( this ));
		}
	}
}
