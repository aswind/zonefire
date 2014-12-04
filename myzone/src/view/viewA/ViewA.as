package src.view.viewA 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import net.zonefire.role.ViewRole;
	import src.data.RankData;
	import src.data.UserData;
	import src.data.UserDto;
	import src.enum.ZoneName;
	import src.event.BusEvent;
	import src.event.ZoneEvent;
	import src.util.LibAsset;
	/**
	 * ...
	 * @author 
	 */
	public class ViewA extends ViewRole
	{
		private var _asset:MovieClip;
		private var _nameTxt:TextField; 
		private var _rankTxt:TextField;
		private var _infoTxt:TextField;
		private var _avatarBase:MovieClip;
		private var _expBar:ExpBar;
		private var _bg:MovieClip;
		
		private var _defaultTxt:String;
		private var _userData:UserData;
		private var _rankData:RankData;
		private var _loader:Loader;
		private var _urlReq:URLRequest;
		
		public function ViewA() 
		{
			signIn();
			initData();
			initView();
		}
		
		private function signIn():void
		{
			signInBus();
			signInZone(ZoneName.ZONE_A);
		}
		
		private function initData():void
		{
			//用Role/ViewRole内置的getData方法获取在AssetLoader中用Register对象注册的UserData和RankData数据
			_userData = getData(UserData);
			_rankData = getData(RankData);
		}
		
		private function initView():void
		{
			_asset = LibAsset.getMovieClip("viewA");
			_nameTxt = _asset["nameTxt"];
			_rankTxt = _asset["rankTxt"];
			_infoTxt = _asset["infoTxt"];
			_avatarBase = _asset["avatarBase"];
			_bg = _asset["bg"];
			
			_expBar = new ExpBar(_asset["expBar"]);
			_defaultTxt = _infoTxt.text;
			
			addChild(_asset);
			addListeners();
			
			showDefaultUserData();
		}
		
		private function addListeners():void
		{
			addZoneListener(ZoneEvent.FIRE_ZONE_A, onFired);
			addZoneListener(ZoneEvent.GET_USER_INFO, onFired);
			addBusListener("resetViewA", reset);
		}
		
		private function onFired(evt:ZoneEvent):void
		{
			var firer:String = evt.flag;
			var userId:int = evt.data;
			
			if (firer == "viewB2") {
				_infoTxt.text = "I am fired by " + firer;
			}else if(firer == "DataCenter") {
				_infoTxt.text = "I am fired by " + firer + ", The current user infomation has been changed! [userId:" + userId + "]";
				showUserData();
			}
			blinkBg();
		}
		
		///显示默认用户的数据
		private function showDefaultUserData():void
		{
			var defaultUserInfo:UserDto = _userData.defaultUser;
			_nameTxt.text = defaultUserInfo.userName;
			_rankTxt.text = String(defaultUserInfo.rank);
			_expBar.showProgress(defaultUserInfo.exp, _rankData.getRankDtoByExp(defaultUserInfo.exp));
			loadAvatar(defaultUserInfo.avatar);
		}
		
		///显示当前用户数据
		private function showUserData():void
		{
			_nameTxt.text = _userData.currentUser.userName;
			_rankTxt.text = String(_userData.currentUser.rank);
			_expBar.showProgress(_userData.currentUser.exp, _rankData.getRankDtoByExp(_userData.currentUser.exp));
			loadAvatar(_userData.currentUser.avatar);
		}
		
		///背景（边框）闪烁
		private function blinkBg():void
		{
			_bg.gotoAndPlay(2);
		}
		
		private function reset(evt:Event):void
		{
			_infoTxt.text = _defaultTxt;
			showDefaultUserData();
			_bg.gotoAndPlay(50);
		}
		
		///加载用户头像
		private function loadAvatar(avatarUrl:String):void
		{
			if (!_loader) {
				_urlReq = new URLRequest();
				_loader = new Loader();
				_loader.x = _avatarBase.x;
				_loader.y = _avatarBase.y;
				_asset.addChild(_loader);
			}else {
				_loader.unload();
			}
			
			_urlReq.url = avatarUrl;
			_loader.load(_urlReq);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
		}
		
		private function onLoaded(evt:Event):void
		{
			_loader.content.width = 65;
			_loader.content.height = 65;
			Bitmap(_loader.content).smoothing = true;
		}
		
		/**
		 * 释放ViewA实例。本程序中viewA不删除，所以并不需要执行这一步，此处仅说明dispose方法的使用。
		 * 执行super.dispose()会自动从Bus/Zone中签出（如果实例已经签入的Bus或Zone中就自动签出，否则自动忽略）
		 */
		public override function dispose():void
		{
			super.dispose();
			
			removeZoneListener(ZoneEvent.FIRE_ZONE_A, onFired);
			removeZoneListener(ZoneEvent.GET_USER_INFO, onFired);
			removeBusListener("resetViewA", reset);
			
			removeChild(_asset);
			_bg = null;
			_avatarBase = null;
			_infoTxt = null;
			_rankTxt = null;
			_nameTxt = null;
			_asset = null;
			
			_userData = null;
			_rankData = null;
			_loader = null;
			_urlReq = null;
			
			//用Role/ViewRole内置的monitor对象可以随时监视角色在框架中的活动情况
			trace(monitor.inBus(roleName));
			trace(monitor.inZone(ZoneName.ZONE_A, roleName));
		}
	}

}