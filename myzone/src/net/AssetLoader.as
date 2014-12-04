package src.net 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import net.zonefire.base.Register;
	import src.data.RankData;
	import src.data.UserData;
	
	/**
	 * 加载美术素材，xml文件等。xml加载成功后对数据进行分析并用Register对象注册数据，以便于以后在Role/EchoRole/ViewRole中访问....
	 * @author Will Jiang
	 */
	public class AssetLoader extends EventDispatcher
	{
		public static const ALL_LOADED:String = "allLoaded";
		
		private var _xmlUrl:String;
		private var _swfUrl:String;
		
		private var _xmlURLReq:URLRequest;
		private var _swfURLReq:URLRequest;
		private var _xmlLoader:URLLoader;
		private var _swfLoader:Loader;
		
		
		public function AssetLoader() 
		{
			_xmlUrl = "xml/user.xml";
			_xmlURLReq = new URLRequest(_xmlUrl);
			_xmlLoader = new URLLoader();
			
			_swfUrl = "swf/asset.swf";
			_swfURLReq = new URLRequest(_swfUrl);
			_swfLoader = new Loader();
		}
		
		public function startLoad():void
		{
			_xmlLoader.addEventListener(Event.COMPLETE, onXmlLoaded);
			_xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			_xmlLoader.load(_xmlURLReq);
		}
		
		private function onXmlLoaded(evt:Event):void
		{
			_xmlLoader.removeEventListener(Event.COMPLETE, onXmlLoaded);
			_xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			var xml:XML = XML(_xmlLoader.data);
			regData(xml);
			
			var context:LoaderContext=new LoaderContext(false, ApplicationDomain.currentDomain, null);
			_swfLoader.load(_swfURLReq, context);
			_swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSwfLoaded);
			_swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
		}
		
		/**
		 * 先用注册器注册RankData，这样在用userData.parseXML(xml)解释user.xml数据时就可以从ZoneFire框架中取得RankData数据实例，
		 * 然后根据用户exp值从RankData数据实例中取得对应的用户等级(rank)值，记入在UserData对应用户中
		 * 这里演示了两种注册数据类的方法：
		 * 1）用类定义注册RankData，注册后框架会自动生成RankData类实例；
		 * 2）先手动生成数据类UserData的实例再用Register.regDataInstance方法注册到框架（UserData类由于实例创建后还需要手动调用userData.parseXML(xml)方法，所以用第一种方法注册不方便）。
		 *    当然，由于用Register.regData(UserData)注册数据如果成功会返回自动生成的类实例，第二步也可以用如下代码代替：
		 * 		var userData:UserData = Register.regData(UserData);	
		 *		userData.parseXML(xml);
		 * 
		 * 两种方法达到的结果都一样，即框架中有了所注册类的一个唯一实例，可以在框架角色中用getData(dataClass:Class)方法随时访问
		 * @param	xml
		 */
		private function regData(xml:XML):void
		{
			Register.regData(RankData);									//用数据类注册自动生成数据类实例
			
			var userData:UserData = new UserData();
			userData.parseXML(xml);
			Register.regDataInstance(userData, UserData);				//直接用数据类实例注册数据
		}
		
		private function onSwfLoaded(evt:Event):void
		{
			_swfLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onSwfLoaded);
			_swfLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			dispatchEvent(new Event(AssetLoader.ALL_LOADED));
		}
		
		private function onLoadError(evt:IOErrorEvent):void
		{
			throw(new Error("load error"));
		}
		
		
		
	}

}