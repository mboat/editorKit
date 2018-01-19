package com.data
{
	import com.consts.ActionConst;
	import com.consts.GameConst;

	/**
	 * @time 2018-1-17
	 * @author nos(liupengpeng)
	 * @descr 
	 */
	public class ActionFormatVO
	{
		public var id:String;
		public var offetX:int;
		public var offetY:int;
		
		public var actionName:String;
		public var totalFrames:uint;
		public var actionSpeed:uint;
		
		public var replay:int=-1;
		public var skillFrame:int=0;
		
		public var hitFrame:int=0;
		public var totalDir:int=0;
		public var totalTime:int=0;
		
		public var intervalTimes:Vector.<int>=new Vector.<int>;
		public var txs:Vector.<Vector.<int>>=new Vector.<Vector.<int>>;
		public var tys:Vector.<Vector.<int>>=new Vector.<Vector.<int>>;
		public var widths:Vector.<Vector.<uint>> =new Vector.<Vector.<uint>>;
		public var heights:Vector.<Vector.<uint>> =new Vector.<Vector.<uint>>;
		
		public var bitmapdatas:Vector.<Vector.<String>> =new Vector.<Vector.<String>>;
		public var max_rects:Vector.<Vector.<uint>> =new Vector.<Vector.<uint>>;
		
		public var dirOffsetX:Vector.<int> =new Vector.<int>;
		public var dirOffsetY:Vector.<int> =new Vector.<int>;
		
		public var isDispose:Boolean=false;
		public var nativePath:String;
		public function ActionFormatVO()
		{
			
		}
		
		public function getLink(dir:int,frame:int):String{
			actionName=actionName.split(ActionConst.WARM).join(ActionConst.ATTACK);
			return id+"."+actionName+"."+dir+"."+frame;
		}
		
		public function getAssetName():String{
			return id+"_"+actionName;
		}
	}
}