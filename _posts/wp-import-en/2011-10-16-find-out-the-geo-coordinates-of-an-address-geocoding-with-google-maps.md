---
layout: post
title: "Find out the Geo-coordinates of an address – geocoding with Google Maps"
date: 2011-10-16 16:11
author: CI Team
comments: true
categories: [Uncategorized]
tags: [Google Maps; Geo-coordinates]
language: en
---
{% include JB/setup %}
<p>&nbsp;</p> <p><strong> </strong></p> <p>To find out the exact coordinates of an address there are numerous services available. Some ways goes through Javascript and the Google Maps “Plugin” others are reachable via a surface. The “smartest” (and cheapest / for free) alternative is via Google Maps <a href="http://code.google.com/apis/maps/documentation/geocoding/">Geocoding API</a>.</p> <p><strong>Request / Response </strong></p> <p>The structure of the request is quite easy – via Http GET:</p> <div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b3d17ecc-b4d6-49d4-8b4c-f20fa85a3598" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;"><pre class="c#">http://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&amp;sensor=true</pre></div> <p>The Address has to be <a href="http://msdn.microsoft.com/en-us/library/zttxte6w.aspx">Url-Encoded</a>.</p> <p>After this call a JSON will answer. There is also the option with XML. In my case I’ve decided for JSON and parse the whole thing on a <a href="http://james.newtonking.com/pages/json-net.aspx">JSON.NET</a> library with a “LINQ-ro-JSON” (or something like that).</p> <p>If something is found (and Google founds something every time even how weird the places are formatted) than you are going to receive an answer like this:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-en/image1376.png"><img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image1376" src="{{BASE_PATH}}/assets/wp-images-en/image1376_thumb.png" border="0" alt="image1376" width="535" height="343" /></a></p> <p>&nbsp;</p> <p><strong>About the code:</strong></p> <p><strong> </strong></p> <div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1dd4f5fb-f832-458f-92b9-5a0d84ad0383" class="wlWriterEditableSmartContent" style="margin: 0px; display: inline; float: none; padding: 0px;"><pre class="c#">public class GeoCoordinates
    	{
        	public string Lat { get; set; }
        	public string Lng { get; set; }
        	public string Name { get; set; }
		}

		public GeoCoordinates GetCoordinates(string location)
        {
            string url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + HttpUtility.UrlEncode(location) +
                         "&amp;sensor=true";
            WebClient client = new WebClient();
            JObject result = JObject.Parse(client.DownloadString(url));
            JToken status;
            result.TryGetValue("status", out status);

            if(status.ToString() == "ZERO_RESULTS")
                return new GeoCoordinates();

            var geoCood = result.SelectToken("results[0].geometry.location");

            string lat = geoCood.SelectToken("lat").ToString();
            string lng = geoCood.SelectToken("lng").ToString();
            return new GeoCoordinates() { Name = location,  Lat = lat, Lng = lng };
        }</pre></div> <p>All in all it’s quite easy.</p> <p><strong>What kinds of restrictions are possible?</strong></p> <p><strong> </strong></p> <p>It’s only possible to geocode 2500 addresses per day. Beside according to the Terms of Service it’s only allowed if you set a Google Map into the UI or don’t abuse with the API (for example take a lot of files without any sense). More information’s on <a href="http://code.google.com/apis/maps/documentation/geocoding/#Limits">Google</a>.</p>
