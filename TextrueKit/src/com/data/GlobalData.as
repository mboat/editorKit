package com.data
{
	import com.consts.GameConst;
	
	import flash.utils.Dictionary;

	/**
	 * @time 2018-1-16
	 * @author nos(liupengpeng)
	 * @descr 数据缓存类
	 */
	public class GlobalData
	{
		/**
		 *单列 
		 */		
		private static var _instance:GlobalData;
		/**
		 *数据源文件 
		 */		
		public var filesDict:Dictionary=new Dictionary(true);
		/**
		 *传入参数 
		 */		
		public var arguments:Array;
		/**
		 *破解主配置 
		 */		
		public var mainSuffixs:Array;
		/**
		 *资源文件存放 
		 */		
		public var assetDict:Dictionary =new Dictionary(true);
		/**
		 *后缀分类 
		 */		
		public var suffixs:Dictionary =new Dictionary(true);
		/**
		 *资源格式 
		 */		
		public var origin_type:int=1;
		/**
		 *输出格式 
		 */		
		public var export_formats:int=1;
		public function GlobalData()
		{
			suffixs[GameConst.ORIGIN_SM]=[GameConst.SUFFIX_SM];
			
			mainSuffixs=[GameConst.SUFFIX_SM,GameConst.SUFFIX_JSON];
		}
		
		/**
		 * 单列 
		 * @return 
		 * 
		 */		
		public static function instance():GlobalData
		{ 
			if(_instance==null) _instance =new GlobalData();
			
			return _instance;
		}
	}
}