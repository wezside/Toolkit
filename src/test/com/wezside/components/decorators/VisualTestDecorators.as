package test.com.wezside.components.decorators 
{
	import com.wezside.components.decorators.layout.HorizontalLayout;
	import com.wezside.components.decorators.scroll.ScrollHorizontal;
	import com.wezside.components.UIElement;
	import com.wezside.components.UIElementEvent;
	import com.wezside.components.UIElementState;
	import com.wezside.components.decorators.layout.PaddedLayout;
	import com.wezside.components.decorators.layout.VerticalLayout;
	import com.wezside.components.decorators.scroll.ScrollVertical;
	import com.wezside.components.decorators.shape.ShapeRectangle;
	import com.wezside.components.text.Label;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestDecorators extends UIElement 
	{

		private var hbox:UIElement;
		private var label:Label;

		
		public function VisualTestDecorators()
		{
			super( );
			addEventListener( Event.ADDED_TO_STAGE, initStage );
		}

		private function initStage( event:Event ):void 
		{						
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		
			x = 20;
			y = 20;
						
			layout = new PaddedLayout( this ); 
			layout.bottom = 20;		
			layout.left = 20;
			layout.right = 20;
			layout.top = 20;
			
			layout = new VerticalLayout( this.layout );
			layout.verticalGap = 5;
			scroll = new ScrollVertical( this );
			scroll.scrollHeight = 200;
			scroll.horizontalGap = 2;

//			layout = new HorizontalLayout( this.layout );			
//			layout.horizontalGap = 5;
//			scroll = new ScrollHorizontal( this );
//			scroll.scrollWidth = 300;
//			scroll.verticalGap = 5;
																	
			background = new ShapeRectangle( this );
			background.colours = [ 0, 0 ];
			background.alphas = [ 1, 1 ];
  			
 			label = new Label();
 			label.border = true;
 			label.borderColor = 0x999999;
 			label.autoSize = TextFieldAutoSize.LEFT;
 			label.width = 199;
 			label.multiline = true;
 			label.wordWrap = true;
 			label.textColor = 0xffffff;
 			label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eu nunc non risus cursus pellentesque dapibus eget elit. Duis venenatis libero tempus sapien eleifend vel placerat augue feugiat. ";
 			label.build();
 			label.setStyle();
 			label.arrange();
//			addChild( label );

			addEventListener( Event.ENTER_FRAME, enterFrame );
		}

		private function enterFrame(event:Event):void 
		{
			removeEventListener( Event.ENTER_FRAME, enterFrame );
			build( );
			arrange( );
//			removeChildAt( 0 );
//			arrange( );
		}

		override public function build():void
		{			
						
			hbox = new UIElement( );
			hbox.background = new ShapeRectangle( hbox );
			hbox.background.colours = [ 0xff0000 ];
			hbox.background.alphas = [ 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build( );
			hbox.arrange( );
			hbox.setStyle( );
			hbox.activate( );
			addChild( hbox );

			hbox = new UIElement( );
			hbox.background = new ShapeRectangle( hbox );
			hbox.background.colours = [ 0xFF5100, 0xFF5100 ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build( );
			hbox.arrange( );
			hbox.activate( );
			addChild( hbox );	

			hbox = new UIElement( );
			hbox.background = new ShapeRectangle( hbox );
			hbox.background.colours = [ 0xFFF300, 0xFFF300 ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build( );
			hbox.arrange( );					
			addChild( hbox );
			
			hbox = new UIElement( );
			hbox.background = new ShapeRectangle( hbox );
			hbox.background.colours = [ 0xffaa56, 0xffaa56 ];
			hbox.background.alphas = [ 1, 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build( );
			hbox.arrange( );
			addChild( hbox );			
			
			var sp:Sprite = new Sprite( );
			sp.graphics.beginFill( 0xEEEEE );
			sp.graphics.drawRect( 0, 0, 200, 50 );
			sp.graphics.endFill( );
			addChild( sp );
		
			super.build( );
		}

		private function stateChange(event:UIElementEvent):void 
		{
			if ( event.state.key == UIElementState.STATE_VISUAL_CLICK )
			{
			}
		}
	}
}
