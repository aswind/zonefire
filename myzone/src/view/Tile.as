package src.view 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import net.zonefire.role.Role;
	import src.enum.ZoneName;
	import src.event.BusEvent;
	import src.event.ZoneEvent;
	/**
	 * 小方块视图的控制类。侦听从viewB2派发过来的框架事件...
	 * @author Will Jiang
	 */
	public class Tile extends Role
	{
		private var _asset:MovieClip;
		private var _tField:TextField;
		private var _tileBg:MovieClip;
		private var _defaultTxt:String;
		
		private var _firer:String;
		
		
		public function Tile(asset:MovieClip) 
		{
			_asset = asset;
			initView();
		}
		
		private function initView():void
		{
			_tField = _asset["tField"];
			_tileBg = _asset["tileBg"];
			_defaultTxt = _tField.text;
		}
		
		public function onFired(evt:*):void
		{
			var firer:String = evt.flag;
			_tField.text = "I am fired by " + firer;
			blinkBg();
		}
		
		private function blinkBg():void
		{
			_tileBg.gotoAndPlay(2);
		}
		
		public function reset():void
		{
			_tField.text = _defaultTxt;
			_tileBg.gotoAndPlay(50)
		}
		
		override public function dispose():void 
		{
			super.dispose();
			
			_tField = null;
			_tileBg = null;
			_asset = null;
		}
		

		
	}

}