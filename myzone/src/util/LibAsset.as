package src.util 
{
	/**
	 * 从程序域获取库元素。程序加载素材swf后，即可随时通过库链接名到库中提取所需要的库元素
	 * @author Will Jiang
	 */
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	 
	public class LibAsset 
	{
		
		/**
		 * 获取MovieClip, domain=null时从当前域的库中获取
		 * @param	linkName	库元件的AS链接名
		 * @param	domain	库元件所在的程序域
		 * @return
		 */
		public static function getMovieClip(linkName:String, domain:ApplicationDomain = null):MovieClip	
		{
			var MyClass:Class = getClass(linkName, domain);
			
			if (MyClass != null) {
				return MovieClip(new MyClass());
			}
			return null;
		}
		
		
		
		/**
		 * 获取SimpleButton, domain=null时从当前域的库中获取
		 * @param	linkName	库元件的AS链接名
		 * @param	domain	库元件所在的程序域
		 * @return
		 */
		public static function getButton(linkName:String, domain:ApplicationDomain = null):SimpleButton		
		{
			var MyClass:Class = getClass(linkName, domain);
			
			if (MyClass != null) {
				return SimpleButton(new MyClass());
			}
			return null;
		}
		
		
		
		
		//=========================================================================================
		
		public static function getClass(linkName:String, domain:ApplicationDomain = null):Class
		{
			if(domain == null){
				domain = ApplicationDomain.currentDomain;
			}
			
			if(domain.hasDefinition(linkName)){
				return domain.getDefinition(linkName) as Class;
			}else{
				trace("get no definition byName:" + linkName);
			}
			return null;
		}
		
	}

}