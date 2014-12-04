package src.view.viewD 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.zonefire.role.ViewRole;
	import src.manager.LayerManager;
	import src.util.LibAsset;
	/**
	 * 弹出窗口,点击窗口中的语言按钮时关闭当前窗口并弹出对应语言的窗口
	 * 本类演示如何在框架角色里调用用Register注册到ZoneFire框架的管理器LayerManager实例，从而用该管理器对窗口进行管理。
	 * 大型应用程序或游戏的弹出窗口是非常多的，而弹出和关闭的时机和条件又千变万化，一般都会创建一个独立的窗口管理器来管理。
	 * 本演示程序因为结构比较简单，就直接借用Layermanager来管理其简单的弹出和关闭。而规范的做法应该将事件发送到窗口管理器，
	 * 由窗口管理器根据事件决定弹出那个窗口...
	 * @author Will Jiang
	 */
	public class Win extends ViewRole
	{
		private var _asset:MovieClip;
		private var _closeBtn:SimpleButton;
		private var _langBtn:MovieClip;
		private var _layerManager:LayerManager;
		
		
		public function Win(assetLink:String) 
		{
			initView(assetLink);
			setPosition();
			_layerManager = getManager(LayerManager);				//从框架中取得层管理器实例引用
		}
		
		private function initView(assetLink:String):void
		{
			this.name = assetLink;
			_asset = LibAsset.getMovieClip(assetLink);
			addChild(_asset);
			
			_closeBtn = _asset["closeBtn"];
			_langBtn = _asset["langBtn"];
			
			if (assetLink.indexOf("cn") > 0) {
				_langBtn.gotoAndStop("cn");
			}else {
				_langBtn.gotoAndStop("en");
			}
			
			addListener();
		}
		
		private function addListener():void
		{
			_closeBtn.addEventListener(MouseEvent.CLICK, closeWin);
			_langBtn.addEventListener(MouseEvent.CLICK, changeLanguage);
		}
		
		private function clearListener():void
		{
			_closeBtn.removeEventListener(MouseEvent.CLICK, closeWin);
			_langBtn.removeEventListener(MouseEvent.CLICK, changeLanguage);
		}
		
		
		///根据选择的语言，生成对应的窗口，并通过层管理器先删除原有的窗口，把新窗口显示到窗口层
		private function changeLanguage(evt:MouseEvent):void
		{
			var win:Win;
			
			switch (this.name) 
			{
				case "overview_en":
					win = new Win("overview_cn");
				break;
				
				case "overview_cn":
					win = new Win("overview_en");
				break;
				
				case "diagram_en":
					win = new Win("diagram_cn");
				break;
				
				case "diagram_cn":
					win = new Win("diagram_en");
				break;
			}
			
			closeWin(evt);
			_layerManager.popWin(win);
		}
		
		private function closeWin(evt:MouseEvent):void
		{
			_layerManager.clearWin();
			dispose();
		}
		
		private function setPosition():void
		{
			x = 25;
			y = 30;
		}
		
		public override function dispose():void 
		{
			super.dispose();
			
			clearListener();
			removeChild(_asset);
			_closeBtn = null;
			_langBtn = null;
		}
	}

}