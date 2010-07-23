package com.wezside.components.survey.data 
{

	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.ICollection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.logging.Tracer;
	import com.wezside.utilities.manager.style.IStyleManager;

	public class FormData extends Object implements IFormData 
	{
		private var _id:String;
		private var _body:String;
		private var _cta:String;
		private var _heading:String;
		private var _subheading:String;
		private var _valid:Boolean;
		
		private var _metaData:Collection = new Collection();
		private var _groupsData:Collection = new Collection( );
		private var _styleManager:IStyleManager;
		private var _styleNameCollection:ICollection;
		private var _layoutDecorators:ICollection;

		public function addMetaData( meta:IFormMetaData ):void
		{
			_metaData.addElement( meta );
		}

		public function getMetaData( id:String ):IFormMetaData
		{
			return _metaData.find( id ) as IFormMetaData;
		}

		public function getMetaDataByIndex( index:uint ):IFormMetaData
		{
			return null;
		}

		public function addFormGroupData( group:IFormGroupData ):void
		{
			_groupsData.addElement( group );
		}

		public function getFormGroupData( id:String ):IFormGroupData
		{
			return _groupsData.find( id ) as IFormGroupData;
		}

		/**
		 * Return the last group id in the current form. In a paging navigational system, this 
		 * lookup is needed to establish the next form to show. By retrieving the last group 
		 * ID in the current form, it means the next time router.next() is called, the return 
		 * value will be the first group in the next form. This new ID can then be used to lookup
		 * the form ID in order to page to this new form.
		 */
		public function get lastGroupID():String 
		{
			var groupIterator:IIterator = iterator;
			while ( groupIterator.hasNext() )
			{
				var data:IFormGroupData = groupIterator.next() as IFormGroupData;
				if ( groupIterator.index( ) == groupIterator.length() && data.isInteractive )
				{
					groupIterator.purge();	
					return data.id;
				}
			}
			return null;
		}		

		public function purge():void
		{
			_groupsData.purge();
			_groupsData = null;
		}

		public function get id():String
		{
			return _id;
		}

		public function get body():String
		{
			return _body;
		}

		public function get cta():String
		{
			return _cta;
		}

		public function get heading():String
		{
			return _heading;
		}

		public function get subheading():String
		{
			return _subheading;
		}

		public function get valid():Boolean
		{
			return _valid;
		}

		public function get numMeta():uint
		{
			return 0;
		}

		public function set id( value:String ):void
		{
			_id = value;
		}

		public function set body( value:String ):void
		{
			_body = value;
		}

		public function set cta( value:String ):void
		{
			_cta = value;
		}

		public function set heading( value:String ):void
		{
			_heading = value;
		}

		public function set subheading( value:String ):void
		{
			_subheading = value;
		}

		public function set valid( value:Boolean ):void
		{
			_valid = value;
		}
		
		public function debug():void
		{
			trace("\r");
			Tracer.output( true, "\tFORM ID : " + _id + " | Group #" + _groupsData.length + " | Styles [" + styleNameCollection + "]", "");
			var formData:IFormGroupData;
			var iterator:IIterator = _groupsData.iterator();
			while ( iterator.hasNext())
			{
				formData = iterator.next() as IFormGroupData;
				formData.debug();
			}		
			iterator.purge();
			
			var metaData:IFormMetaData;
			iterator = _metaData.iterator();
			while ( iterator.hasNext())
			{
				metaData = iterator.next() as IFormMetaData;
				metaData.debug();
			}		
			iterator.purge( );
		}
		
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		public function get styleNameCollection():ICollection
		{
			return _styleNameCollection;
		}
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
		}
		
		public function set styleNameCollection( value:ICollection ):void
		{
			_styleNameCollection = value;
		}
		
		public function get iterator():IIterator
		{
			return _groupsData.iterator( );
		}
		
		public function get metaIterator():IIterator
		{
			return _metaData.iterator( );
		}
		
		public function get layoutDecorators():ICollection
		{
			return _layoutDecorators;
		}
		
		public function set layoutDecorators( value:ICollection ):void
		{
			_layoutDecorators = value;
		}
	}
}
