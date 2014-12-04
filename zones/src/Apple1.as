package src 
{
	import net.zonefire.role.ViewRole;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.display.MovieClip;
	
	
	/**
	 * 左眼珠Apple1同时签入到Bus和appleZone,当用户点击左牙齿Tooth1发送Bus事件，点击右牙齿Tooth2发送Zone事件时
	 * 在Apple1中都能侦听到。Apple1侦听到这些框架事件后，再发送Zone事件到noseZone通知鼻子Nose自己被谁fire了。
	 * 至于发送到noseZone的事件是TextEvent而不是Event，是因为TextEvent有个String型属性Text，以此可以将Apple1侦听到
	 * 的是Bus事件还是Zone事件的信息附加在TextEvent中发送给Nose。
	 */
	public class Apple1 extends ViewRole 
	{
		private var _appleBg:MovieClip;
		private var _tField:TextField;
		private var _texts:Texts;

		public function Apple1() 
		{
			init();
		}
		
		private function init():void
		{
			_texts = getData(Texts);		//获取已经在Main中注册到ZoneFire框架的数据
			
			_appleBg = appleBg;
			_tField = tField;
			_tField.text = _texts.appleTxt;
			
			this.signInBus();
			this.signInZone(ZoneName.APPLE_ZONE);
			this.addBusListener("busFire", onBusFire);
			this.addZoneListener("zoneFire", onZoneFire);
		}
		
		private function onBusFire(evt:Event):void
		{
			_tField.text = _texts.busFireTxt;
			var textEvent:TextEvent = new TextEvent("zoneFire", false, false, "busFiring");
			this.fireZone(textEvent, ZoneName.NOSE_ZONE);
			_appleBg.gotoAndPlay(2);
		}
		
		private function onZoneFire(evt:Event):void
		{
			_tField.text = _texts.zoneFireTxt;
			var textEvent:TextEvent = new TextEvent("zoneFire", false, false, "zoneFiring");
			this.fireZone(textEvent, ZoneName.NOSE_ZONE);
			_appleBg.gotoAndPlay(2);
		}
	}
	
}
