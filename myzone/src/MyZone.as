package src
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.zonefire.base.Register;
	import src.manager.LayerManager;
	import src.net.AssetLoader;
	import src.util.LibAsset;
	import src.view.BackGround;
	import src.view.Debug;
	import src.view.viewA.ViewA;
	import src.view.viewB.ViewB;
	import src.view.viewC.ViewC;
	import src.view.viewD.ViewD;
	

	/**
	 * 文档类，创建并注册层次管理器，并构建各视图，将不同视图放置在层管理器的不同层中...
	 * 在这里将层次管理器LayerManager注册到ZoneFire框架中，注册成功后即可随时在任何Role/EchoRole/ViewRole实例中调用，以便操控不同显示层的显示物体
	 * 可以在程序的任何地方用Register进行管理器/数据对象的注册，而不一定要框架角色。
	 * @author Will Jiang
	 */
	[SWF(width="800",height="600",frameRate="25",backgroundColor="#AAAA00")]
	public class MyZone extends Sprite 
	{
		private var _assetLoader:AssetLoader;
		
		private var _viewA:ViewA;
		private var _viewB:ViewB;
		private var _viewC:ViewC;
		private var _viewD:ViewD;
		
		
		public function MyZone():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_assetLoader = new AssetLoader();
			_assetLoader.addEventListener(AssetLoader.ALL_LOADED, onAssetLoaded);
			_assetLoader.startLoad();
		}
		
		
		private function onAssetLoaded(evt:Event):void
		{
			makeLayout();
		}
		
		private function makeLayout():void
		{
			//这里演示如何向ZoneFire框架注册管理器。注册成功会返回自动创建的类实例，然后可对类实例进行操作。
			var layerManager:LayerManager = Register.regManager(LayerManager);
			layerManager.setLayers(this);
			
			var bg:BackGround = new BackGround();
			layerManager.bgLayer.addChild(bg);
			
			_viewA = new ViewA();
			_viewB = new ViewB();
			_viewC = new ViewC();
			_viewD = new ViewD();
			
			layerManager.bodyLayer.addChild(_viewA);
			layerManager.bodyLayer.addChild(_viewB);
			layerManager.bodyLayer.addChild(_viewC);
			layerManager.bodyLayer.addChild(_viewD);
			
			//debug
			var debug:Debug = new Debug();
			layerManager.bgLayer.addChild(debug);
		}
		
		
		
		
	}
	
}