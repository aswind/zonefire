package src.view.viewD 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import net.zonefire.role.ViewRole;
	import src.manager.LayerManager;
	import src.util.LibAsset;
	/**
	 * 弹出窗口触发区。本类演示如何在框架角色中访问事先用Registor注册到ZoneFire框架的的LayerManager管理器对象并对之进行操控。
	 * 大型程序中会有各种管理器（层次管理器、声音管理器、缓存管理器、对象池管理器、模块管理器、窗口管理器、游戏战场管理器等），
	 * 而这些管理器在程序中的任何地方都可能会用到，所以如何方便地随时访问是个恼人的问题。
	 * 在Win类中有类似的应用演示...
	 * @author 
	 */
	public class ViewD1 extends ViewRole
	{
		private var _asset:MovieClip;
		private var _overview1:SimpleButton;
		private var _overview2:SimpleButton;
		private var _diagram1:SimpleButton;
		private var _diagram2:SimpleButton;
		
		private var _layerManager:LayerManager;
		
		public function ViewD1() 
		{
			initView();
		}
		
		private function initView():void
		{
			_asset = LibAsset.getMovieClip("viewD1");
			addChild(_asset);
			
			_overview1 = _asset["overview1"];
			_overview2 = _asset["overview2"];
			_diagram1 = _asset["diagram1"];
			_diagram2 = _asset["diagram2"];
			
			addListener();
			_layerManager = getManager(LayerManager);		//引用注册过的LayerManager实例
		}
		
		private function addListener():void
		{
			_overview1.addEventListener(MouseEvent.CLICK, onClick);
			_overview2.addEventListener(MouseEvent.CLICK, onClick);
			_diagram1.addEventListener(MouseEvent.CLICK, onClick);
			_diagram2.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		private function onClick(evt:MouseEvent):void
		{
			var btn:SimpleButton = SimpleButton(evt.currentTarget);
			var win:Win
			
			switch (btn) 
			{
				case _overview1:
					win = new Win("overview_en");
				break;
					
				case _overview2:
					win = new Win("overview_cn");
				break;
					
				case _diagram1:
					win = new Win("diagram_en");
				break;
					
				case _diagram2:
					win = new Win("diagram_cn");
				break;
			}
			
			_layerManager.popWin(win);
		}
		
	}

}