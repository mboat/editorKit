package com.event
{
	/**
	 * 事件类型 
	 * @author nos
	 * 
	 */	
	public class EventType
	{
		/**
		 *收集log信息 
		 */		
		public static const GET_LOG_MSG:String="get_log_msg";
		/**
		 *保存配置信息 
		 */		
		public static const SAVE_CONFIG:String="save_config";
		/**
		 *启动进入帧事件 
		 */		
		public static const START_ENTERFRAME:String="start_enterframe";
		/**
		 *增加文件列表 
		 */		
		public static const ADD_LIST:String ="add_list";
		/**
		 *恢复生产载体初始 
		 */		
		public static const GET_RECOVER:String="get_recover";
		/**
		 * 获取生产载体上的解析数据
		 */		
		public static const GET_DATA:String="get_data";
		/**
		 *文件表格解析完成 
		 */		
		public static const FILE_PASER_COMPLETE:String="file_paser_complete";
		public function EventType()
		{
		}
	}
}