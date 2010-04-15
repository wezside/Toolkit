package test.com.wezside.sample.media 
{
	import com.wezside.components.media.MediaPlayer;

	import flash.display.Sprite;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class MediaSample extends Sprite
	{
		private var player:MediaPlayer;

		
		public function MediaSample() 
		{
					
			var item1:Media = new Media();
			item1.url = "http://www.youtube.com/watch?v=MWe07krS8_E";
			 
			var item2:Media = new Media();
			item2.url = "http://www.youtube.com/watch?v=uXyUtJYIdQA"; 
			 
			var item3:Media = new Media();
			item3.url = "http://www.youtube.com/watch?v=MWe07krS8_E"; 
					
			var mediaItems:Array = [];
			mediaItems.push( item1 );
			mediaItems.push( item2 );
			mediaItems.push( item3 );
		
			player = new MediaPlayer();
			player.bgWidth = 350;			
			player.bgHeight = 200;			
			player.dataprovider = mediaItems;
			addChild(player);
		}

	}
}
