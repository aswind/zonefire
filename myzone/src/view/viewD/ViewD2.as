package src.view.viewD 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import src.util.LibAsset;
	/**
	 * ...
	 * @author 
	 */
	public class ViewD2 extends Sprite
	{
		private var _asset:MovieClip;
		private var _legend:Legend;
		
		public function ViewD2() 
		{
			initView();
		}
		
		private function initView():void
		{
			_asset = LibAsset.getMovieClip("viewD2");
			_legend = new Legend(_asset["legend"]);
			
			addChild(_asset);
			setPosition();
		}
		
		private function setPosition():void
		{
			this.x = 0;
			this.y = 255;
		}
		
	}

}