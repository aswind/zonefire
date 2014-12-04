package src.event
{
	import flash.events.Event;
	
	
	public class BusEvent extends Event 
	{
		public static const FIRE_BUS:String = "fireBus";
		
		
		public var flag:String;			//标识符
		public var data:*;				//事件携带的数据
		
		public function BusEvent(type:String, flag:String = null, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			this.flag = flag;
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new BusEvent(this.type, this.flag, this.data);
		}
		
	}
}


