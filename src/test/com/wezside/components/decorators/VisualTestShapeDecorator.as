package test.com.wezside.components.decorators
{
	import com.wezside.components.UIElement;
	import com.wezside.components.decorators.layout.PaddedLayout;
	import com.wezside.components.decorators.shape.ShapeRectangle;
	import com.wezside.components.text.Label;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestShapeDecorator extends UIElement
	{
		private var label:Label;

		public function VisualTestShapeDecorator()
		{
			super();			
			addEventListener( Event.ADDED_TO_STAGE, stageInit );	
		}

		private function stageInit( event:Event ):void 
		{			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
									
			layout = new PaddedLayout( this );
			layout.top = 10;
			layout.bottom = 10;
			layout.left = 10;
			layout.right = 10;
						
 			label = new Label();
 			label.border = true;
 			label.borderColor = 0xffffff;
 			label.autoSize = TextFieldAutoSize.LEFT;
 			label.width = 180;
 			label.multiline = true;
 			label.wordWrap = true;
 			label.textColor = 0xffffff;
 			label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eu nunc non risus cursus pellentesque dapibus eget elit. Duis venenatis libero tempus sapien eleifend vel placerat augue feugiat. ";
 			label.build();
 			label.arrange();
			addChild( label );
			
			background = new ShapeRectangle( this );
			background.alphas = [ 0.3, 0.3 ];
			background.colours = [ 0xefefef, 0xaeaeae ];
			background.cornerRadius = 50;
			
			background = new ShapeRectangle( this.background );
			background.alphas = [ 0.3, 0.3 ];
			background.colours = [ 0xff0000, 0xff0000 ];
			background.yOffset = 115;
			
			build();
			arrange();
			
			x = 20;
			y = 20;
			
			stage.addEventListener( Event.RESIZE, onStageResize );
		}

		private function onStageResize( event:Event = null ):void 
		{
			if ( stage )
			{				
				label.width = stage.stageWidth - 50;	
				label.height = label.y + label.height + 50;

				background.width = label.width + layout.left + layout.right;
				
				background.yOffset = label.height + 1 + layout.top + layout.bottom;
				background.arrange();
			}			
		}
	}
}
