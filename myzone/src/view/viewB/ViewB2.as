package src.view.viewB 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.zonefire.role.ViewRole;
	import src.data.UserDto;
	import src.enum.ZoneName;
	import src.event.BusEvent;
	import src.event.ZoneEvent;
	import src.util.LibAsset;
	
	/**
	 * 框架事件派发处，四个按钮点击后框架事件由此派发到Bus或指定Zone
	 * 此对象没有签入到Bus和Zone但可以派发框架事件（侦听框架事件需先签入，派发框架事件不需签入）。...
	 * @author 
	 */
	public class ViewB2 extends ViewRole
	{
		private var _asset:MovieClip;
		
		private var _fireZoneA:SimpleButton;
		private var _fireZoneB:SimpleButton;
		private var _fireDataZone:SimpleButton;
		private var _fireBus:SimpleButton;
		
		public function ViewB2() 
		{
			initView();
		}
		
		private function initView():void
		{
			_asset = LibAsset.getMovieClip("viewB2");
			addChild(_asset);
			
			_fireZoneA = _asset["fireZoneA"];
			_fireZoneB = _asset["fireZoneB"];
			_fireDataZone = _asset["fireDataZone"];
			_fireBus = _asset["fireBus"];
			
			addListeners();
			setPosition();
		}
		
		private function addListeners():void
		{
			_fireZoneA.addEventListener(MouseEvent.CLICK, onClick);
			_fireZoneB.addEventListener(MouseEvent.CLICK, onClick);
			_fireDataZone.addEventListener(MouseEvent.CLICK, onClick);
			_fireBus.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(evt:MouseEvent):void
		{
			var firer:String = "viewB2";
			var button:SimpleButton = SimpleButton(evt.currentTarget);
			var zoneEvt:ZoneEvent;
			
			switch (button) 
			{
				case _fireZoneA:
					zoneEvt = new ZoneEvent(ZoneEvent.FIRE_ZONE_A, firer);
					fireZone(zoneEvt, ZoneName.ZONE_A);
					break;
				
				case _fireZoneB:
					zoneEvt = new ZoneEvent(ZoneEvent.FIRE_ZONE_B, firer);
					fireZone(zoneEvt, ZoneName.ZONE_B);	
					break;
				
				case _fireDataZone:
					var currUserId:int = getRandomId();
					zoneEvt = new ZoneEvent(ZoneEvent.FIRE_DATA_ZONE, String(currUserId));
					fireZone(zoneEvt, ZoneName.DATA_ZONE);
					break;
					
				case _fireBus:
					var busEvt:BusEvent = new BusEvent(BusEvent.FIRE_BUS, firer);
					fireBus(busEvt);
					break;
			}
		}
		
		private function getRandomId():int
		{
			var randomId:int = int(Math.random() * 10);
			return randomId;
		}
		
		private function setPosition():void
		{
			this.x = 0;
			this.y = 257;
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			_fireZoneA = null;
			_fireZoneB = null;
			_fireDataZone = null;
			_fireBus = null;
			_asset = null;
		}
		
	}

}