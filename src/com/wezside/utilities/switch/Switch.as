package com.wezside.utilities.switch {
	import flash.utils.Dictionary;	import flash.utils.getQualifiedClassName;		
	/**
	 * @author Wesley.Swanepoel	 * 	 * A simple class to return switches based on xml.  
	 */
	public class Switch 	{				private static var switches:Dictionary;		private static var instance:Switch;		public function Switch() 		{			if ( instance )				throw new Error( "An instance already exists. Please use getInstance()" );							switches = new Dictionary();		}				public static function getInstance():Switch  		{			if ( instance )				instance = new Switch( );			return instance;		}				public function addSwitch( id:String, _property:String, _value:String ):void		{			switches[id] = { property: _property, value: _value };		}				public function getSwitch( id:String ):Object		{			return switches[id];		}		public function getValue( id:String ):String		{			return switches[id].value || "";		}		public function getPropertyByID( id:String ):String		{			return String( switches[id].property ) || ""; 		}		public function stringToBoolean( string:String ):Boolean		{			if ( string ) return ( string.toLowerCase() == "true" || string.toLowerCase() == "1");			return false;;		}				public function toString():String 		{			return getQualifiedClassName( this );		}
	}
}
