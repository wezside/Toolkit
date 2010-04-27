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
	import com.wezside.components.scroll.IScroll;
	import com.wezside.components.layout.ILayout;
	import com.wezside.components.layout.Layout;
	import com.wezside.components.shape.IShape;
	import com.wezside.data.iterator.ArrayIterator;
	import com.wezside.data.iterator.ChildIterator;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;
	import com.wezside.utilities.manager.state.StateManager;
	import com.wezside.utilities.manager.style.IStyleManager;
	import com.wezside.utilities.string.StringUtil;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.StyleSheet;

	/**
	 * @author Wesley.Swanepoel
	 */
	[Event( name="initUIElement", type="com.wezside.components.UIElementEvent" )]
	[Event( name="uiCreationComplete", type="com.wezside.components.UIElementEvent" )]
	[Event( name="uiStyleManagerReady", type="com.wezside.components.UIElementEvent" )]
	public class UIElement extends Sprite implements IUIElement, IUIDecorator
	{
		public static const ITERATOR_PROPS:String = "ITERATOR_PROPS";
		public static const ITERATOR_CHILDREN:String = "ITERATOR_CHILDREN";

		private var _styleName:String;
		private var _skin:IUIElementSkin;
		private var _styleSheet:StyleSheet;
		private var _styleManager:IStyleManager;		
		private var _stateManager:StateManager;
		private var _inheritCSS:Boolean;
		private var _currentStyleName:String;
		private var _layout:ILayout;
		private var _background:IShape;
		private var _scroll:IScroll;

		public function UIElement() 
		{
			_skin = new UIElementSkin();
			_layout = new Layout( this );
			_stateManager = new StateManager();
			_stateManager.addState( UIElementState.STATE_VISUAL_SELECTED, true );
			_stateManager.addState( UIElementState.STATE_VISUAL_INVALID, true );
			_stateManager.addState( UIElementState.STATE_VISUAL_UP );
			_stateManager.addState( UIElementState.STATE_VISUAL_OVER );
			_stateManager.addState( UIElementState.STATE_VISUAL_DOWN );
			_stateManager.addState( UIElementState.STATE_VISUAL_DISABLED );
			_stateManager.stateKey = UIElementState.STATE_VISUAL_UP;
		}		
		
		public function update( recurse:Boolean = false ):void
		{
			build();
			setStyle();
			if ( recurse )
			{
				var iter:IIterator = iterator( ITERATOR_CHILDREN );
				while ( iter.hasNext() )
				{
					var child:* = iter.next();
					if ( child is IUIElement ) 
						UIElement( child ).update( recurse );
				}
			}	
			arrange();						
		}		
		
		public function build():void
		{
			if ( _background ) addChildAt( _background as DisplayObject, 0 );
			if ( _scroll ) addChild( _scroll as DisplayObject );
		}
		
		public function arrange( event:UIElementEvent = null ):void
		{
			if ( _layout ) _layout.arrange();
			if ( _background ) _background.arrange();
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

		public function get layout():ILayout
		{
			return _layout;
		}
		
		public function set layout( value:ILayout ):void
		{
			_layout = value;
			_layout.addEventListener( UIElementEvent.ARRANGE_COMPLETE, arrangeComplete );
		}		
		
		public function get background():IShape
		{
			return _background;
		}
		
		public function set background(value:IShape):void
		{
			_background = value;
		}		
		
		public function get scroll():IScroll
		{
			return _scroll;
		}
		
		public function set scroll( value:IScroll ):void
		{
			_scroll = value;
		}
	
		public function purge():void
		{
			var iter:IIterator = iterator( ITERATOR_CHILDREN );
			while ( iter.hasNext() )
			{
				var child:* = iter.next();
				if ( child is IUIElement ) UIElement( child ).purge();
				removeChild( child );
			}				
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
			_stateManager.stateKey = value;
			_skin.setSkin( _stateManager.stateKeys );
		}
		
		public function setStyle():void
		{
			var iter:IIterator = iterator( ITERATOR_CHILDREN );
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
					// Auto inject class name as stylename if exists
					/*
					if ( !IUIElement( child ).styleName )
					{
						var str:String = getQualifiedClassName( child ); 
						IUIElement( child ).styleName = str.substr( str.lastIndexOf(".")) ? str.substr( str.lastIndexOf(".")) : null;
					}*/
					
					// Update child styleName 
					IUIElement( child ).styleName = IUIElement( child ).styleName ? IUIElement( child ).styleName : IUIElement( child ).inheritCSS ? _styleName : null;
					
					
					// Inject the parent's styleManager if the child doesn't have one
					if ( !IUIElement( child ).styleManager && IUIElement( child ).styleName )
						IUIElement( child ).styleManager = styleManager;
				}
			}	

			iter = null;
			addChild( DisplayObject( _skin ));
		}
		
		
		public function iterator( type:String = null ):IIterator
		{
			switch ( type )
			{				
				case ITERATOR_PROPS: return new ArrayIterator( styleManager.getPropertyStyles( _currentStyleName ));  
				case ITERATOR_CHILDREN: return new ChildIterator( this );  
			}
			return new NullIterator();
		}		

		public function hasOwnProperty( V:* = undefined ):Boolean
		{
			return super.hasOwnProperty( V );
		}
		
		private function setProperties( child:IUIElement, currentStyleName:String = "" ):void
		{
			_currentStyleName = currentStyleName;
			
			var iter:IIterator = iterator( ITERATOR_PROPS );
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
						
					if ( !isNaN( property.value ))
						value = Number( property.value );

					child[ property.prop ] = value;
				}
				
				if ( _skin.hasSkinProperty( property.prop ))
					_skin[ property.prop ] = styleManager.getAssetByName( String( property.value ));
			}
			
			iter = null;
			strUtil = null;
		}

		protected function arrangeComplete( event:UIElementEvent ):void 
		{
			dispatchEvent( event );
		}

	}
}