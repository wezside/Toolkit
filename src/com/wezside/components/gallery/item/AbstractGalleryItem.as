package com.wezside.components.gallery.item 
{
	import com.wezside.components.gallery.Gallery;
	import com.wezside.utilities.manager.state.StateManager;

	import flash.display.Loader;
	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class AbstractGalleryItem extends Sprite implements IGalleryItem 
	{
		
		protected var livedate:Date;
		protected var loader:Loader;
		protected var debug:Boolean;

		private var _type:String;
		private var _sm:StateManager;
		private var _selected:Boolean;
		private var _data:*;
		
		
		public function AbstractGalleryItem( type:String, debug:Boolean )
		{
			this.debug = debug;
			_type = type;
			_selected = false;
			_sm = new StateManager();
			_sm.addState( Gallery.STATE_ROLLOVER );
			_sm.addState( Gallery.STATE_ROLLOUT );
			_sm.addState( Gallery.STATE_SELECTED, true );				
		}
		
		public function update( dob:IGalleryItem ):void
		{
		}
		
		public function reset():void
		{			
			if ( _selected )
			{				
				state = "";
				state = Gallery.STATE_SELECTED;
			}
			state = "";
			state = Gallery.STATE_ROLLOUT;
		}		
		
		public function load( url:String, livedate:Date, linkage:String = "", thumbWidth:int = 80, thumbHeight:int = 80 ):void
		{
		}

		public function play():void
		{
		}
		
		public function stop():void
		{
		}		
		
		public function rollOver():void
		{
		}
		
		public function rollOut():void
		{
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected( value:Boolean ):void
		{
			_selected = value;
			mouseEnabled = !_selected;
		}

		public function get state():String
		{
			return _sm.stateKey;
		}
		
		public function set state( value:String ):void
		{
			_sm.stateKey = value;
			switch ( _sm.stateKey )
			{
				case Gallery.STATE_ROLLOUT:	rollOut(); break;
				case Gallery.STATE_ROLLOUT + Gallery.STATE_SELECTED: break;									
				case Gallery.STATE_ROLLOVER:
				case Gallery.STATE_ROLLOVER + Gallery.STATE_SELECTED: rollOver(); break;				
				case Gallery.STATE_SELECTED: selected = !_selected; break;					
				default: _sm.stateKey = ""; break;
			}
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type( value:String ):void
		{
			_type = value;
		}
		
		public function purge():void
		{
			_sm.purge();
			
			while ( this.numChildren > 0 )
				removeChildAt( 0 );

			livedate = null;
		}

		public function get data():*
		{
			return _data;
		}

		public function set data( value:* ):void
		{
			_data = value;
		}
	}
}
