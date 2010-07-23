package com.wezside.components.survey.data.router 
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.mapping.XMLDataMapper;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class SurveyRouter 
	{
		private var _mapper:XMLDataMapper;
		private var _iterator:IIterator;
		private var _targetRoute:Route;
		private var _endRoute:Route;
		private var _startID:String;

		
		public function SurveyRouter( xml:XML, debug:Boolean = false ) 
		{	
			_startID = "Start";
			_mapper = new XMLDataMapper();
			_mapper.addDataMap( Routing );		
			_mapper.addDataMap( Route, "Route", "routes" );		
			_mapper.debug = debug;
			_mapper.deserialize( xml );
		}

		public function build():void
		{
			reset();
			_iterator = Routing( _mapper.data ).routes.iterator();
			_endRoute = new Route();
			_endRoute.id = "[End]";
			_endRoute.nextpath = "[End]";
		}
		
		public function addRoute( route : Route ) : void
		{
			Collection( Routing( _mapper.data ).routes ).addElement( route );
		}
		
		public function getRoute( id : String ) : Route
		{
			return Routing( _mapper.data ).routes.find( id ) as Route;
		}

		public function next( value:String = "" ) : Route
		{				
			if ( value != "" && _targetRoute && _targetRoute.routes )
			{
				var child:Route = _targetRoute.routes.find( value ) as Route;
				if ( child )
				{					
					_targetRoute = child;
					return _targetRoute;		
				}				
			}
						
			if ( _targetRoute )
			{
				if ( value )
				{
					if ( !Routing( _mapper.data ).routes.find( value ) )
					{
						_targetRoute = Routing( _mapper.data ).routes.find( _targetRoute.nextpath ) as Route;
					}
					else
					{
						_targetRoute = Routing( _mapper.data ).routes.find( value ) as Route;						
					}
				}
				else
				{
					_targetRoute = Routing( _mapper.data ).routes.find( _targetRoute.nextpath ) as Route;
				}
			}
			else
			{
				_targetRoute = Routing( _mapper.data ).routes.find( _startID ) as Route;
			}				
			return _targetRoute.nextpath ? _targetRoute : _endRoute;
		}
		
		public function hasChild( id:String ):Boolean
		{
			var nextRoute:Route = Routing( _mapper.data ).routes.find( _targetRoute.id ) as Route;	
			if ( nextRoute && nextRoute.routes )
			{
				var child:Route = nextRoute.routes.find( id ) as Route;
				if ( child ) return true;		
			}
			return false;
		}
		
		public function reset():void
		{			
			_targetRoute = null;
		}
		
		public function get startID():String
		{
			return _startID;
		}
		
		public function set startID( value:String ):void
		{
			_startID = value;
		}
		
	}
}
