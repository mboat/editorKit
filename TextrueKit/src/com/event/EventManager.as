package com.event
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class EventManager
	{
		private var _listener:EventDispatcher;
		private static var _instance:EventManager;
		public function EventManager()
		{
			_listener=new EventDispatcher();
		}
		
		
		/**
		 * 单列 
		 * @return 
		 * 
		 */		
		public static function instance():EventManager{
			if(_instance==null) _instance =new EventManager();
			return _instance;
		}
		/**
		 * 抛出 事件 
		 * @param type 事件类型
		 * @param bubbles
		 * @param cancelable
		 */		
		public function dispatcherWithEvent(type:String,value:*=null):void{
			_listener.dispatchEvent(new DataEvent(type,value));
		}
		/**
		 * 注册侦听事件 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 * 
		 */		
		public function register(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void{
			_listener.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		/**
		 * 移除侦听事件 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * 
		 */		
		public function remove(type:String, listener:Function, useCapture:Boolean=false):void{
			_listener.removeEventListener(type,listener,useCapture);
		}
		
	}
}