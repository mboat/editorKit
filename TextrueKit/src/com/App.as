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
		viewPanel.title="输出路径："+path;
	}else{
		viewPanel.title="输出路径：无";
	}
	path=_cfgXml[GameConst.ORIGIN_DIR];
	if(checkPathExists(path)){
		orgPanel.title="源路径："+path;
	}else{
		orgPanel.title="源路径：无";
	}
	
	var navXml:XMLList=_cfgXml.elements(GameConst.NAVIGATION);
	var barXml:XML=new XML(navXml.toXMLString());
	
	navXml=_cfgXml.elements(GameConst.ACTIONS);
	var tempXml:XML=new XML("<item type='separator'/>");
	navXml.appendChild(tempXml);
	tempXml=new XML("<item label='增加行为'/>");
	navXml.appendChild(tempXml);
	barXml.appendChild(navXml);
	
	tempXml=new XML("<root><menu label='操作'><item label='选中导出'/><item label='全部导出'/></menu></root>");
	barXml.appendChild(tempXml.elements());
	bar.dataProvider=barXml.elements();
//	checkPath(path,browseOrgDirComplete,"资源目录：");
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
	orgTree.dataProvider=file;
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
	viewPanel.title="输出路径："+file.nativePath;
}

private function checkOutput():void{
	checkPath(_cfgXml[GameConst.OUTPUT_DIR],browseOutputDirComplete,"输出目录：");
}