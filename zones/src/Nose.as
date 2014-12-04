package src {
	
	import net.zonefire.role.ViewRole;
	import net.zonefire.base.Monitor;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.TextEvent;
	
	
	/**
	* 鼻子Nose签入到noseZone，能侦听到Tooth1发送过来的Zone事件。TextEnent.text属性可以携带一些来自事件源的额外信息，
	* 比如事件发送者是谁之类。
	* Nose类同时演示了如果使用已经注册到框架中的Texts类实例中的数据。
	*/
	public class Nose extends ViewRole
	{
		private var _tField:TextField;
		private var _texts:Texts;
		
		
		public function Nose() {
			init();
		}
		
		private function init():void
		{
			_texts = getData(Texts);		//获取已经注册到ZoneFire框架的Texts数据对象的引用
			
			_tField = tField;
			this.signInZone(ZoneName.NOSE_ZONE);
			this.addZoneListener("zoneFire", onZoneFire);
		}
		
		private function onZoneFire(evt:TextEvent):void
		{
			if(evt.text == "busFiring"){
				_tField.text = _texts.noseTxt1;
			}else if(evt.text == "zoneFiring"){
				_tField.text = _texts.noseTxt2;
			}
			debug();
		}
		
		/**
		 * 这里演示monitor的用法，主要用于运行时观察各角色在ZoneFire框架中的活动情况。
		 */
		private function debug():void
		{
			trace("zoneList:", monitor.zoneList);
			trace("rolesInBus:", monitor.rolesInBus);
			trace("rolesInAppleZone:", monitor.rolesInZone(ZoneName.APPLE_ZONE));
			trace("---------------------------------");
		}
		
	}
	
}
