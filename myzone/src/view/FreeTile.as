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
	 * 注意FreeTile既不是Role也不是ViewRole，其本身不能通过FireZone框架和其他框架角色交互
	 * 但可以在FreeTile里创建一个Role或ViewRole对象，让该对象代替FreeTile进行框架事件交互...
	 * @author Will Jiang
	 */
	
	public class FreeTile 
	{
		private var _asset:MovieClip;
		private var _tField:TextField;
		private var _button:SimpleButton;
		private var _tileBg:MovieClip;
		private var _role:Role;
		private var _defaultTxt:String;
		
		public function FreeTile(asset:MovieClip) 
		{
			_asset = asset;
			
			initView();
			makeChildRole();
		}
		
		private function initView():void
		{
			_tField = _asset["tField"];
			_button = _asset["button"];
			_tileBg = _asset["tileBg"];
			_defaultTxt = _tField.text;
		}
		
		private function makeChildRole():void
		{
			_role = new Role();
			_role.signInBus();
			_role.signInZone(ZoneName.ZONE_B);
			_role.addZoneListener(ZoneEvent.CHILD_ROLE_FIRE, onChildRoleFired);
		}
		
		private function onChildRoleFired(evt:ZoneEvent):void
		{
			var firer:String = evt.flag;
			_tField.text = "My Child Role is fired by " + firer + "'s Child Role!";
			blinkBg();
		}
		
		private function blinkBg():void
		{
			_tileBg.gotoAndPlay(2);
		}
		
		public function reset():void
		{
			_tField.text = _defaultTxt;
			_tileBg.gotoAndPlay(50);
		}
		
		public function dispose():void
		{
			_role.dispose();
			_role.removeZoneListener(ZoneEvent.CHILD_ROLE_FIRE, onChildRoleFired);
			
			_role = null;
			_tileBg = null;
			_button = null;
			_tField = null;
			_asset = null;
		}
		
	}

}