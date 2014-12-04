package src.data 
{
	/**
	 * 用户等级详细数据的数据结构，记录用户等级和和对应的经验值取值范围...
	 * @author Will Jiang
	 */
	public class RankDto 
	{
		public var rank:int;			//用户等级值
		public var minExp:Number;		//某等级经验值下标
		public var maxExp:Number;		//某等级经验值上标
		
		
		public function RankDto() 
		{
			
		}
		
	}

}