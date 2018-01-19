package com
{
	import com.consts.GameConst;
	import com.data.GlobalData;
	import com.event.DataEvent;
	import com.event.EventManager;
	import com.event.EventType;
	import com.factory.BaseFactory;
	import com.factory.JsonFactory;
	import com.factory.SmFactory;
	import com.utils.FileUtil;
	
	import flash.display.Shape;
	import flash.filesystem.File;
	import flash.utils.Dictionary;

	/**
	 * @time 2018-1-17
	 * @author nos(liupengpeng)
	 * @descr 
	 */
	public class FactoryManager
	{
		private static var _instance:FactoryManager;
		
		private var _data:GlobalData;
		
		private var _shape:Shape =new Shape();
		
		private var poolDict:Dictionary =new Dictionary(true);
		private var dataDict:Dictionary =new Dictionary(true);
		
		private var _runningList:Array=[];
		private var sn:int=0;
		public function FactoryManager()
		{
			_data=GlobalData.instance();
			EventManager.instance().register(EventType.GET_DATA,getDataHandler);
			EventManager.instance().register(EventType.GET_RECOVER,getRecoverHandler);
		}
		/**
		 * 单列 
		 * @return 
		 */		
		public static function instance():FactoryManager{
			if(_instance ==null){
				_instance =new FactoryManager();
			}
			return _instance;
		}
		
		/**
		 * 收集数据处理函数 
		 * @param evt
		 * 
		 */		
		private function getDataHandler(evt:DataEvent):void{
			var endProduct:BaseFactory=evt.data;
			var dataList:Array=dataDict[endProduct.type];
			if(dataList==null){
				dataList=dataDict[endProduct.type]=[];
			}
			
			var runIndex:int=_runningList.indexOf(endProduct.getId());
			if(runIndex>=0){
				_runningList.splice(runIndex,1);
			}
			dataList.push(endProduct.getProducts());
			
			endProduct.recover();
		}
		/**
		 * 回收产品利用函数 
		 * @param evt
		 * 
		 */		
		private function getRecoverHandler(evt:DataEvent):void{
			var endProduct:BaseFactory=evt.data;
			endProduct.reset();
			
			var productslist:Array=poolDict[endProduct.type];
			productslist.push(endProduct);
		}
		
		public function startup():void{
			readFiles();
		}
		
		private function readFiles():void{
			var list:Array=[];
			var tempFile:File=_data.filesDict[GameConst.ORIGIN_DIR];
			FileUtil.readFilesByExts(tempFile,list);
			
			var mainList:Array=[];
			
			var mainSuffixs:Array=_data.mainSuffixs;
			for (var i:int = 0; i < list.length; i++) 
			{
				tempFile=list[i];
				if(mainSuffixs.indexOf(tempFile.extension)>=0){
					mainList.push(tempFile);
				}else{
					_data.assetDict[tempFile.name]=tempFile;
				}
			}
			
			while(mainList.length>0){
				var targetFile:File=mainList.shift();
				var tempFactory:BaseFactory=getFormatFactory(targetFile.extension);
				if(tempFactory){
					tempFactory.parse(targetFile,_data.assetDict);
				}
			}
		}
		
		private function getFormatFactory(suffix:String):BaseFactory{
			var list:Array=poolDict[suffix];
			if(list==null){
				list=poolDict[suffix]=[];
			}
			
			var startProduct:BaseFactory=null;
			if(list.length>0){
				startProduct=list.shift();
			}else{
				startProduct=createFactory(suffix);
			}
			return startProduct;
		}
		
		private function createFactory(suffix:String):BaseFactory{
			switch(suffix){
				case GameConst.SUFFIX_SM:
					return new SmFactory(sn++);
				case GameConst.SUFFIX_JSON:
					return new JsonFactory(sn++);
			}
			return null;
		}
	}
}