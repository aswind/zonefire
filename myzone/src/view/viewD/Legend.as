package src.view.viewD 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import net.zonefire.role.Role;
	import src.event.BusEvent;
	/**
	 * 图例视图的控制程序....
	 * @author 
	 */
	public class Legend
	{
		private var _asset:MovieClip;
		private var _buttons:Vector.<SimpleButton>;
		
		public function Legend(asset:MovieClip) 
		{
			_asset = asset;
			init();
		}
		
		private function init():void
		{
			_buttons = new Vector.<SimpleButton>();
			_buttons.push(_asset["btn0"], _asset["btn1"], _asset["btn2"], _asset["btn3"], _asset["btn4"]);
			
			for (var i:int = 0; i < _buttons.length; i++ ) {
				_buttons[i].addEventListener(MouseEvent.MOUSE_OVER, onOver);
				_buttons[i].addEventListener(MouseEvent.MOUSE_OUT, onOut);
			}
		}
		
		private function onOver(evt:MouseEvent):void
		{
			var index:int = _buttons.indexOf(evt.currentTarget);
			_asset.gotoAndStop(index + 2);
		}
		
		private function onOut(evt:MouseEvent):void
		{
			_asset.gotoAndStop(1);
		}
		
		
		
		
		
	}

}