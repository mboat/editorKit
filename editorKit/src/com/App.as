import com.consts.GameConst;
import com.utils.FileUtil;

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
	
	showInfo();
}

/**
 *展示配置信息 
 */
private function showInfo():void{
	var xmlList:XMLList=_cfgXml.elements(GameConst.CFG_NAV);
	menuBar.dataProvider=xmlList.elements(GameConst.CFG_MENU);
}