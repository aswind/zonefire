package src {
	import net.zonefire.role.ViewRole;
	import flash.events.Event;
	
	/**
	 * 右眼珠Apple2签入到appleZone中，可以侦听到右牙齿Tooth2发送到appleZone的Zone事件并做出响应。
	 * Apple2没有签入到Bus中，所以侦听不到左牙齿Tooth1发送的Bus事件。
	 */
	public class Apple2 extends ViewRole 
	{
		private var _appleBg:MovieClip;
		private var _tField:TextField;
		private var _texts:Texts;
		
		public function Apple2() 
		{
			init();
		}
		
		private function init():void
		{
			_texts = getData(Texts);		//获取已经在Main中注册到ZoneFire框架的数据
			
			_appleBg = appleBg;
			_tField = tField;
			_tField.text = _texts.appleTxt;
			
			this.signInZone(ZoneName.APPLE_ZONE);
			this.addZoneListener("zoneFire", onZoneFire);
		}
		
		private function onZoneFire(evt:Event):void
		{
			_tField.text = _texts.zoneFireTxt;
			_appleBg.gotoAndPlay(2);
		}
	}
	
}
