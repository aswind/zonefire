package src.data 
{
	/**
	 * 本演示程序的用户等级配置数据(记录每个等级对应的经验值范围)。
	 * 该数据对象在AssetLoader类中被注册到框架的数据大厅，供Role/ViewRole随时取用
	 * 等级数据实例不发送或侦听框架事件，所以不需要继承Role...
	 * @author Will Jiang
	 */
	public class RankData 
	{
		private var _rank:Array;
		private var _minExp:Array;
		private var _maxExp:Array;
		
		private var _rankArray:Array;
		
		public function RankData() 
		{
			initData();
		}
		
		private function initData():void
		{
			_rank = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
			_minExp = [0, 11, 31, 71, 111, 161, 221, 291, 371, 461];
			_maxExp = [10, 30, 70, 110, 160, 220, 290, 370, 460, 560];
			
			_rankArray = new Array();
			
			for (var i:int = 0; i < _rank.length; i++ ) {
				var rankObj:RankDto = new RankDto();
				rankObj.rank = _rank[i];
				rankObj.minExp = _minExp[i];
				rankObj.maxExp = _maxExp[i];
				
				_rankArray.push(rankObj);
			}
		}
		
		/**
		 * 根据用户exp取得对应的用户等级详细数据
		 * @param	exp	用户经验值
		 * @return	该用户经验值所对应的用户等级各项数据，没有找到对应数据则返回null
		 */
		public function getRankDtoByExp(exp:Number):RankDto
		{
			var rankDto:RankDto;
			
			for (var i:int = 0; i < _rank.length; i++ ) {
				rankDto = _rankArray[i];
				
				if (exp >= rankDto.minExp && exp <= rankDto.maxExp) {
					return rankDto;
				}
			}
			
			return null;
		}
		
		/**
		 * 根据用户exp取得对应的用户等级rank
		 * @param	exp	用户经验值
		 * @return	exp对应的用户等级。没有找到对应的rank则返回-1
		 */
		public function getRankByExp(exp:Number):int 
		{
			var rankDto:RankDto;
			
			for (var i:int = 0; i < _rank.length; i++ ) {
				rankDto = _rankArray[i];
				
				if (exp >= rankDto.minExp && exp <= rankDto.maxExp) {
					return rankDto.rank;
				}
			}
			
			return -1;
		}
		
		
	}

}