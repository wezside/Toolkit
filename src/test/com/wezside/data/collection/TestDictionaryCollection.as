package test.com.wezside.data.collection
{
	import com.wezside.data.collection.Collection;
	import com.wezside.data.collection.DictionaryCollection;

	import flash.display.Sprite;
	/**
	 * @author Wesley.Swanepoel
	 */
	public class TestDictionaryCollection extends Sprite
	{
		private var alphabetCollection:DictionaryCollection;
		
		public function TestDictionaryCollection() 
		{
					
			alphabetCollection = new DictionaryCollection();
		
			var word1:String = "hello";
			var word2:String = "hamster";
			var word3:String = "fahim";
			var word4:String = "wesley";
			var word5:String = "individual";
			var word6:String = "business";
			
			
			// For each word in XML add to a word Collection
			var wordCollection:Collection = getLetterCollection( word1 );
			wordCollection.addElement({ id: word1 });
			alphabetCollection.addElement("h", wordCollection );
			
			wordCollection = getLetterCollection( word2 );			
			wordCollection.addElement({ id: word2 });
			alphabetCollection.addElement("h", wordCollection );
			
			trace( Collection( alphabetCollection.getElement("h")).length);
			
		}

		private function getLetterCollection( word1:String ):Collection
		{
			var char:String = word1.charAt(0).toLowerCase();
			return alphabetCollection.hasElement( char ) ? alphabetCollection.getElement( char ) : new Collection();			
		}
	}
}
