package src.manager 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import src.util.LibAsset;
	
	
	/**
	 * 应用程序Z轴显示物体层次堆叠结构管理器。对于这个简单演示程序来说其实并不需要这样的管理器，
	 * 但复杂的应用程序如果有这种管理器会对程序总体的操控带来很大的便利；
	 * 该LayerManager管理器用Register注册器注册到ZoneFire框架，在Role/EchoRole/ViewRole中可随时调用。
	 * @author 
	 */
	public class LayerManager
	{
		private var _bgLayer:Sprite;			//放置应用程序背景内容的层
		private var _bodyLayer:Sprite;			//放置应用程序主体内容的层
		private var _winLayer:Sprite;			//放置弹出窗口的层
		private var _darkMask:MovieClip;
		
		public function LayerManager() 
		{
			
		}
		
		public function setLayers(main:Sprite):void
		{
			_bgLayer = new Sprite();
			main.addChild(_bgLayer);
			
			_bodyLayer = new Sprite();
			main.addChild(_bodyLayer);
			
			_winLayer = new Sprite();
			main.addChild(_winLayer);
		}
		
		public function get bgLayer():Sprite 
		{
			return _bgLayer;
		}
		
		public function get bodyLayer():Sprite 
		{
			return _bodyLayer;
		}
		
		public function get winLayer():Sprite 
		{
			return _winLayer;
		}
		
		
		/**
		 * 显示弹出窗口并锁定bodyLayer，避免用户于bodyLayer里的显示物体鼠标交互
		 * @param	window	要显示的弹出窗口
		 */
		public function popWin(window:Sprite):void
		{
			if (_darkMask == null) {
				_darkMask = LibAsset.getMovieClip("darkMask");
			}
			
			_winLayer.addChild(_darkMask);
			_winLayer.addChild(window);
			
			_bodyLayer.mouseChildren = false;
			_bodyLayer.mouseEnabled = false;
		}
		
		
		/**
		 * 清除winLayer所有弹出窗口(和遮罩)并解锁bodyLayer
		 */
		public function clearWin():void
		{
			_winLayer.removeChildren();
			_bodyLayer.mouseChildren = true;
			_bodyLayer.mouseEnabled = true;
		}
		
	}

}