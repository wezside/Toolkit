package test.com.wezside.components 
{
	import flash.text.TextFieldAutoSize;
	import com.wezside.components.UIElement;
	import com.wezside.components.decorators.layout.PaddedLayout;
	import com.wezside.components.decorators.layout.VerticalLayout;
	import com.wezside.components.decorators.scroll.ScrollVertical;
	import com.wezside.components.decorators.shape.Rectangle;
	import com.wezside.components.text.Label;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestDecorators extends UIElement 
	{
		
		private var hbox:UIElement;
		private var label:Label;

		
		public function VisualTestDecorators()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, initStage );
		}

		private function initStage( event:Event ):void 
		{			
						
			x = 20;
			y = 20;				
			
			layout = new PaddedLayout( this ); 
			layout.bottom = 15;		
			layout.left = 15;
			layout.top = 15;
			layout.right = 15;
			
			layout = new VerticalLayout( layout );
			layout.verticalGap = 3;	
						
			background = new Rectangle( this );
			background.colours = [ 0, 0 ];
			background.alphas = [ 1, 1 ];
			background.cornerRadius = 10;
			
			scroll = new ScrollVertical( this );
			scroll.scrollHeight = 150; 
			scroll.horizontalGap = 2;
  			
 			label = new Label();
 			label.autoSize = TextFieldAutoSize.LEFT;
 			label.width = 200;
 			label.multiline = true;
 			label.wordWrap = true;
 			label.textColor = 0xffffff;
 			label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eu nunc non risus cursus pellentesque dapibus eget elit. Duis venenatis libero tempus sapien eleifend vel placerat augue feugiat. Suspendisse potenti. Cras vel ipsum purus. Aenean vel felis leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean urna eros, bibendum sed iaculis ut, varius ut orci. Integer lacus turpis, ultricies imperdiet suscipit sed, volutpat ultrices metus. Nunc eu sem eu quam pharetra volutpat. Donec nec leo felis. Phasellus eu lacus velit, ac accumsan libero. Nam et imperdiet quam.";
 			label.build();
 			label.setStyle();
 			label.arrange();
			addChild( label );
 
			addEventListener( Event.ENTER_FRAME, enterFrame );
		}

		private function enterFrame(event:Event):void 
		{
			removeEventListener( Event.ENTER_FRAME, enterFrame );
			build();
			arrange();
		}

		override public function build():void
		{			
			
			
			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xff0000 ];
			hbox.background.alphas = [ 1 ];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.background.topLeftRadius = 10;
			hbox.background.bottomRightRadius = 10;
			hbox.build();
			hbox.arrange();
			hbox.setStyle();
			hbox.activate();
			addChild( hbox );

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xFF5100, 0xFF5100 ];
			hbox.background.alphas = [ 1, 1];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build();
			hbox.arrange();
			hbox.activate();
			addChild( hbox );
	

			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xFFF300, 0xFFF300 ];
			hbox.background.alphas = [ 1, 1];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build();
			hbox.arrange();					
			addChild( hbox );
			
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill( 0xEEEEE );
			sp.graphics.drawRect(0, 0, 200, 50 );
			sp.graphics.endFill();
			addChild( sp );
			
			hbox = new UIElement();
			hbox.background = new Rectangle( hbox );
			hbox.background.colours = [ 0xFFF300, 0xFFF300 ];
			hbox.background.alphas = [ 1, 1];			
			hbox.background.width = 200;
			hbox.background.height = 50;
			hbox.build();
			hbox.arrange();					
			addChild( hbox );			
	
			super.build();
		}	
	}
}
