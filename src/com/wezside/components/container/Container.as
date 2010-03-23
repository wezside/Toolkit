package com.wezside.components.container 
{
	import com.wezside.utilities.managers.style.IStyleManager;
	import com.wezside.utilities.string.StringUtils;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.StyleSheet;

	/**
	 * @author Wesley.Swanepoel 
	 */

	[DefaultProperty("children")]
	[Event( name="init", type="com.modulo.event.ModuleEvent" )]
	[Event( name="creationComplete", type="com.modulo.event.ModuleEvent" )]
	public class Container extends Sprite implements IContainer
	{

		protected var _children:Array;
		
		private var _styleName:String;
		private var _styleSheet:StyleSheet;
		private var _styleManager:IStyleManager;		

		
		public function Container() 
		{
			_children = [];
		}		
		
		public function update():void
		{
		}		
				
		public function get children():Array
		{
			return _children;	
		}		
		
		public function set children( value:Array ):void
		{
			if ( _children != value )
			{
				if ( _children.length > 0 )
					for ( var i:int = 0; i < this.numChildren; ++i ) 
						removeChildAt( i );
								
				_children = value;
				updateDisplayList();
			}
		}
		

		protected function updateDisplayList():void
		{
			for ( var i:int = 0; i < _children.length; ++i ) 
				if ( _children[i] != null && _children[i] is DisplayObject )
					addChild( _children[i] );
			addEventListener( Event.ENTER_FRAME, nextFrame );
		}
		
		
		private function nextFrame( event:Event ):void
		{
			removeEventListener( Event.ENTER_FRAME, nextFrame );
			dispatchEvent( new ContainerEvent( ContainerEvent.CREATION_COMPLETE, false ));
		}		

		
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
			setStyle();
		}
		

		public function get styleName():String
		{
			return _styleName;
		}


		public function set styleName( value:String ):void
		{
			_styleName = value;
		}

		
		public function get styleSheet():StyleSheet
		{
			return _styleSheet;
		}

		
		public function set styleSheet( value:StyleSheet ):void
		{
			_styleSheet = value;
		}		
		
		
		public function purge():void
		{
		}		
		
		
		/**
		 * TODO: Need to do a lookup to StyleManager class and do the following within StyleManager:
		 *  		  
		 *  o Parse StyleSheet and create 3 CSS types from single selector
		 *  	 1. Pure text local StyleSheet instance for styleName block  
		 *  	 2. Collate all Symbols in Selector CSS to local list
		 *  	 3. Collate all custom props as object list and apply the values to corresponding props - 
		 *  	 	may require mapings from CSS names to class props
		 *  	  
		 *  o Create local StyleSheet object with selector in CSS file 
		 *  o Look-up linkage identifiers in CSS and get instance from styles SWF and store them locally
		 *  
		 *  Usage:
		 *  StyleManager.getStyleSheet( stlyeName ):StyleSheet;
		 *  StyleManager.getLibraryItems( stlyeName ):Array;
		 *  StyleManager.getPropertyStyles( stlyeName ):Array;
		 *  
		 */				
		protected function setStyle():void
		{
			if ( _styleName != null )
			{
				for ( var i:int = 0; i < this.numChildren; ++i ) 
				{
					var child:DisplayObject = this.getChildAt(i);
					if ( child.parent is Box )
						setProperties( child.parent, styleManager.getPropertyStyles( _styleName ));
					else
						setProperties( child, styleManager.getPropertyStyles( _styleName ));
				}		
			}
			update( );
		}

		
		private function setProperties( child:DisplayObject, props:Array ):void
		{
			var strUtil:StringUtils = new StringUtils();
			_styleSheet = styleManager.getStyleSheet( _styleName );
									
			for ( var k:int = 0; k < props.length; ++k ) 
			{
				if ( child.hasOwnProperty( props[k].prop ))
				{
					var value:* = String( props[k].value );
					if ( props[k].value == "false" || props[k].value == "true" )
						value = strUtil.stringToBoolean( props[k].value );
					
					if ( String( props[k].value ).indexOf( "#" ) != -1 )
						value = "0x" + String( props[k].value ).substring( 1 );
						
					if ( !isNaN( props[k].value ))
						value = Number( props[k].value );
						
					child[props[k].prop] = value;
				}
			}
			strUtil = null;
		}
	}
}
