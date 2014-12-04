package src.data 
{
	import flash.utils.Dictionary;
	import net.zonefire.role.Role;
	import src.enum.ZoneName;
	import src.event.ZoneEvent;
	/**
	 * 本演示程序的用户数据(数据来自user.xml)，属于DATA_ZONE；
	 * 该数据对象在AssetLoader类被注册到框架中，供Role/ViewRole随时取用；
	 * 该数据对象接收到ZoneEvent.FIRE_DATA_ZONE区域事件后，先取得当前用户信息，然后发送区域事件通知viewA以显示当前用户信息
	 * @author Will Jiang
	 */
	public class UserData extends Role
	{
		public var defaultUser:UserDto;
		public var currentUser:UserDto;
		public var userArray:Array;
		
		public function UserData() 
		{
			signInZone(ZoneName.DATA_ZONE);
			addZoneListener(ZoneEvent.FIRE_DATA_ZONE, onDataZoneFired);
		}
		
		public function parseXML(xml:XML):void
		{
			userArray = new Array();
			var rankData:RankData = getData(RankData);	//RankData之前已经注册到ZoneFire框架的数据大厅，可以直接取用
			var xmlList:XMLList = XMLList(xml.user);
			var userNum:int = xmlList.length();
			
			for (var i:int = 0; i < userNum; i++ ) {
				var userDto:UserDto = new UserDto();
				userDto.userId = int(xmlList[i].@userId);
				userDto.userName = xmlList[i].@userName;
				userDto.nation = xmlList[i].@nation;
				userDto.sex = xmlList[i].@sex;
				userDto.age = int(xmlList[i].@age);
				userDto.exp = Number(xmlList[i].@exp);
				userDto.rank = rankData.getRankByExp(userDto.exp);	//user.xml中没有用户等级数据，要根据用户exp值从RankData中计算对应的rank值
				userDto.avatar = xmlList[i].@avatar;
				
				if (i == 0) {
					defaultUser = userDto;
					currentUser = userDto;
				}
				
				userArray.push(userDto);
			}
			trace(userDto);
		}
		
		private function onDataZoneFired(evt:ZoneEvent):void
		{
			var id:int = int(evt.flag);
			getCurrentUser(id);
			trace(currentUser);
			fireZone(new ZoneEvent(ZoneEvent.GET_USER_INFO, "DataCenter", id), ZoneName.ZONE_A);
		}
		
		private function getCurrentUser(id:int):void
		{
			for each(var item:UserDto in userArray) {
				if (item.userId == id) {
					currentUser = item;
				}
			}
		}
		
		
		
	}

}