package src.view.viewB 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import src.enum.ZoneName;
	import src.event.BusEvent;
	import src.event.ZoneEvent;
	import src.util.LibAsset;
	import src.view.FreeTile;
	import src.view.Tile;
	
	/**
	 * ViewB1不是框架角色，但它的一些属性（Tile实例）是框架角色。在这里演示框架角色签入到Bus和/或Zone的情况。
	 * 不签入到Bus/Zone的框架角色尽管不能侦听Bus/Zone事件，但是依然可以发送Bus/Zone框架事件，或访问注册过的数据/管理器
	 * 这里的Tile实例侦听从viewB2派发过来的框架事件
	 * _tile0和_tile2签入到ZoneB，可以侦听区域事件。_tile1签入到事件总线，可以侦听总线事件；
	 * _tile3既没有签入到Zone也没有签入到事件总线，侦听不到框架事件，但是可以发送框架事件；
	 * _tile4不是框架角色，但是它有一个框架角色子物体_role，该子物体既签入到ZoneB又签入到事件总线，可以代替它侦听区域事件和总线事件。
	 * @author 
	 */
	public class ViewB1 extends Sprite
	{
		private var _asset:MovieClip;
		private var _tile0:Tile;
		private var _tile1:Tile;
		private var _tile2:Tile;
		private var _tile3:Tile;
		private var _tile4:FreeTile;
		
		private var _resetBtn:SimpleButton;
		
		public function ViewB1() 
		{
			initView();
		}
		
		private function initView():void
		{
			_asset = LibAsset.getMovieClip("viewB1");
			_resetBtn = _asset["resetBtn"];
			_resetBtn.addEventListener(MouseEvent.CLICK, onReset);
			addChild(_asset);
			
			setTile0();
			setTile1();
			setTile2();
			setTile3();
			setTile4();
		}
		
		private function setTile0():void
		{
			//tile0 is in Zone, but not in Bus
			_tile0 = new Tile(_asset["tile0"]);
			_tile0.signInZone(ZoneName.ZONE_B);
			_tile0.addZoneListener(ZoneEvent.FIRE_ZONE_B, _tile0.onFired);
		}
		
		
		private function setTile1():void
		{
			//tile1 is in Bus but not in Zone
			_tile1 = new Tile(_asset["tile1"]);
			_tile1.signInBus();
			_tile1.addBusListener(BusEvent.FIRE_BUS, _tile1.onFired);
		}
		
		private function setTile2():void
		{
			//tile2 is both in Bus and Zone
			_tile2 = new Tile(_asset["tile2"]);
			_tile2.signInBus();
			_tile2.signInZone(ZoneName.ZONE_B);
			_tile2.addBusListener(BusEvent.FIRE_BUS, _tile2.onFired);
			_tile2.addZoneListener(ZoneEvent.FIRE_ZONE_B, _tile2.onFired);
		}
		
		private function setTile3():void
		{
			//tile3 is not in Bus and not in Zone
			_tile3 = new Tile(_asset["tile3"]);
		}
		
		private function setTile4():void
		{
			//tile4 is not a Role, but have a "Child Role"
			_tile4 = new FreeTile(_asset["tile4"]);
		}
		
		private function onReset(evt:MouseEvent):void
		{
			_tile0.reset();
			_tile1.reset();
			_tile2.reset();
			_tile3.reset();
			_tile4.reset();
			
			//tile3 is not in Bus/Zone, so it can't listen in Bus/Zone, but can fire Bus/Zone.
			_tile3.fireBus(new Event("resetViewA"));
		}
		
		public function dispose():void
		{
			_tile0.removeZoneListener(ZoneEvent.FIRE_ZONE_B, _tile0.onFired);
			_tile0.dispose();
			
			_tile1.removeBusListener(BusEvent.FIRE_BUS, _tile1.onFired);
			_tile1.dispose();
			
			_tile2.removeBusListener(BusEvent.FIRE_BUS, _tile2.onFired);
			_tile2.removeZoneListener(ZoneEvent.FIRE_ZONE_B, _tile2.onFired);
			_tile2.dispose();
			
			_tile3.dispose();
			_tile4.dispose();
			
			_resetBtn.removeEventListener(MouseEvent.CLICK, onReset);
			removeChild(_asset);
			_resetBtn = null;
		}
		
		
		
		
		
	}

}