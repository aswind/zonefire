package src {
	
	import net.zonefire.role.ViewRole;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	/**
	 * 左牙齿Tooth1没有签入任何Zone或Bus，它不能侦听框架事件但可以发送框架事件，但可以发送框架事件。
	* Tooth1被点击后发送ZoneFire框架的Bus事件（总线事件），Bus事件的射界是无限的，在任何签入到Bus的框架角色都能侦听到。
	* 这种无差别射击虽然方便，但是当程序比较复杂时容易导致混乱，所以建议尽量少用或不用，而应该多用区域事件来远程通信问题。
	*/
	public class Tooth1 extends ViewRole
	{
		private var _tField:TextField;
		private var _texts:Texts;
		
		
		public function Tooth1() {
			init();
		}
		
		private function init():void
		{
			_texts = getData(Texts);	//获取已经注册到ZoneFire框架的Texts数据对象的引用
			
			this.buttonMode = true;
			this.mouseChildren = false;
			_tField = tField;
			_tField.text = _texts.toothTxt1;
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(evt:MouseEvent):void
		{
			this.fireBus(new Event("busFire"));		//向总线发送总线事件
		}
		
		
		
	}
	
}
