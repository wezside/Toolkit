/**
 * Copyright (c) 2010 Wesley Swanepoel
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
package com.wezside.data.mapping 
{

	/**
	 * @author Wesley.Swanepoel
	 */
	public class XMLDataItem implements IXMLDataItem 
	{
		
		private var _clazz:Class;
		private var _nodeName:String;
		private var _parentCollectionProperty:String;
		private var _id:String;

		
		public function get clazz():Class
		{
			return _clazz;
		}
		
		public function get nodeName():String
		{
			return _nodeName;
		}
		
		public function get parentCollectionProperty():String
		{
			return _parentCollectionProperty;
		}
		
		public function set clazz(value:Class):void
		{
			_clazz = value;
		}
		
		public function set nodeName(value:String):void
		{
			_nodeName = value;
		}
		
		public function set parentCollectionProperty(value:String):void
		{
			_parentCollectionProperty = value;
		}
		
		public function hasOwnProperty( V:* = undefined ):Boolean
		{
			return !V ? false : this[V];
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
	}
}
