---
layout: post
title: "YouTube API - Video Meta Daten über .NET abrufen"
date: 2011-11-15 01:22
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [API, GData, HowTo, YouTube]
language: de
---
{% include JB/setup %}
<p>Vor <a href="{{BASE_PATH}}/2008/01/09/howto-youtube-mit-c-durchsuchen-einstieg-in-die-youtube-api-google-data-api/">sehr, sehr langer Zeit hatte ich drüber gebloggt</a>, wie man mit den <a href="http://code.google.com/apis/youtube/getting_started.html#data_api">Google Data APIs</a> auf YouTube zugreift. Da einige Zeit vergangen ist, gibt es natürlich auch neue Wege wie man nun die Daten abrufen kann. Google stellt für YouTube eine “einfachere” Schnittstelle zur Verfügung. Wer low-Level HTTP calls machen möchte, der kann <a href="http://code.google.com/apis/youtube/2.0/developers_guide_protocol_audience.html">dies natürlich auch machen</a>.</p> <p>Ziel: Ich möchte die Daten zu diesem YouTube Video – dabei habe ich die genaue URL bereits:</p> <p><a href="http://www.youtube.com/watch?v=ItqQ2EZziB8">http://www.youtube.com/watch?v=ItqQ2EZziB8</a> (anders als mein alter Blogpost, wo ich <a href="{{BASE_PATH}}/2008/01/09/howto-youtube-mit-c-durchsuchen-einstieg-in-die-youtube-api-google-data-api/">Dinge</a> gesucht habe)</p> <p><strong>Per NuGet die Bibliotheken runterladen</strong></p> <p>Für das komfortable Zugreifen eignet sich die Google Data APIs. Diese findet man auch auf NuGet.</p> <p>Benötigt werden das <strong>Google.GData.Client</strong> und das <strong>Google.GData.YouTube</strong> Package:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1388.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb570.png" width="537" height="168"></a></p> <p><strong>Code</strong></p> <p>(da mein Testclient eine Konsolenanwendung ist und ich Funktionalität aus der System.Web Assembly benötige, habe ich es auf das volle .NET 4.0 Framework umgestellt.)</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:740280be-52ed-4877-ac6d-220822b7abdf" class="wlWriterEditableSmartContent"><pre name="code" class="c#">			Uri youTubeLink = new Uri("http://www.youtube.com/watch?v=ItqQ2EZziB8");
            var parameters = System.Web.HttpUtility.ParseQueryString(youTubeLink.Query);
            var videoId = parameters["v"];

            Uri youTubeApi = new Uri(string.Format("http://gdata.youtube.com/feeds/api/videos/{0}", videoId));
            YouTubeRequestSettings settings = new YouTubeRequestSettings(null, null);

            YouTubeRequest request = new YouTubeRequest(settings);
            var result = request.Retrieve&lt;Video&gt;(youTubeApi);

            Console.WriteLine(result.Title);
            Console.WriteLine(result.Description);
            Console.WriteLine(result.ViewCount);

            Console.ReadLine();</pre></div>
<p>&nbsp;</p>
<p><strong>Erklärung</strong></p>
<p>In Zeile 3 hole ich mir den “v”-Parameter für das Video. In Zeile 5 lege ich leere YouTubeRequestSettings an – damit kann ich alle öffentlichen Daten abrufen, allerdings keine Kommentare verfassen oder Videos hochladen (was eigentlich klar ist).</p>
<p>Danach wird über request.Retrieve das Video abgeholt. Danach stehen mir allerhand Meta Informationen zum Video zur Verfügung.</p>
<p><strong>Keine “Retrieve”-Methode zu sehen? </strong></p>
<p>Ich hatte beim Entwickeln ein seltsames Problem – unter dem Request-Objekt hatte ich keine Retrieve oder Get Methode. Ich bin mir nicht sicher woran es lag. Jedenfalls stammt die YouTubeRequest Klasse aus dem Google.YouTube Namespace – evtl. hatte ich eine andere Klasse erwischt.</p>
<p>Weitere Infos gibts es auf der<strong> </strong><a href="http://code.google.com/apis/youtube/2.0/developers_guide_protocol.html"><strong>YouTube API .NET Seite</strong></a><strong>.</strong></p>
<p><strong>Ergebnis meines Codes</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1389.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb571.png" width="555" height="222"></a></p>
<p><strong><a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2Fyoutubeapi%253Fstate%253Dclosed">[ Code on Google Code ]</a></strong></p>
