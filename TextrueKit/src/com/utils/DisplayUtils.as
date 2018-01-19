package com.utils
{
	import flash.display.BitmapData;

	/**
	 * @time 2018-1-19
	 * @author nos(liupengpeng)
	 * @descr 
	 */
	public class DisplayUtils
	{
		public function DisplayUtils()
		{
//			sceneid
//			part1=(tx+int(sceneid/2))
//			part2=(-ty+int(sceneid/3))
//			part3=(sceneid-(tx+ty))
//			words=part1+part3+part2
		}
		
		public static function uncode(bmd:BitmapData):void{
			
			var col:int=bmd.width;
			var row:int=bmd.height;
			var tx:int=0;
			var ty:int=0;
			
			var bockLen:int=10;
			var bx:int=0;
			var by:int=0;
			
			var pixelIndex:int=0;
			
			var pixelValue:int=0;
			
			var av:int=0;
			var rv:int=0;
			var gv:int=0;
			var bv:int=0;
			
			var ff:uint=0xff;
			while(tx<col){
				ty=0;
				while(ty<row){
					bx=0;
					while(bx<bockLen){
						by=0;
						while(by<bockLen){
							pixelValue=bmd.getPixel32(tx+bx,ty+by);
							av=pixelValue>>24&ff;
							rv=pixelValue>>16&ff;
							gv=pixelValue>>8&ff;
							bv=pixelValue>>4&ff;
							
							if(bx<bockLen-4&&by<bockLen-4){
								av=av<<1;
							}
							else if(pixelIndex%3==0){
								rv=rv<<1;
							}
							else if(pixelIndex%3==1){
								gv=gv<<1;
							}
							else if(pixelIndex%3==2){
								bv=bv<<1;
							}
							pixelValue=0;
							pixelValue =pixelValue|av<<24;
							pixelValue =pixelValue|rv<<16;
							pixelValue =pixelValue|gv<<8;
							pixelValue =pixelValue|bv<<4;
							bmd.setPixel32(tx+bx,ty+by,pixelValue);
							by++;
						}
						bx++;
					}
					
					ty+=bockLen;
					pixelIndex++;
				}
				tx +=bockLen;
			}
		}
	}
}