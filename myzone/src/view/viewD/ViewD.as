package src.view.viewD 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class ViewD extends Sprite
	{
		private var _viewD1:ViewD1;
		private var _viewD2:ViewD2;
		
		public function ViewD() 
		{
			initView();
		}
		
		private function initView():void
		{
			_viewD1 = new ViewD1();
			addChild(_viewD1);
			
			_viewD2 = new ViewD2();
			addChild(_viewD2);
			
			setPosition();
		}
		
		private function setPosition():void
		{
			this.x = 635;
			this.y = 112;
		}
		
		
		
	}

}