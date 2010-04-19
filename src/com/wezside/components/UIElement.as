/*
	The MIT License

	Copyright (c) 2010 Wesley Swanepoel
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
 */
package com.wezside.components 
{
	import com.wezside.data.iterator.ChildIterator;
	import com.wezside.data.iterator.ArrayIterator;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;
	import com.wezside.utilities.manager.state.StateManager;
	import com.wezside.utilities.manager.style.IStyleManager;
	import com.wezside.utilities.string.StringUtil;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.StyleSheet;

	/**
	 * @author Wesley.Swanepoel
	 */

	[DefaultProperty("children")]
	[Event( name="initUIElement", type="com.wezside.components.UIElementEvent" )]
	[Event( name="uiCreationComplete", type="com.wezside.components.UIElementEvent" )]
	[Event( name="uiStyleManagerReady", type="com.wezside.components.UIElementEvent" )]
	public class UIElement extends Sprite implements IUIElement
	{

		private var _styleName:String;
		private var _skin:IUIElementSkin;
		private var _styleSheet:StyleSheet;
		private var _styleManager:IStyleManager;		
		private var _stateManager:StateManager;
		private var _inheritCSS:Boolean;
		private var _currentStyleName:String;
		
		protected var _children:Array;		

		
		public function UIElement() 
		{
			_children = [];
			_skin = new UIElementSkin();
			_stateManager = new StateManager();
			_stateManager.addState( UIElementState.STATE_VISUAL_SELECTED, true );
			_stateManager.addState( UIElementState.STATE_VISUAL_INVALID, true );
			_stateManager.addState( UIElementState.STATE_VISUAL_UP );
			_stateManager.addState( UIElementState.STATE_VISUAL_OVER );
			_stateManager.addState( UIElementState.STATE_VISUAL_DOWN );
			_stateManager.addState( UIElementState.STATE_VISUAL_DISABLED );
			_stateManager.state = UIElementState.STATE_VISUAL_UP;
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
			dispatchEvent( new UIElementEvent( UIElementEvent.CREATION_COMPLETE, false ));
		}		
		
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
				
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
			dispatchEvent( new UIElementEvent( UIElementEvent.STYLEMANAGER_READY ));
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
		
		public function get skin():IUIElementSkin
		{
			return _skin;
		}
				
		public function set skin( value:IUIElementSkin ):void
		{
			_skin = value;
		}				
		
		public function get inheritCSS():Boolean
		{
			return _inheritCSS;
		}
		
		public function set inheritCSS( value:Boolean ):void
		{
			_inheritCSS = value;			
		}		
				
		public function purge():void
		{
			_children = null;
			_styleManager = null;
			_styleName = null;
			_styleSheet = null;
		}		
		
		public function get state():String
		{
			return _stateManager.stateKey;
		}		
		
		public function set state( value:String ):void
		{
			_stateManager.state = value;
			_skin.setSkin( _stateManager.stateKeys );
		}
		
		public function setStyle():void
		{
			var iter:IIterator = iterator( "children" );
			if ( contains( DisplayObject( _skin ))) removeChild( DisplayObject( _skin ));
			
			// If this has a styleName then apply the styles
			if ( _styleName )
				setProperties( this, _styleName );					
			
			// Test for children
			while ( iter.hasNext() )
			{
				var child:* = iter.next();
				if ( child is IUIElement )
				{
					// Determine if the stylename should be inherited from parent if none was set 
					setProperties( child, IUIElement( child ).styleName ? IUIElement( child ).styleName : IUIElement( child ).inheritCSS ? _styleName : null );
				}
			}		

			iter = null;
			addChild( DisplayObject( _skin ));
			update( );
		}
		
		
		public function iterator( type:String = null ):IIterator
		{
			switch ( type )
			{
				case "props": return new ArrayIterator( styleManager.getPropertyStyles( _currentStyleName ));  
				case "children": return new ChildIterator( this );  
			}
			return new NullIterator();
		}		

		public function hasOwnProperty( V:* = undefined ):Boolean
		{
			return super.hasOwnProperty( V );
		}
		
		private function setProperties( child:DisplayObject, currentStyleName:String = "" ):void
		{
			_currentStyleName = currentStyleName;
			
			var iter:IIterator = iterator( "props" );
			var strUtil:StringUtil = new StringUtil( );
			
			while ( iter.hasNext() )
			{				
				var property:Object = iter.next();
				
				// Set all non skin properties
				if ( child.hasOwnProperty( property.prop ))
				{
					var value:* = String( property.value );
					if ( property.value == "false" || property.value == "true" )
						value = strUtil.stringToBoolean( property.value );
					
					if ( String( property.value ).indexOf( "#" ) != -1 )
						value = "0x" + String( property.value ).substring( 1 );
						
					if ( !isNaN(property.value ))
						value = Number( property.value );

					child[property.prop ] = value;
				}
				
				if ( _skin.hasSkinProperty( property.prop ))
					_skin[ property.prop ] = styleManager.getAssetByName( String( property.value ));
			}
			
			iter = null;
			strUtil = null;
		}

	}
}
