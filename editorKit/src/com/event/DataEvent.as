package com.event
{
	import flash.events.Event;
	
	public class DataEvent extends Event
	{
		public var data:*;
		public function DataEvent(type:String,value:*)
		{
			data=value;
			super(type);
		}
	}
}