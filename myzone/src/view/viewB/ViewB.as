package src.view.viewB 
{
	import flash.display.Sprite;
	
	
	/**
	 * ViewB不是框架角色，仅仅是个普通容器，不参加框架互动...
	 * @author Will Jiang
	 */
	public class ViewB extends Sprite
	{
		private var _viewB1:ViewB1;
		private var _viewB2:ViewB2;
		
		public function ViewB() 
		{
			initView();
		}
		
		private function initView():void
		{
			_viewB1 = new ViewB1();
			addChild(_viewB1);
			
			_viewB2 = new ViewB2();
			addChild(_viewB2);
			
			setPosition();
		}
		
		private function setPosition():void
		{
			this.x = 19;
			this.y = 108;
		}
		
	}

}