package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import net.zonefire.base.Register;
	import net.zonefire.role.ViewRole;
	import src.Nose;
	import src.Texts;
	
	
	public class Main extends Sprite {
		private var _eyes:MovieClip;
		private var _nose:ViewRole;
		private var _mouth:MovieClip;
		
		public function Main() {
			regData();
			initView();
		}
		
		/**
		 * 初始化视图
		 */
		private function initView():void
		{
			_eyes = new Eyes();
			_eyes.x = 18;
			_eyes.y = 18;
			addChild(_eyes);
			
			_nose = new Nose();
			_nose.x = 150;
			_nose.y = 265;
			addChild(_nose);
			
			_mouth = new Mouth();
			_mouth.x = 103;
			_mouth.y = 460;
			addChild(_mouth);
		}
		
		/**
		 * 向ZoneFire框架注册数据，数据对象注册后即可在任何框架角色中随意调用
		 * 
		 */
		private function regData():void
		{
			Register.regData(Texts);
		}
	}
	
}
