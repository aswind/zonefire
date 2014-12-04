package src.view 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import src.util.LibAsset;
	/**
	 * ...
	 * @author 
	 */
	public class BackGround extends Sprite
	{
		private var _asset:MovieClip;
		
		public function BackGround() 
		{
			initView();
		}
		
		private function initView():void
		{
			_asset = LibAsset.getMovieClip("background");
			addChild(_asset);
		}
		
		
	}

}