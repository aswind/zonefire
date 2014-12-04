package src.view 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import net.zonefire.role.ViewRole;
	import net.zonefire.base.Register;
	import src.data.UserData;
	import src.enum.ZoneName;
	import src.event.BusEvent;
	import src.manager.CacheManager;
	import src.manager.LayerManager;
	import src.util.LibAsset;
	
	/**
	 * 这里主要展示如何在调试程序时使用monitor的观察ZoneFire框架内各角色、数据、管理器的活动情况。
	 * 可以点击_debugBtn1在onDebug1()方法中进行诸如签入/签出角色，注册/删除数据和管理器等操作，然后点击
	 * _debugBtn2在monitorDebug()方法中观察ZoneFire框架中角色、数据、管理器的增减情况。
	 * @author Will Jiang
	 */
	public class Debug extends ViewRole
	{
		private var _debugBtn1:SimpleButton;
		private var _debugBtn2:SimpleButton;
		private var _clickCount:int;
		
		public function Debug() 
		{
			makeDebug();
		}
		
		private function makeDebug():void
		{
			_debugBtn1 = LibAsset.getButton("debugBtn");
			_debugBtn1.x = 720;
			_debugBtn1.y = 550;
			addChild(_debugBtn1);
			
			_debugBtn2 = LibAsset.getButton("debugBtn");
			_debugBtn2.x = _debugBtn1.x;
			_debugBtn2.y = _debugBtn1.y + 22;;
			addChild(_debugBtn2);
			
			_debugBtn1.addEventListener(MouseEvent.CLICK, onDebug1);
			_debugBtn2.addEventListener(MouseEvent.CLICK, monitorDebug);
		}
		
		private function onDebug1(evt:MouseEvent):void
		{
			if (_clickCount == 0) {
				Register.deleteData(UserData);
			}else if (_clickCount == 1) {
				Register.regManager(CacheManager);
			}else if (_clickCount == 2) {
				this.signInBus();
			}else if (_clickCount == 3) {
				this.signInZone(ZoneName.ZONE_C);
			}
			
			trace("clickCount =", _clickCount);
			_clickCount++;
		}
		
		
		private function monitorDebug(evt:MouseEvent):void
		{
			trace("A: " + monitor.inBus("[object Role]_6"));
			trace("B: " + monitor.rolesInBus);
			trace("C: " + monitor.zoneNum);
			trace("D: " + monitor.zoneList);
			trace("E: " + monitor.hasZone(ZoneName.ZONE_C));
			trace("F: " + monitor.inZone(ZoneName.ZONE_B, "[object Role]_6"));
			trace("G: " + monitor.rolesInZone(ZoneName.ZONE_B));
			trace("H: " + monitor.dataList);
			trace("I: " + monitor.hasData(UserData));
			trace("J: " + monitor.dataNum);
			trace("K: " + monitor.managerList);
			trace("L: " + monitor.hasManager(LayerManager));
			trace("M: " + monitor.hasManager(CacheManager));
			trace("N: " + monitor.managerNum);
			trace("----------------------");
		}
		
		
		

		
	}

}