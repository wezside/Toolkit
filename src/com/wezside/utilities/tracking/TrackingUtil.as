/*
	The MIT License

	Copyright (c) 2011 Wesley Swanepoel
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
 */
package com.wezside.utilities.tracking 
{
	import com.wezside.utilities.logging.Tracer;

	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;

	/**
	 * A manager class dealing with tracking. It supports Omniture, GoogleAnalytics and general
	 * image request tracking like Eyeblaster, Floodlight or Spotlight tracking.    
	 * 
	 * Ported from the AS2 version by Wesley Swanepoel. 
	 * @author Wesley.Swanepoel
	 * @version .693
	 * @date 20080311
	 * 
	 * modified by Wijnand Warren
	 */

	public class TrackingUtil 
	{

		private static const DEBUG:Boolean = false;
		private static const CHANNEL_ID:String = "channel";
		private static const PRODUCT_ID:String = "product";
		private static const PAGENAME_ID:String = "pageName";
		private static const CAMPAIGN_ID:String = "globalCampaign";
		private static const EVENTS_ID:String = "events";
		private static const TYPE_STATIC:String = "staticType";
		private static const TYPE_DYNAMIC:String = "dynamicType";
		private static const PAGENAME_DELIMITER:String = ":";
		private static const EVENT_DELIMITER:String = ",";

		private var settings:Boolean = false;
		private var instance:TrackingUtil;	

		private var sourceXML:XML;
		private var dataObj:Object;
		private var pageNameSettings:XMLList;
		private var channelSettings:XMLList;
		private var propSettings:Array; 
		private var evarSettings:Array;
		private var requestList:Array;
		private var _aSource:*;

		
		public function TrackingUtil() 
		{
			if ( instance != null )
				Tracer.output(DEBUG, " Instantiate using getInstance()", toString(), Tracer.ERROR);
		}

		
		/**
		 * Singleton creation. 
		 * @return TrackingManager An instance of the TrackingManager class
		 */	
		public function getInstance():TrackingUtil 
		{
			if ( instance == null )
				instance = new TrackingUtil();
			
			return instance;
		}

		
		/**
		 * Initialise the tracking XML object. This method is required to be called before anything else. 
		 * @param _sourceXML The XML object that is required for use of all tracking tags
		 * @param container A container DisplayObject representing the parent of the 
		 */
		public function init( _sourceXML:XML):void 
		{
			
			sourceXML = _sourceXML;
			dataObj = new Object();
			propSettings = new Array();
			evarSettings = new Array();
			requestList = new Array();
			channelSettings = new XMLList();
			pageNameSettings = new XMLList();
			
			var node:XMLList = new XMLList();
			node = getTrackingNodeByType( "omniture" );
			
			if ( !settings ) 
			{
				settings = true;
				omnitureSettings(node);
				setValues(node);
			}
		}

		
		/**
		 * Add props and eVars to the internal data object
		 * @param arg_arr An array of XMLNodes containing the item nodes of a variable 
		 * 			in the format &lt;item id="pageName"&gt;&lt;![CDATA[home]]&gt;&lt;/item&gt;
		 * 
		 * @param node The tracking node containing the entire tracking type
		 * 		   <tracking type="omniture">..</tracking>
		 */
		public function addPropEvarVariables( arg_arr:XMLList ):void 
		{
			for (var i:Number = 0;i < arg_arr.length(); i++) 
				dataObj[ arg_arr[i].@id ] = { type: TYPE_DYNAMIC, value: arg_arr[i].text() };
		}

		
		/**
		 * Add events to the internal data object
		 * @param arr An Array of XMLNodes containing all the events to be added 
		 */
		public function addEventVariables( arr:XMLList ):void 
		{
			var value:String = "";
			for (var i:Number = 0;i < arr.length(); i++) 
			{
				if ( value != "" ) value += EVENT_DELIMITER;
				value += arr[i].text();
			}
			
			if ( value != "" ) dataObj[EVENTS_ID] = { type: TYPE_DYNAMIC, value: value };/**/
		}

		
		/**
		 * The main method to call when tracking Omniture using XML 
		 * <p><b>Example:</b></p>
		 * <ul>
		 * <li>TrackingManager.getInstance().init( trackingXML, _level0 );</li>
		 * <li>TrackingManager.trackOmniture( "home" );</li>
		 * <li>TrackingManager.trackOmniture( "products", false, true );</li>
		 * </ul>
		 * @param trackID The item ID specified in the XML to track.
		 *
		 * @param doTrack A flag indicating if the ActionSource track() method should
		 * 			be invoked. This is useful should you want to set the 
		 * 			internal object variables but not actually track anything.
		 *
		 * @param reset A flag indicating if the internal data object should be reset.
		 * 		    If not specified the internal object will retain the previous 
		 * 		    values set and send those when the ActionSource track() method 
		 * 		    is invoked.
		 *
		 * @param initObject Specify this object should you want to manually override 
		 * 			   variables. Object should be in the format 
		 * 			   obj = {key: value}; or obj = {prop2: "hello world"}
		 *
		 * @param delay A delay in MS for when the ActionSource track() method is 
		 * 		    invoked.
		 */	
		public function trackOmniture( trackID:String, doTrack:Boolean = true, reset:Boolean = false, initObject:Object = null, delay:Number = 0 ):void 
		{

			if ( reset )
				resetData();
			
			var node:XMLList = new XMLList();
			node = getTrackingNodeByType("omniture");
								
			if ( aSource != null ) 
			{

				var trackItem:XMLList = new XMLList(node.track_item.(@id == trackID));
				var trackType:String = new XMLList(trackItem.@type);
				var propList:XMLList = new XMLList(trackItem.item.(attribute("group") == "prop"));
				var evarList:XMLList = new XMLList(trackItem.item.(attribute("group") == "eVar"));
				var eventList:XMLList = new XMLList(trackItem.item.(attribute("group") == "event"));
				var propEvarList:XMLList = new XMLList(propList.copy() + evarList.copy());
				var channel:String = trackItem.item.(@id == "channel").text();
				var pageName:String = trackItem.item.(@id == "pageName").text();
				var globalCampaign:String = trackItem.item.(@id == "globalCampaign").text();
				var product:String = trackItem.item.(@id == "products").text();
								
				if ( channel != null && channel.length > 0 ) dataObj[CHANNEL_ID] = { type: TYPE_DYNAMIC, value: channel };
				if ( pageName != null && pageName.length > 0) dataObj[PAGENAME_ID] = { type: TYPE_DYNAMIC, value: pageName };
				if ( product != null && product.length > 0 ) dataObj[PRODUCT_ID] = { type: TYPE_DYNAMIC, value: product };
				if ( globalCampaign != null && globalCampaign.length > 0 ) dataObj[CAMPAIGN_ID] = { type: TYPE_DYNAMIC, value: globalCampaign };
								
				addPropEvarVariables(propEvarList);
				addEventVariables(eventList);
				updateASource(node, trackItem, doTrack);
				
				if ( initObject != null ) updateASourceNoBuild(initObject);
				if ( doTrack ) sendOmnitureTrack(trackType, pageName, delay);
			} else 
			{
				Tracer.output(DEBUG, " No ActionSource component defined.", instance.toString(), Tracer.ERROR);	
			}
		}

		
		/**
		 * Basically any tracking method requiring a direct request for a blank 
		 * image with additional post vars. Used quite often with Floodlight/Spotlight/Eyeblaster
		 * 
		 * @param type The type of tracking (Floodlight, Spotlight or Eyeblaster)
		 * @param trackID Page ID as defined by client
		 */	
		public function trackByImageRequest( type:String, trackID:String ):void 
		{
			var node:XMLList = getTrackingNodeByType(type);
			var pageID:String = node.track_item.(@id == trackID);
			var rand:Number = Math.floor(Math.random() * 10000000);
			var loader:URLLoader = new URLLoader();
			var req:URLRequest = new URLRequest(pageID + rand);
			req.method = URLRequestMethod.POST; 
			loader.load(req);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			
			Tracer.output(DEBUG, " TrackingManager.trackEB(type, trackID): " + pageID, instance.toString(), Tracer.INFO);
		}
		
		/**
		 * Google Analytics tracking method, using ga.js
		 * More info: http://www.google.com/support/googleanalytics/bin/answer.py?answer=55520&amp;topic=11006
		 * 
		 * @param trackID Page ID as defined by client
		 */
		public function trackGooglePage( trackID:String, concat:String = "" ):void 
		{
			var node:XMLList = getTrackingNodeByType("google");
			var pageID:String = node.track_item.(@id == trackID);
			
			if( ExternalInterface.available ) {
//				ExternalInterface.call("globalTracker._trackPageview", pageID + concat);
				Tracer.output(DEBUG, " TrackingManager.trackGooglePage(): " + pageID, instance.toString(), Tracer.INFO);
			}
			else {
//				navigateToURL(new URLRequest("javascript:globalTracker._trackPageview(" + pageID + ")"));
				Tracer.output(DEBUG, " TrackingManager.trackGooglePage(): " + pageID + concat, instance.toString(), Tracer.INFO);
			}
		}
		
		/**
		 * Google Analytics tracking method, using ga.js
		 * More info: http://www.google.com/support/googleanalytics/bin/answer.py?answer=55520&amp;topic=11006
		 * 
		 * @param trackID Page ID as defined by client
		 */
		public function trackGoogleEvent( trackID : String, concat:String = "" ) : void {
			var node:XMLList = getTrackingNodeByType("google");
			var label:String = node.track_item.(@id==trackID).text();
			var category : String = node.track_item.(@id==trackID).@category;
			var action : String = node.track_item.(@id==trackID).@action;
			if( ExternalInterface.available ) 
			{
				ExternalInterface.call("globalTracker._trackEvent", category, action, label + concat );
				Tracer.output(DEBUG, " TrackingManager.trackGoogleEvent(): " + label + concat, instance.toString(), Tracer.INFO);
			}
			else {
				navigateToURL(new URLRequest("javascript:globalTracker._trackEvent(" + category + "," + action + "," + label + ")"));
				Tracer.output(DEBUG, " TrackingManager.trackGoogleEvent(): " + label + concat, instance.toString(), Tracer.INFO);
			}
		}
		
		/**
		 * Webtrends tracking method for an item in the XML file.
		 * This method calls the javascript function dcsMultitrack that must be implemented in the html page. 
		 * @param trackID    The item ID specified in the XML to track.
		 */
		public function trackWebtrends( trackID:String ):void 
		{
		
			var node:XMLList = new XMLList();
			node = getTrackingNodeByType("webtrends"); 
			var method:String = node.@["method"];
			var trackItem:XMLList = node.track_item.(@id == trackID);
			var campaignName:String = node.@campaignName || "";
			var key:String = "";
			var value:String = "";
			var trackString:String = "";
			
			for each(var item:XML in trackItem.item) 
			{
				key = item.@id;
				value = item.text();
				trackString += "'" + key + "'" + ",'" + value ;
				if (item.childIndex() != trackItem.children().length() - 1 )
				{
					trackString += ",'";
				} else
				{
					trackString += "'";	
				}
			}
			
			if ( trackString != null ) 
			{
				if ( campaignName != "" ) trackString = "'" + campaignName + "'," + trackString;
				navigateToURL(new URLRequest("javascript: " + method + "(" + trackString + ");"), "_self");
				Tracer.output(DEBUG, " TrackingManager.trackWebtrends : " + trackID, getInstance().toString(), Tracer.INFO);					
			}
			else 
			{
				Tracer.output(DEBUG, instance.toString(), Tracer.ERROR, " No Webtrends params defined.");	
			}
		}


		public function get aSource():*
		{
			return _aSource;
		}
		
		public function set aSource( value:* ):void
		{
			_aSource = value;
		}

		
		/**
		 * Populates the dataObj with the  values
		 * @param node the xml node with the omniture tracking settings
		 * @return n/a
		 */
		private function setValues( node:XMLList ):void 
		{

			var List:XMLList = XMLList(node.Vars.item);
			for each (var Item:XML in List)
				dataObj[Item.@id] = {type:TYPE_STATIC, value:Item.text()};
		}

		
		
		/**
		 * Calls the ActionSource track() or trackLink() method if the delay is less or equal to zero.
		 * If a delay is specified, the track values are added to the queue and the timer is invoked. If 
		 * trackLink() is used, possible parameters are  url, type indicating which link report the URL 
		 * or name will be displayed in. Type can have the following possible values "o" (Custom Links), 
		 * "d"? (File Downloads) and "e" (Exit Links). The Name parameter identifies the name that will 
		 * appear in the link report. 
		 *   
		 * @param trackType "page" or "link" refers to the type of tracking that will happen.
		 */		
		private function sendOmnitureTrack( trackType:String, pageName:String, delay:Number = 0 ):void 
		{
			Tracer.output(DEBUG, " sendOmnitureTrack() - type: " + trackType + ", pageName: " + pageName + ", delay: " + delay, instance.toString());
			
			if ( delay <= 0 ) 
			{
				trackType == "page" ? aSource.track() : aSource.trackLink(pageName, "o", pageName);
			}
			else 
			{
				requestList.push(new Array(trackType, pageName));
				var delayTimer:Timer = new Timer(delay, 1);
				delayTimer.addEventListener(TimerEvent.TIMER, delayedOmnitureTrack);
				delayTimer.start();
			}
		}

		
		/**
		 * Called after the delay set in sendOmnitureTrack is reached
		 * @param e the TimerEvent sent by the Times
		 * @return none
		 */
		private function delayedOmnitureTrack( e:TimerEvent ):void 
		{
			Tracer.output(DEBUG, " delayedOmnitureTrack()", instance.toString());
			if(requestList.length <= 0 ) return;
			var requestItem:Array = requestList.shift();
			sendOmnitureTrack(requestItem[0], requestItem[1]);
		}

		
		/**
		 * These settings are required by the ActioSource component to successfully send tracking data
		 * @param node is the target settings node for Omniture tracking  
		 */
		private function omnitureSettings( node:XMLList ):void 
		{

			var actionSourceStr:String = node.account_settings.item.(@id == "actionSource").text();
			var account:String = node.account_settings.item.(@id == "account").text();
			var charset:String = node.account_settings.item.(@id == "charSet").text();
			var currency:String = node.account_settings.item.(@id == "currencyCode").text();
			var clickmap:String = node.account_settings.item.(@id == "trackClickMap").text();
			var movieID:String = node.account_settings.item.(@id == "movieID").text();
			var nameSpace:String = node.account_settings.item.(@id == "visitorNamespace").text();
			var dc:String = node.account_settings.item.(@id == "dc").text();
			var trackingServer:String = node.account_settings.item.(@id == "trackingServer").text();
			var trackingServerSecure:String = node.account_settings.item.(@id == "trackingServerSecure").text();
			var vmk:String = node.account_settings.item.(@id == "vmk").text();
			
			pageNameSettings = node.settings.item.(@id == "pageName");
			channelSettings = node.settings.item.(@id == "channel");
					 
			if ( aSource == null ) 
			{
				Tracer.output(DEBUG, instance.toString(), Tracer.ERROR, " No ActionSource component defined.");
				return;
			}
	
			aSource.account = account;
			aSource.visitorNamespace = nameSpace;
			aSource.dc = Number(dc);
							
			if ( movieID != null) aSource.movieID = movieID;
			if ( charset != null ) aSource.charSet = charset;
			if ( currency != null) aSource.currencyCode = currency;
			if ( clickmap != null ) aSource.trackClickMap = Boolean(clickmap); 
			if ( trackingServer != null ) aSource.trackingServer = trackingServer;
			if ( trackingServerSecure != null ) aSource.trackingServerSecure = trackingServerSecure;
			if ( vmk != null ) aSource.vmk = vmk;
			
			Tracer.output(DEBUG, " OmnitureSettings: actionSourceStr " + actionSourceStr, instance.toString());
			Tracer.output(DEBUG, " OmnitureSettings: account " + account, instance.toString());
			
			if ( nameSpace != "" ) Tracer.output(DEBUG, " OmnitureSettings: nameSpace " + nameSpace, instance.toString());
			if ( dc != "" ) Tracer.output(DEBUG, " OmnitureSettings: dc " + dc, instance.toString());
			if ( charset != "" ) Tracer.output(DEBUG, " OmnitureSettings: charset " + charset, instance.toString());
			if ( currency != "") Tracer.output(DEBUG, " OmnitureSettings: currency " + currency, instance.toString());
			if ( clickmap != "" ) Tracer.output(DEBUG, " OmnitureSettings: clickmap " + clickmap, instance.toString());
			if ( movieID != "") Tracer.output(DEBUG, " OmnitureSettings: movieID " + movieID, instance.toString());
			if ( trackingServer != "" ) Tracer.output(DEBUG, " OmnitureSettings: trackingServer " + trackingServer, instance.toString());
			if ( trackingServerSecure != "" ) Tracer.output(DEBUG, " OmnitureSettings: trackingServerSecure " + trackingServerSecure, instance.toString());
			if ( vmk != "" ) Tracer.output(DEBUG, " OmnitureSettings: vmk " + vmk, instance.toString());
		}

		
		/**
		 * Retrieves the XML node with the settings for the specified type of tracking.
		 * @param type The type of tracking to retreive from the XML
		 */
		private function getTrackingNodeByType( type:String ):XMLList 
		{
			return sourceXML.tracking.(@type == type);
		}

		
		private function updateASource( node:XMLList, trackItem:XMLList, doTrack:Boolean = true):void 
		{
			if ( doTrack )
				Tracer.output(DEBUG, "\n-------------- TRACK ITEM: " + buildFinalValue(PAGENAME_ID, node, trackItem) + " --------------", instance.toString());
			
			for ( var a:String in dataObj ) 
			{
				var str:String = buildFinalValue(a, node, trackItem);
				if ( str != "" ) 
					aSource[a] = str;
				
				if ( a != CAMPAIGN_ID && str != "" && ( doTrack )) Tracer.output(DEBUG, " " + a + " = " + aSource[a], instance.toString(), Tracer.INFO);
			}
		}

		
		private function updateASourceNoBuild( data:Object ):void 
		{
			Tracer.output(DEBUG, "\n-------------- TRACK ITEM --------------", instance.toString());
			for ( var a:String in data ) 
			{
				var str:String = data[a];
				if ( str != "" ) 
					aSource[a] = str; 
				
				if ( a != CAMPAIGN_ID) Tracer.output(DEBUG, " " + a + " = " + aSource[a], instance.toString(), Tracer.INFO);
			}
		}

		
		/**
		 * Builds the string to send for tracking from XML track_item
		 * <ul>
		 * <li><b>First step:</b> retrieve settings array</li>
		 * <li><b>Second step:</b> check if array is empty</li>
		 * <li><b>Third step:</b> get individual values from settings array</li>
		 * <li><b>Fourth step:</b> if individual values don't exist, look to internal dataObject to see if it has been previously added</li>
		 * <li><b>Fifth step:</b> if it was added, append to return string</li>
		 * <li><b>Sixth step:</b> if not added before, remove trailing delimiter</li>
		 * </ul>
		 * @return concatenated string (ie  ww:products:w960)
		 */
		private function buildFinalValue( id:String, node:XMLList, trackItem:XMLList ):String 
		{
			
			var value:String = "";
			var xValue:String = "";		
			
			var settingsArr:XMLList = node.settings.( attribute("id") == id ).item; 
			if ( id.substring(0, 4) == "prop") 
			{
				settingsArr = node.settings.(@id == "prop").prop.(@id == id).item;
			}
			if ( id.substring(0, 4) == "eVar") 
			{
				settingsArr = node.settings.(@id == "eVar").eVar.(@id == id).item;
			}

			if ( settingsArr.length() > 0 ) 
			{
				var arrLength:int = settingsArr.length();
				for (var i:Number = 0;i < arrLength; i++ ) 
				{
					if ( xValue != "" ) value += PAGENAME_DELIMITER;
					xValue = trackItem.track_item.item.(@id == settingsArr[i].@id).text();
					
					if ( xValue == "" ) 
					{
						(dataObj[settingsArr[i].@id] != undefined && dataObj[settingsArr[i].@id].value != null) ? xValue = dataObj[settingsArr[i].@id].value : xValue = "";
						value += xValue;
						if ( xValue == "" ) value = value.substring(0, value.lastIndexOf(":"));
					}
					else 
					{
						value += xValue;
					}
				}
				return value;
			}
			else 
			{
				if(dataObj[id] != null) 
				{
					return dataObj[id].value;
				}
				else 
				{
					return "";
				}
			}
		}

		
		private function loaderSecurityErrorHandler( e:SecurityErrorEvent ):void 
		{
			Tracer.output(DEBUG, e.text, instance.toString(), Tracer.ERROR);
		}

		
		private function loaderIOErrorHandler( e:IOErrorEvent):void 
		{
			Tracer.output(DEBUG, e.text, instance.toString(), Tracer.ERROR);
		}

		
		/**
		 * Reset the dynamic values of internal data object 
		 */
		public function resetData():void 
		{
			for ( var a:String in dataObj ) 
			{ 
				if ( dataObj[a] != null && dataObj[a].type == TYPE_DYNAMIC ) 
				{
					dataObj[a] = null;	
					aSource[a] = null;
				}
			}
		} 

		
		/**
		 * Get an instance of the ActionSource component
		 */
		public function getAsource():Object 
		{
			return aSource;
		}

		
		/**
		 * Gets a copy of the internal data object
		 */
		public function copyInternalObject():Object 
		{
			var tempData:Object = new Object();
			for(var i:String in dataObj)
				tempData[i] = dataObj[i];
			
			return tempData;
		}

		
		/**
		 * Sets the internal data object to the object sent to this function
		 * @param data the data to set as the internal data object
		 */
		public function setInternalObject( data:Object ):void 
		{
			dataObj = data;
		}

		
		/**
		 * Set a  value manually on the internal data object
		 */
		public function setValue( key:String, value:String ):void 
		{
			dataObj[key] = {type: TYPE_STATIC, value:value};
		}

		
		/**
		 * Get a  value from the internal data object
		 */
		public function getValue( key:String ):Object 
		{
			return dataObj[key];
		}

		
		/**
		 * A string representation of this class.
		 */
		public function toString():String 
		{
			return getQualifiedClassName(this);
		}
	}
}
