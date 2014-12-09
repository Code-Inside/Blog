---
layout: post
title: "Geo-Koordinaten einer Adresse herausfinden–Geocoding mit Google Maps"
date: 2011-10-13 00:33
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Geo, Google, Google Maps, HowTo]
language: de
---
{% include JB/setup %}
<p>Um die genauen Geo-Koordinaten einer Adresse rauszubekommen gibt es dutzende Dienste. Einige Wege führen über Javascript und dem Google Maps “Plugin”, andere können auch über eine Schnittstelle angesprochen werden. Die “cleverste” (und kostenlose) Variante ist über die Google Maps <a href="http://code.google.com/apis/maps/documentation/geocoding/">Geocoding API</a>.</p> <p><strong>Request / Response</strong></p> <p>Der Aufbau des Requests ist ziemlich einfach – einfach via Http GET:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e8fb6d32-5a12-4902-9946-6a0d5878f259" class="wlWriterEditableSmartContent"><pre name="code" class="c#">http://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&amp;sensor=true</pre></div>
<p>Die Adresse sollte <a href="http://msdn.microsoft.com/en-us/library/zttxte6w.aspx">Url-Encoded</a> sein.</p>
<p>Bei diesem Aufruf kommt ein JSON zurück. Es gibt auch die Variante mit XML. Ich hab mich aber in meinem Fall für JSON entschieden und parse die ganze Sache über die Bibliothek <a href="http://james.newtonking.com/pages/json-net.aspx">JSON.NET</a>, welche ein “LINQ-to-JSON” (oder sowas ähnliches) hat. </p>
<p>Wenn etwas gefunden wurde (und Google findet meistens etwas – egal wie seltsam die gesuchten Orte formatiert sind!), dann kommt sowas zurück:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1376.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb558.png" width="514" height="330"></a></p>
<p><strong>Zum Code:</strong></p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ca1a47cc-cbda-4cf3-8605-3d9e6c5ac2a6" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    	public class GeoCoordinates
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
        }</pre></div>
<p><strong></strong>&nbsp;</p>
<p>Alles in allem recht einfach.</p>
<p><strong>Was gibt es für Restriktionen?</strong></p>
<p>Pro Tag können nur 2500 Adressen geocodiert werden. Desweiteren ist es laut den Terms of Service auch nur erlaubt, wenn man eine Google Map im UI einsetzt bzw. mit der API “kein” Schindluder treibt (massenhaft Daten abziehen ohne das es Sinn macht).Alles weitere bei <a href="http://code.google.com/apis/maps/documentation/geocoding/#Limits">Google</a>.</p>
