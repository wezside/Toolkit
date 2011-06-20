package com.wezside.component.decorator.interactive 
{
	import com.wezside.component.IUIElement;
	import com.wezside.component.UIElement;
	import com.wezside.component.UIElementState;
	import com.wezside.data.iterator.IIterator;
	import com.wezside.utilities.manager.state.StateManager;

	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;


	/**
	 * @author Wesley.Swanepoel
	 */
	public class InteractiveSelectable extends EventDispatcher implements IInteractive
	{
		
		protected var decorated:IUIElement;

		public function InteractiveSelectable( decorated:IUIElement )
		{
			this.decorated = decorated;
		}

		public function activate():void
		{
			decorated.state = UIElementState.STATE_VISUAL_UP;
			decorated.buttonMode = true;
			decorated.addEventListener( MouseEvent.ROLL_OVER, rollOver );
			decorated.addEventListener( MouseEvent.ROLL_OUT, rollOut );
			decorated.addEventListener( MouseEvent.MOUSE_DOWN, down );
			decorated.addEventListener( MouseEvent.MOUSE_UP, mouseUp  );		
			decorated.addEventListener( MouseEvent.CLICK, click );		
		}
		
		public function deactivate():void
		{
			decorated.state = UIElementState.STATE_VISUAL_DISABLED;
			decorated.buttonMode = false;
			decorated.removeEventListener( MouseEvent.ROLL_OVER, rollOver );
			decorated.removeEventListener( MouseEvent.ROLL_OUT, rollOut );
			decorated.removeEventListener( MouseEvent.MOUSE_DOWN, down );
			decorated.removeEventListener( MouseEvent.MOUSE_UP, mouseUp  );		
			decorated.removeEventListener( MouseEvent.CLICK, click );		
		}
			
		private function mouseUp( event:MouseEvent ):void 
		{			
			decorated.state = UIElementState.STATE_VISUAL_UP;
		}			

		private function rollOver( event:MouseEvent ):void 
		{
			decorated.state = UIElementState.STATE_VISUAL_OVER;
		}

		private function rollOut( event:MouseEvent ):void 
		{
			decorated.state = UIElementState.STATE_VISUAL_UP;
		}

		public function click( event:MouseEvent ):void 
		{
			decorated.state = UIElementState.STATE_VISUAL_SELECTED;
		}

		private function down( event:MouseEvent ):void 
		{
			decorated.state = UIElementState.STATE_VISUAL_DOWN;
		}

		public function get state():String
		{
			return decorated.state;
		}
		
		public function set state( value:String ):void
		{
			stateManager.stateKey = value;
		}
		
		public function iterator( type:String = null ):IIterator
		{
			return decorated.iterator( UIElement.ITERATOR_CHILDREN );
		}
		
		public function arrange():void
		{
		}
		
		public function get width():Number
		{
			return 0;
		}
		
		public function get height():Number
		{
			return 0;
		}
		
		public function set width(value:Number):void
		{
		}
		
		public function set height(value:Number):void
		{
		}
		
		public function get buttonMode():Boolean
		{
			return decorated.buttonMode;
		}
		
		public function set buttonMode(value:Boolean):void
		{
			decorated.buttonMode = value;
		}

		public function get stateManager():StateManager
		{
			return decorated.stateManager;
		}
		
		public function set stateManager(value:StateManager):void
		{
			decorated.stateManager = value;
		}
		
		public function get mouseChildren():Boolean
		{
			return decorated.mouseChildren;
		}
		
		public function set mouseChildren(value:Boolean):void
		{
			decorated.mouseChildren = value;
		}
	}
}
