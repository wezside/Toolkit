/**
 * Copyright (c) 2011 Wesley Swanepoel
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.wezside.utilities.manager.timeline 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author Wesley.Swanepoel
	 */
	public class TimelineEvent extends Event 
	{
		
		public static const READY:String = "timelineReady";
		public static const TARGET_INITIALIZED:String = "timelineTargetInitialized";
		public static const COMPLETE:String = "timelineAnimationComplete";
		public static const SEQUENTIAL_COMPLETE:String = "timelineSequentialAnimationComplete";

		public var id:String;
		public var index:int;
		public var total:int;
		public var targetMC:MovieClip;

		public function TimelineEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, id:String = "", index:int = -1, total:int = -1, targetMC:MovieClip = null )
		{
			super( type, bubbles, cancelable );
			this.id = id;
			this.index = index;
			this.total = total;
			this.targetMC = targetMC;
		}
				
		override public function clone():Event
		{
			return new TimelineEvent( type, bubbles, cancelable, id, index, total, targetMC );
		}		
	}
}
