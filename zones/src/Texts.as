package src {
	
	public class Texts 
	{
		public var toothTxt1:String;
		public var toothTxt2:String;
		public var appleTxt:String;
		public var busFireTxt:String;
		public var zoneFireTxt:String;
		public var noseTxt1:String;
		public var noseTxt2:String;
		
		/**
		 * Texts类定义了一些数据。Texts在Main.as中用Register类注册到ZoneFire后，就会自动生成一个实例，
		 * 以后在任何一个框架角色（Role/EchoRole/ViewRole）中就可以方便地使用实例中的数据。
		 * 一般Flash项目中，如xml配置数据，来自服务器的后台数据，都可以用此方法注册到ZoneFire框架中以方便随处调用。
		 */
		public function Texts() 
		{
			initData()
		}
		
		private function initData():void
		{
			toothTxt1 = "Fire Bus";
			toothTxt2 = "Fire Zone";
			appleTxt = "Please fire me!";
			busFireTxt = "I am fired by Bus!";
			zoneFireTxt = "I am fired by Zone!";
			noseTxt1 = "tooth1 fire apple1";
			noseTxt2 = "tooth2 fire apple1,2";
		}
	}
	
}
