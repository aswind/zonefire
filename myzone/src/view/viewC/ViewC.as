package src.view.viewC 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import net.zonefire.role.Role;
	import src.enum.ZoneName;
	import src.event.ZoneEvent;
	import src.util.LibAsset;
	/**
	 * ViewC 不是Role或ViewRole的扩展类，其本身无法通过框架和其他框架角色进行通信。
	 * 但是可以在ViewC中创建一个框架角色(_role:Role)代替它进行框架互动。当然这种做法是及其不推荐的...
	 * @author Will Jiang
	 */
	public class ViewC extends Sprite
	{
		private var _asset:MovieClip;
		private var _tField:TextField;
		private var _button:SimpleButton;
		private var _bg:MovieClip;
		private var _defaultTxt:String;
		private var _role:Role;
		
		public function ViewC() 
		{
			_role = new Role();
			
			initView();
			setPosition();
		}
		
		
		private function initView():void
		{
			_asset = LibAsset.getMovieClip("viewC");
			_tField = _asset["tField"];
			_button = _asset["button"];
			_bg = _asset["bg"];
			_defaultTxt = _tField.text;
			
			addChild(_asset);
			_button.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(evt:MouseEvent):void
		{
			//ZoneFire框架事件发送者派发事件并不需要先签入到Zone，只有侦听者才需要签入到Zone
			_role.fireZone(new ZoneEvent(ZoneEvent.CHILD_ROLE_FIRE, "viewC"), ZoneName.ZONE_B);
		}
		
		private function setPosition():void
		{
			this.x = 19;
			this.y = 459;
		}
		
		
		
		
	}

}