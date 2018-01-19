package com.factory
{
	import com.consts.GameConst;
	import com.data.GlobalData;
	import com.event.EventManager;
	import com.event.EventType;
	
	import flash.filesystem.File;
	import flash.utils.Dictionary;

	/**
	 * @time 2018-1-17
	 * @author nos(liupengpeng)
	 * @descr 
	 */
	public class BaseFactory
	{
		/**
		 *w唯一id 
		 */		
		private var _id:int=0;
		/**
		 *输出类型 
		 */		
		public var type:String=null;
		/**
		 *数据存储变量 
		 */		
		protected var content:*;
		/**
		 * 状态：-1.初始，0.进行重，1.完成 
		 */		
		protected var status:int=-1;
		public function BaseFactory(sid:int)
		{
			_id=sid;
		}
		
		public function parse(file:File,dict:Dictionary):void{
			status=0;
		}
		
		/**
		 *输出路径记录 
		 */		
		private var _outPath:String;
		/**
		 * 获取输出目录 路径
		 * @return 
		 */		
		protected function getOutputPath():String{
			if(_outPath==null){
				var outFile:File=GlobalData.instance().filesDict[GameConst.OUTPUT_DIR];
				_outPath=outFile.nativePath;
			}
			return _outPath;
		}
		
		/**
		 *完成函数 
		 * 
		 */		
		protected function complete():void{
			status=1;
		}
		
		public function recover():void{
			EventManager.instance().dispatcherWithEvent(EventType.GET_RECOVER,this);
			reset();
		}
		
		/**
		 * 唯一id 
		 * @return 
		 * 
		 */		
		public function getId():int{
			return _id;
		}
		/**
		 * 获取当前的数据集 
		 * @return 
		 * 
		 */		
		public function getProducts():*{
			
			return content;
		}
		/**
		 * 获取状态 
		 * @return 
		 * 
		 */		
		public function getStatus():int{
			return status;
		}
		/**
		 *重置数据 
		 * 
		 */		
		public function reset():void{
			content=null;
			status=-1;
		}
	}
}