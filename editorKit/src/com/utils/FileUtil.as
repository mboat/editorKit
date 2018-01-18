package com.utils
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**文件辅助类
	 * @author nos
	 */	
	public class FileUtil
	{
		public function FileUtil()
		{
		}
		/**浏览选择文件夹
		 * @param fun 设置带参数回调函数，函数的返回参数为选中的文件
		 */		
		public static function browseForDirectory(fun:Function=null):void
		{
			try{
				var file:File=File.desktopDirectory;
				file.browseForDirectory("Select Directory");
				file.addEventListener(Event.SELECT, directorySelected);
			}catch (error:Error){
				trace("Failed:", error.message);
			}
			
			function directorySelected(event:Event):void 
			{
				file.removeEventListener(Event.SELECT, directorySelected);
				var browsefile:File=event.target as File;
				if(fun!=null){
					fun.apply(null,[browsefile]);
				}
			}
		}
		/**文件另存为
		 * @param txt 需要保存的文本内容
		 */		
		public static function browseForSave(txt:String):void
		{
			var docsDir:File = File.documentsDirectory;
			try
			{
				docsDir.browseForSave("另存为");
				docsDir.addEventListener(Event.SELECT, saveData);
			}
			catch (error:Error)
			{
				trace("Failed:", error.message);
			}
			
			function saveData(event:Event):void 
			{
				docsDir.removeEventListener(Event.SELECT, saveData);
				var newFile:File = event.target as File;
				if (!newFile.exists)
				{
					var stream:FileStream = new FileStream();
					stream.open(newFile, FileMode.WRITE);
					stream.writeUTFBytes(txt);
					stream.close();
				}
			}
		}
		/**浏览打开文件
		 * @param fileFilter 过滤需要的文件类型
		 * @param backFun 设置带参数回调函数，函数的返回参数为选中的文件
		 */		
		public static function browseForOpen(fileFilter:FileFilter,backFun:Function=null):void
		{
			var fileToOpen:File = new File();
			try 
			{
				fileToOpen.browseForOpen("打开", [fileFilter]);
				fileToOpen.addEventListener(Event.SELECT, fileSelected);
			}
			catch (error:Error)
			{
				trace("Failed:", error.message);
			}
			
			function fileSelected(event:Event):void 
			{
				fileToOpen.removeEventListener(Event.SELECT, fileSelected);
				if(backFun!=null){
					backFun.apply(null,[File(event.target)]);
				}
			}
		}
		
		/**
		 * 简单urlload 加载文件
		 * @param path 需要加载的文件路径
		 * @param loadOverHandler 加载完成后的回调函数 ，如：loadCookieOver(evt:Event)
		 */		
		public static function urlloadFile(path:String,loadOverHandler:Function=null):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,loadOverHandler);
			loader.dataFormat=URLLoaderDataFormat.TEXT;
			loader.load(new URLRequest(path));
		}
		/**保存文件
		 * @param vpath 文件保存带名字路径 /cookie.txt;
		 * @param txt 保存的文字内容
		 */		
		public static function saveFile(vpath:String,txt:String,callFun:Function=null):void
		{
			var vfile:File=new File(vpath);
			if(vfile==null)return;
			if(vfile.exists==true){
				vfile.deleteFile();
			}
			var fileStream:FileStream = new FileStream();
			fileStream.openAsync(vfile, FileMode.WRITE);
			fileStream.writeUTFBytes(txt);
			//			fileStream.writeMultiByte(txt, "gb2312");
			fileStream.addEventListener(Event.CLOSE, fileClosed);
			fileStream.close();
			
			function fileClosed(event:Event):void {
				trace(vfile.name+"保存完成。");
				if(callFun!=null){
					callFun.apply();
				}
			}            
		}
		
		/**保存文件
		 * @param vpath 文件保存带名字路径 /cookie.txt;
		 * @param bytes 保存的二进制
		 */		
		public static function saveBytesFile(vpath:String,bytes:ByteArray,callFun:Function=null):void
		{
			var vfile:File=new File(vpath);
			if(vfile==null)return;
			if(vfile.exists==true){
				vfile.deleteFile();
			}
			var fileStream:FileStream = new FileStream();
			fileStream.openAsync(vfile, FileMode.WRITE);
			fileStream.writeBytes(bytes,0,bytes.length);
			//			fileStream.writeMultiByte(txt, "gb2312");
			fileStream.addEventListener(Event.CLOSE, fileClosed);
			fileStream.close();
			
			function fileClosed(event:Event):void {
				trace(vfile.name+"保存完成。");
				if(callFun!=null){
					callFun.apply();
				}
			}            
		}
		/**将文件转成二进制数据
		 * @param path 文件路径
		 * @return 
		 */		
		public static function fileToByteArray(path:String):ByteArray
		{
			var file:File=new File(path);
			return getBytesByFile(file);
		}
		
		/**
		 * 根据文件读取二进制 
		 * @param file 指定文件
		 * @return ByteArray
		 * 
		 */		
		public static function getBytesByFile(file:File):ByteArray{
			var bytes:ByteArray=null;
			if(file&&file.exists&&file.isDirectory==false){
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.READ);
				stream.position=0;
				bytes=new ByteArray();
				stream.readBytes(bytes,0,stream.bytesAvailable);
				stream.close();
			}
			return bytes;
		}
		
		/**将文件的二进制数据转为字符窜
		 * @param fileBytes 文件的二进制数据
		 * @return String
		 */		
		public static function fileBytesToString(fileBytes:ByteArray):String
		{
			var str:String="";
			if(fileBytes&&fileBytes.bytesAvailable>0){
				var len:int=1024;
				var value:int=-1;
				fileBytes.position=0;
				while(len>0&&fileBytes.bytesAvailable>0){
					value=fileBytes.readByte();
					if(value==-1){
						return str;
					}
					str+=value.toString(16);
					len--;
				}
			}
			return str;
		}
		/**
		 * 读取文本 
		 * @param file 需要读取的文件
		 * @return String
		 */	
		public static function readByUTFBytes(file:File):String
		{
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.READ);
			stream.position=0;
			//文件内容：字符窜
			var str:String= stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			return str;
		}
		
		
		/**
		 * 读取文本 
		 * @param file 需要读取的文件
		 * @param chat 编码集规范
		 * @return String
		 */		
		public static function readByUTFBytes2(file:File,chat:String="iso-8859-1"):String
		{
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.READ);
			stream.position=0;
			//文件内容：字符窜
			var str:String= stream.readMultiByte(stream.bytesAvailable,chat);
			stream.close();
			return str;
		}
		
		/**
		 * 读目录下指定类型的文件类型 
		 * @param file 文件夹
		 * @param exts 文件类型数组
		 * @param exclueList 排除文件列表
		 * @param loop 读取深度
		 * @return 文件数组
		 */		
		public static function readFilesByExts(file:File,saveList:Array,exts:Array,exclueList:Array=null,loop:Number=int.MAX_VALUE):void{
			if(file){
				var files:Array = file.getDirectoryListing();
				for(var i:uint = 0; i < files.length; i++)
				{
					var temp:File=files[i] as File;
					var path:String=temp.nativePath;
					if(exclueList&&exclueList.length>0){
						var exclueBool:Boolean=false;
						var itemStr:String;
						for(var k:int=0;k<exclueList.length;k++ ){
							itemStr=exclueList[k];
							if(itemStr&&itemStr.length>0&&path.indexOf(itemStr)>=0){
								exclueBool=true;
								break;
							}
						}
						if(exclueBool){
							continue;
						}
					}
					
					if(temp.isDirectory&&temp.getDirectoryListing().length>0&&loop>0){
						var tempLoop:Number=loop-1;
						//					tempList.push(temp);
						readFilesByExts(temp,saveList,exts,exclueList,tempLoop);
					}else{
						var bool:Boolean=true;
						if(exts!=null&&exts.length>0){
							bool=exts.indexOf(temp.extension)>=0;
						}
						if(bool)saveList.push(temp);
					}
				}
			}
		}
		
	}
}