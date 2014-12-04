package src.event
{
	import flash.events.Event;
	
	
	public class ZoneEvent extends Event 
	{
		public static const FIRE_ZONE_A:String = "fireZoneA";
		public static const FIRE_ZONE_B:String = "fireZoneB";
		public static const FIRE_DATA_ZONE:String = "fireDataZone";
		public static const CHILD_ROLE_FIRE:String = "childRoleFire";
		public static const GET_USER_INFO:String = "getUserInfo";
		
		
		public var flag:String;			//标识符
		public var data:*;				//事件携带的数据
		
		public function ZoneEvent(type:String, flag:String = null, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			this.flag = flag;
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new ZoneEvent(this.type, this.flag, this.data);
		}
		
	}
}