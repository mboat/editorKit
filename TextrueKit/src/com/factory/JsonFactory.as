package com.factory
{
	import com.utils.FileUtil;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * @time 2018-1-17
	 * @author nos(liupengpeng)
	 * @descr 
	 */
	public class JsonFactory extends BaseFactory
	{
		public function JsonFactory(sid:int)
		{
			super(sid);
		}
		
		public override function parse(file:File,dict:Dictionary):void{
			parseDataFormat(FileUtil.getBytesByFile(file));
		}
		
		private function parseDataFormat(bytes:ByteArray):void{
			if(bytes==null){
				recover();
				return 
			}
		}
	}
}