package com.data
{
	/**
	 * @time 2018-1-16
	 * @author nos(liupengpeng)
	 * @descr 数据缓存类
	 */
	public class GlobalData
	{
		
		public var arguments:Array;
		private static var _instance:GlobalData;
		public function GlobalData()
		{
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