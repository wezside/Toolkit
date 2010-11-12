package test.com.wezside.components.combo 
{
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import com.wezside.components.decorators.layout.PaddedLayout;
	import com.wezside.components.decorators.shape.ShapeRectangle;
	import test.com.wezside.sample.style.LatinStyle;

	import com.wezside.components.combo.Combo;
	import com.wezside.components.combo.ComboEvent;
	import com.wezside.components.combo.ComboItem;
	import com.wezside.utilities.manager.style.IStyleManager;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class VisualTestCombo extends Sprite 
	{
		private var combo:Combo;
		private var style:LatinStyle;
		private var styleManager:IStyleManager;

		public function VisualTestCombo()
		{
			addEventListener( Event.ADDED_TO_STAGE, stageInit );
			style = new LatinStyle();
			style.addEventListener( Event.COMPLETE, styleReady );
		}

		private function stageInit(event:Event):void 
		{
			stage.align = StageAlign.LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			x = 50;
			y = 50;
		}

		private function styleReady( event:Event ):void 
		{			
			styleManager = event.target as IStyleManager;
			combo = new Combo();
			combo.dropdownHeight = 200;
			combo.dropdownPaddingTop = 10;
			combo.dropdownPaddingRight = 10;
			combo.dropdownPaddingBottom = 10;
			combo.dropdownPaddingLeft = 10;
			
			combo.dropdown.background = new ShapeRectangle( combo.dropdown );
			combo.dropdown.background.colours = [ 0xff0000 ];
			combo.dropdown.background.alphas = [ 0.5, 0.5 ];
			combo.selectedStyleName = "combo";
			combo.defaultSelectedText = "Please choose a category"; 
			combo.styleManager = styleManager;			
			combo.verticalGap = 2;
			
			combo.addItem( new ComboItem( "Cameras", "combo" )); 
			combo.addItem( new ComboItem( "Phones", "combo" )); 
			combo.addItem( new ComboItem( "TVs", "combo" )); 
			combo.addItem( new ComboItem( "Photo", "combo" )); 
			combo.addItem( new ComboItem( "Cameras", "combo" )); 
			combo.addItem( new ComboItem( "Phones", "combo" )); 
			combo.addItem( new ComboItem( "TVs", "combo" )); 
			
			combo.addItem( new ComboItem( "Cameras", "combo" )); 
			combo.addItem( new ComboItem( "Phones", "combo" )); 
			combo.addItem( new ComboItem( "TVs", "combo" )); 
			combo.addItem( new ComboItem( "Photo", "combo" )); 
			combo.addItem( new ComboItem( "Cameras", "combo" )); 
			combo.addItem( new ComboItem( "Phones", "combo" )); 
			combo.addItem( new ComboItem( "TVs", "combo" )); 
			
			
			combo.build();
			combo.setStyle();
			combo.arrange();
			combo.addEventListener( ComboEvent.ITEM_SELECTED, itemSelected );			
			addChild( combo );
		}

		private function itemSelected(event:ComboEvent):void 
		{
			trace( event.item.index, event.item.text );
		}
	}
}
