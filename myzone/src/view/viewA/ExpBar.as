package src.view.viewA 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import src.data.RankDto;
	/**
	 * 经验值进度条控制类...
	 * @author Will Jiang
	 */
	public class ExpBar 
	{
		private var _asset:MovieClip;
		
		private var _tField:TextField;
		private var _progressBar:MovieClip;
		
		public function ExpBar(asset:MovieClip) 
		{
			_asset = asset;
			
			initView();
		}
		
		private function initView():void
		{
			_tField = _asset["tField"];
			_progressBar = _asset["progressBar"];
		}
		
		
		/**
		 * 显示用户经验值进度条
		 * @param	userExp	用户的经验值
		 * @param	rankDto	和用户经验值所属等级相对应的等级配置数据
		 */
		public function showProgress(userExp:Number, rankDto:RankDto):void
		{
			var rankRange:Number = rankDto.maxExp - rankDto.minExp;
			var rankExp:Number = userExp - rankDto.minExp;
			
			var percent:Number = rankExp / rankRange;
			_progressBar.scaleX = percent;
			_tField.text = rankExp + "/" + rankRange;
		}
		
	}

}