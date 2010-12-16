package com.wezside.utilities.business.rpc
{
	import com.wezside.utilities.business.IResponder;
	import com.wezside.utilities.business.ResponderEvent;
	import com.wezside.utilities.logging.Tracer;

	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.LoadEvent;
	import mx.rpc.soap.Operation;
	import mx.rpc.soap.WebService;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Webservice extends WebService implements IService
	{
		
		private var _loaded:Boolean;
		private var _method:String;
		private var _responder:IResponder;

		private static const DEBUG:Boolean = false;
		private var _asyncToken:Number;

		
		public function Webservice( destination:String = null, rootURL:String = null )
		{
			super( destination, rootURL );
			Tracer.output( DEBUG, " Webservice.Webservice(destination, rootURL)", toString() );			
			addEventListener( LoadEvent.LOAD, wsdlLoaded );
			addEventListener( FaultEvent.FAULT, fault );
			addEventListener( ResultEvent.RESULT, result );			
		}
		
		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		public function set loaded( value:Boolean ):void
		{
			_loaded = value;
		}
		
		public function send( params:Object = null, operation:String = "" ):Boolean
		{
			Tracer.output( DEBUG, " Webservice.send(args, operation) " + _loaded, toString() );	
			if ( _loaded )
			{
				getOperation( operation ).arguments = params;
				getOperation( operation ).send();
			}
			else
			{
				Tracer.output( DEBUG, " Webservice WSDL not loaded.", toString(), Tracer.ERROR );
				dispatchEvent( new ResponderEvent( ResponderEvent.FAULT, false, false, " Webservice WSDL not loaded." ));
			}
			return _loaded;
		}
		
		
		public function kill():void
		{
			removeEventListener( LoadEvent.LOAD, wsdlLoaded );
			removeEventListener( FaultEvent.FAULT, fault );
			removeEventListener( ResultEvent.RESULT, result );
			_responder = null;
			_loaded = false;					
		}
		
		override public function toString():String
		{
			return getQualifiedClassName( this );
		}
		
		public function get responder():IResponder
		{
			return _responder;
		}
		
		public function set responder( value:IResponder ):void
		{
			_responder = value;
		}
		
		public function get url():String
		{
			return destination;
		}
		
		public function get method():String
		{
			return _method;
		}
		
		public function get contentType():String
		{
			return "";
		}
		
		public function set url( value:String ):void
		{
		}
		
		public function set method( value:String ):void
		{
			_method = value;
		}
		
		public function set contentType( value:String ):void
		{
		}
		
		public function initOperation( operation:Operation ):void
		{
			initializeOperation( operation );	
		}
		
		override public function get headers():Array 
		{
			return super.headers;
		}
		
		public function set headers( value:Array ):void
		{
			for ( var i:int = 0; i < value.length; ++i ) 
				addHeader( value[i] );	
		}
		
		public function get asyncToken():Number
		{
			return _asyncToken;
		}
		
		public function set asyncToken(value:Number):void
		{
			_asyncToken = value;
		}				

		private function wsdlLoaded( event:LoadEvent ):void
		{
			Tracer.output( DEBUG, " Webservice.wsdlLoaded(event)", toString() );
			_loaded = true;
			removeEventListener( LoadEvent.LOAD, wsdlLoaded );
		}

		private function fault( event:FaultEvent ):void
		{
			Tracer.output( DEBUG, " Webservice.fault(event)", toString() );			
			if ( _responder != null )			
			{				
				_responder.fault( new ResponderEvent( ResponderEvent.FAULT, false, false, null, event.messageId, event.message.body.toString(), event.statusCode, asyncToken ));
			}
			else
			{
				dispatchEvent( new ResponderEvent( ResponderEvent.FAULT, false, false, null, event.messageId, event.message.body.toString(), event.statusCode, asyncToken ));
			}			
		}
	
		private function result( event:ResultEvent ):void
		{
			if ( _responder != null )
			{
				_responder.result( new ResponderEvent( ResponderEvent.RESULT, false, false, event.result, "", "", 0, _asyncToken ));
			}
			else
			{
				dispatchEvent( new ResponderEvent( ResponderEvent.RESULT, false, false, event.result, "", "", 0, _asyncToken ));
			}	
		}
	}
}
