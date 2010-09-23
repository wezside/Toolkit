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
	import flash.geom.Rectangle;
	import com.wezside.components.decorators.scroll.ScrollHorizontal;
	import com.wezside.components.decorators.scroll.ScrollVertical;
	import com.wezside.components.decorators.interactive.IInteractive;
	import com.wezside.components.decorators.interactive.Interactive;
	import com.wezside.components.decorators.layout.ILayout;
	import com.wezside.components.decorators.layout.Layout;
	import com.wezside.components.decorators.scroll.IScroll;
	import com.wezside.components.decorators.scroll.ScrollEvent;
	import com.wezside.components.decorators.shape.IShape;
	import com.wezside.data.iterator.ArrayIterator;
	import com.wezside.data.iterator.ChildIterator;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.data.iterator.NullIterator;
	import com.wezside.utilities.logging.Tracer;
	import com.wezside.utilities.manager.state.StateManager;
	import com.wezside.utilities.manager.style.IStyleManager;
	import com.wezside.utilities.string.StringUtil;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Wesley.Swanepoel
	 */
	[Event( name="initUIElement", type="com.wezside.components.UIElementEvent" )]
	[Event( name="uiCreationComplete", type="com.wezside.components.UIElementEvent" )]
	[Event( name="uiStyleManagerReady", type="com.wezside.components.UIElementEvent" )]
	public class UIElement extends Sprite implements IUIElement, IInteractive
	{
		
		public static const ITERATOR_PROPS:String = "ITERATOR_PROPS";
		public static const ITERATOR_CHILDREN:String = "ITERATOR_CHILDREN";

		private var _styleName:String;
		private var _skin:IUIElementSkin;
		private var _styleSheet:StyleSheet;
		private var _styleManager:IStyleManager;		
		private var _stateManager:StateManager;
		private var _currentStyleName:String;
		private var _childrenContainer:Sprite;
		
		// Decorators
		private var _layout:ILayout;
		private var _scroll:IScroll;
		private var _background:IShape;
		private var _interactive:IInteractive;
		private var _debug:Boolean;

		public function UIElement() 
		{
			_skin = new UIElementSkin();  
			_layout = new Layout( this ); 
			_interactive = new Interactive( this );
			_childrenContainer = new Sprite();
			_stateManager = new StateManager();
			_stateManager.addState( UIElementState.STATE_VISUAL_INVALID, true );
			_stateManager.addState( UIElementState.STATE_VISUAL_SELECTED, true );
			_stateManager.addState( UIElementState.STATE_VISUAL_UP );
			_stateManager.addState( UIElementState.STATE_VISUAL_OVER );
			_stateManager.addState( UIElementState.STATE_VISUAL_DOWN );
			_stateManager.addState( UIElementState.STATE_VISUAL_DISABLED );
			_stateManager.addState( UIElementState.STATE_VISUAL_CLICK );
			_stateManager.stateKey = UIElementState.STATE_VISUAL_UP;
		}		
		
		override public function addChild( child:DisplayObject ):DisplayObject 
		{
			return _childrenContainer.addChild( child );
		}
			
		override public function addChildAt( child:DisplayObject, index:int ):DisplayObject 
		{
			return _childrenContainer.addChildAt( child, index );
		}
		
		override public function removeChild( child:DisplayObject ):DisplayObject 
		{
			return _childrenContainer.removeChild( child );
		}

		override public function get numChildren():int 
		{
			return _childrenContainer.numChildren;
		}
		
		override public function getChildByName( name:String ):DisplayObject 
		{
			return _childrenContainer.getChildByName( name );
		}
		
		public function get numUIChildren():int
		{
			return super.numChildren;
		}

		public function removeUIChild( child:DisplayObject ):DisplayObject
		{
			return super.removeChild( child ); 
		}

		public function addUIChild( child:DisplayObject ):DisplayObject
		{
			return super.addChild( child ); 
		}
		
		public function getUIChildByName( name:String ):DisplayObject 
		{
			return getChildByName( name );
		}		
				
		public function build():void
		{
			if ( _background ) super.addChildAt( _background as DisplayObject, 0 );
			if ( _scroll )
			{
				 super.addChild( _scroll as DisplayObject );
			}
			super.addChild( DisplayObject( _skin ));	
			super.addChild( _childrenContainer );
		}
		
		public function setStyle():void
		{
			// If this has a styleName then apply the styles
			if ( _styleName && styleManager )
				setProperties( this, _styleName );
			else
			{
				// Grab Constructor as styleName
				var qualifiedClass:String = getQualifiedClassName( this );				
				_styleName = qualifiedClass.substr( qualifiedClass.lastIndexOf( "::" ) + 2 );
				
				if ( styleManager )
					setProperties( this, _styleName );
			}
		}

		public function arrange():void
		{
			if ( _layout ) _layout.arrange();
			if ( _scroll )
			{
				_scroll.arrange();
				drawScrollMask();
			}
			if ( _background ) _background.arrange();
		}
		
		public function activate():void
		{
			_interactive.activate();
		}

		public function deactivate():void
		{
			_interactive.deactivate();
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
		
		public function set background( value:IShape ):void
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
			_scroll.addEventListener( ScrollEvent.CHANGE, scrollChange );
		}
	
		public function get interactive():IInteractive
		{
			return _interactive;
		}
		
		public function set interactive( value:IInteractive ):void
		{
			_interactive = value;
		}
	
		public function purge():void
		{
			var iter:IIterator = iterator( ITERATOR_CHILDREN );
			while ( iter.hasNext() )
			{
				var child:* = iter.next();
				if ( child is IUIElement ) UIElement( child ).purge();
				if ( _childrenContainer ) 
					_childrenContainer.removeChild( child );
			}				
			if ( _childrenContainer && contains( _childrenContainer )) removeUIChild( _childrenContainer );
			if ( _scroll && contains( DisplayObject( _scroll ) )) removeUIChild( DisplayObject( _scroll ));
			if ( _skin && contains( DisplayObject( _skin ) )) removeUIChild( DisplayObject( _skin ));
			if ( _background && contains( DisplayObject( _background ) )) removeUIChild( DisplayObject( _background ));
			iter = null;
			_styleManager = null;
			_styleName = null;
			_styleSheet = null;
			_background = null;
			_skin = null;
			_scroll = null;
		}		
		
		public function get state():String
		{
			return _stateManager.stateKey;
		}		
		
		public function set state( value:String ):void
		{
			_stateManager.stateKey = value;
			_skin.setSkin( _stateManager.stateKeys );
			dispatchEvent( new UIElementEvent( UIElementEvent.STATE_CHANGE, false, false, _stateManager.state ));
		}
		
		public function get stateManager():StateManager
		{
			return _stateManager;
		}
		
		public function set stateManager( value:StateManager ):void
		{
			_stateManager = value;
		}
		
		public function iterator( type:String = null ):IIterator
		{
			switch ( type )
			{				
				case ITERATOR_PROPS: return new ArrayIterator( styleManager.getPropertyStyles( _currentStyleName ));  
				case ITERATOR_CHILDREN: return new ChildIterator( _childrenContainer );  
			}
			return new NullIterator();
		}		

		public function hasOwnProperty( V:* = undefined ):Boolean
		{
			return super.hasOwnProperty( V );
		}
		
		public function get debug():Boolean
		{
			return _debug;
		}
		
		public function set debug( value:Boolean ):void
		{
			_debug = value;
		}
		
		protected function arrangeComplete( event:UIElementEvent ):void 
		{
			dispatchEvent( event );
		}
				
		protected function scrollChange( event:ScrollEvent ):void 
		{			
			var childContainerProp:String = event.prop == "y" ? "height" : "width";
			_childrenContainer[ event.prop ] = -event.percent * ( _childrenContainer[ childContainerProp ] -  event.scrollValue );
		}		
		
		private function drawScrollMask():void 
		{
			var w:int = scroll is ScrollHorizontal ? _scroll.scrollWidth : width;
			var h:int = scroll is ScrollVertical ? _scroll.scrollHeight : height;
			var scrollMask:Sprite = new Sprite();
			scrollMask.graphics.beginFill( 0xefefef, 0.5 );
			scrollMask.graphics.drawRect( layout.left, layout.top, w, h );
			scrollMask.graphics.endFill();
			super.addChild( scrollMask );
			_childrenContainer.mask = scrollMask;
		}		
		
		private function setProperties( target:IUIElement, currentStyleName:String = "" ):void
		{
			_currentStyleName = currentStyleName;
			var iter:IIterator = iterator( ITERATOR_PROPS );
			var strUtil:StringUtil = new StringUtil( );
			
			while ( iter.hasNext() )
			{				
				var property:Object = iter.next();
				
				// Set all non skin properties
				if ( target.hasOwnProperty( property.prop ))
				{
					var value:* = String( property.value );
					if ( property.value == "false" || property.value == "true" )
						value = strUtil.stringToBoolean( property.value );
					
					if ( String( property.value ).indexOf( "#" ) != -1 )
						value = "0x" + String( property.value ).substring( 1 );
						
					if ( !isNaN( property.value ))
						value = Number( property.value );

					target[ property.prop ] = value;
					Tracer.output( _debug, " " + property.prop + ": " + value, toString() );
				}
				
				if ( _skin.hasSkinProperty( property.prop ))
					_skin[ property.prop ] = styleManager.getAssetByName( String( property.value ));
			}
			
			if ( _skin.hasSkinProperty( "upSkin" ) && state == "" )
				state = UIElementState.STATE_VISUAL_UP;
			
			iter = null;
			strUtil = null;
		}
	}
}