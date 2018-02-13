package com.utils
{
	import flash.display.BitmapData;

	/**
	 * @time 2018-2-13
	 * @author nos(liupengpeng)
	 * @descr 
	 */
	public class FormatExportUtil
	{
		/**
		 *输出图片规格大小：256 
		 */		
		public static const SIZE_256:int=256;
		/**
		 *输出图片规格大小：512 
		 */	
		public static const SIZE_512:int=512;
		/**
		 *输出图片规格大小：1024 
		 */	
		public static const SIZE_1024:int=1024;
		public function FormatExportUtil()
		{
		}
		
		public function exportFormat(format:int,action:String,dir:String,bmds:Vector.<BitmapData>,avatarName:String=null):void{
			
		}
		
		public function trimLayoutBmds(fileName:String,bmds:Vector.<BitmapData>):void{
			for (var i:int = 0; i < bmds.length; i++) 
			{
				
			}
			
		}
	}
}