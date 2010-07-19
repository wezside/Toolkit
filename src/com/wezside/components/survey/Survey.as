package com.wezside.components.survey 
{
	import com.wezside.components.UIElement;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class Survey extends UIElement 
	{
		private var controller:SurveyController;
		private var parser:SurveyDataParser;

		
		public function Survey()
		{
			super();
			init();
		}

		override public function build():void 
		{
			super.build( );			
			
			// TODO: Create Background
						
			// TODO: Create Preloader

			// TODO: Create fixed elements like navigation, header and footer - should include the option to exclude from start page
									
		}

		private function init():void 
		{
			initializationComplete();	// async
			
			parser = new SurveyDataParser();
		}

		/**
		 * This method assumes successful load of all external data and assets required. This includes:
		 * 	o Survey Data
		 * 	o Styles
		 * 	o Images/SWFs
		 */
		private function initializationComplete():void 
		{			
			// TODO: Init command map
			// TODO: Store ref to parser
			// TODO: Init FormController			
			controller = new SurveyController();
			controller.debug = true;
			controller.data = parser.data; 
			
			build();
			setStyle();
			arrange();
			start();
		}

		private function start():void 
		{
			// TODO: Create first form and show/transition in
			controller.createForm( "Start" );
		}

	}
}
