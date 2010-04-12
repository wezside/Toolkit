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
			if ( contains( DisplayObject( _skin ))) removeChild( DisplayObject( _skin ));
			for ( var i:int = 0; i < this.numChildren; ++i ) 
			{
				var child:* = this.getChildAt( i );
				if ( child is UIElement )
					setProperties( child, styleManager.getPropertyStyles( IUIElement( child ).styleName ? IUIElement( child ).styleName : _styleName ));
				else
					setProperties( child, styleManager.getPropertyStyles( _styleName ));					
			}
						
			if ( _styleName )
				setProperties( this, styleManager.getPropertyStyles( _styleName ));				

			addChild( DisplayObject( _skin ));
			update( );
		}
		
		public function hasOwnProperty( V:* = undefined ):Boolean
		{
			return super.hasOwnProperty( V );
		}
		
		private function setProperties( child:DisplayObject, props:Array ):void
		{
			var strUtil:StringUtil = new StringUtil();
			for ( var k:int = 0; k < props.length; ++k ) 
			{
				// Set all non skin properties
				if ( child.hasOwnProperty( props[k].prop ))
				{
					var value:* = String( props[k].value );
					if ( props[k].value == "false" || props[k].value == "true" )
						value = strUtil.stringToBoolean( props[k].value );
					
					if ( String( props[k].value ).indexOf( "#" ) != -1 )
						value = "0x" + String( props[k].value ).substring( 1 );
						
					if ( !isNaN( props[k].value ))
						value = Number( props[k].value );

					child[ props[k].prop ] = value;
				}
				
				if ( _skin.hasOwnProperty( props[k].prop ))
					_skin[ props[k].prop ] = styleManager.getAssetByName( String( props[k].value ));
			}
			strUtil = null;
		}

	}
}
