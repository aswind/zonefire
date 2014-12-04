package src {
	
	import net.zonefire.role.ViewRole;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import src.ZoneName;
	
	
	/**
	 * 右牙齿Tooth2没有签入任何Zone或Bus，它不能侦听框架事件但可以发送框架事件，被点击时会发送事件到appleZone
	 * 
	 */
	public class Tooth2 extends ViewRole
	{
		private var _tField:TextField;
		private var _texts:Texts;
		
		
		public function Tooth2() {
			init();
		}
		
		private function init():void
		{
			_texts = getData(Texts);	//获取已经注册到ZoneFire框架的Texts数据对象的引用
			
			this.buttonMode = true;
			this.mouseChildren = false;
			_tField = tField;
			_tField.text = _texts.toothTxt2;
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(evt:MouseEvent):void
		{
			this.fireZone(new Event("zoneFire"), ZoneName.APPLE_ZONE);	//向APPLE_ZONE事件区域发送区域事件
		}
		
		
		
	}
	
}
