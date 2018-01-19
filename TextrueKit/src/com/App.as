import com.FactoryManager;
import com.consts.GameConst;
import com.utils.FileUtil;

import flash.filesystem.File;

// ActionScript file
/**
 *保存配置文件 
 */
private function saveCfg():void{
	var path:String =_root+_cfgpath;
	XML.ignoreProcessingInstructions = false;
	FileUtil.saveFile(path,_cfgXml.toXMLString());
}
/**
 *检测配置 
 */
private function checkCfg():void{
	_root =File.applicationDirectory.nativePath;
	
	var path:String =_root+_cfgpath;
	var cfgFile:File =new File(path);
	_cfgXml=new XML(FileUtil.readByUTFBytes(cfgFile));	
	
	path=_cfgXml[GameConst.OUTPUT_DIR];
	if(checkPathExists(path)){
		panel.title="输出路径："+path;
	}else{
		panel.title="输出路径：";
	}
	path=_cfgXml[GameConst.ORIGIN_DIR];
	checkPath(path,browseOrgDirComplete,"资源目录：");
}


/**
 * 检测路径是否正确
 */
private function checkPathExists(path:String):Boolean{
	if(path&&path.length>0){
		if(path.indexOf(".")==0){
			path=path.replace(".",_root);
		}
		var tempfile:File=new File(path);
		if(tempfile.exists==false){
			return false;
		}
	}
	return true;
}
/**
 * 检测路径是否正确
 */
private function checkPath(path:String,backFun:Function,title:String=null):void{
	var loadFile:Boolean=false;
	if(path&&path.length>0){
		if(path.indexOf(".")==0){
			path=path.replace(".",_root);
		}
		var tempfile:File=new File(path);
		if(tempfile.exists==false){
			loadFile=true;
		}else{
			backFun(tempfile,false);
			return;
		}
	}else{
		loadFile=true;
	}
	if(loadFile){
		FileUtil.browseForDirectory(browseComplete,title);
	}
	
	function browseComplete(file:File):void{
		backFun(file,true);
	}
}

/**
 *选择完成表格所在目录 
 */
private function browseOrgDirComplete(file:File,savebool:Boolean=true):void{
	_data.filesDict[GameConst.ORIGIN_DIR]=file;
	if(savebool){
		_cfgXml[GameConst.ORIGIN_DIR]=file.nativePath;
		saveCfg();
	}
	tree.dataProvider=file;
	tree.visible=true;
//	checkOutput();
}

/**
 *选择完成表格所在目录 
 */
private function browseOutputDirComplete(file:File,savebool:Boolean=true):void{
	_data.filesDict[GameConst.OUTPUT_DIR]=file;
	if(savebool){
		_cfgXml[GameConst.OUTPUT_DIR]=file.nativePath;
		saveCfg();
	}
//	
//	FactoryManager.instance().startup();
}

private function checkOutput():void{
	checkPath(_cfgXml[GameConst.OUTPUT_DIR],browseOutputDirComplete,"输出目录：");
}