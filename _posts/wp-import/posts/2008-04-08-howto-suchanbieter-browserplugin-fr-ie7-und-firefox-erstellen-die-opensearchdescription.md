---
layout: post
title: "HowTo: Suchanbieter / Browserplugin für IE7 und Firefox erstellen - die OpenSearchDescription"
date: 2008-04-08 20:09
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Browser, Firefox, HowTo, IE, IE7, OpenSearchDescription, Xml]
---
{% include JB/setup %}
<p>Vom Firefox und vom IE7 kennen wir diese praktischen Suchfelder:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image377.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="225" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb356.png" width="244" border="0" /></a> </p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image378.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="157" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb357.png" width="244" border="0" /></a> </p>  <p>Doch wie erstellt man so ein Plugin?</p>  <p>Daf&#252;r haben sich die Browserhersteller zusammengesetzt und das &quot;<a href="http://msdn2.microsoft.com/en-us/library/bb891764.aspx">OpenSearchDescription</a>&quot; Format erstellt.</p>  <p>Das ganze habe ich jetzt direkt mal f&#252;r den Blog erstellt. Das XML sieht dazu wie folgt aus:</p>  <p>&#160;</p>  <p>   <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:93eb1297-b0a6-4697-b93a-2cb325c85215" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;?xml version="1.0"?&gt;
&lt;OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/"&gt;
&lt;ShortName&gt;Code-Inside Blog&lt;/ShortName&gt;
&lt;Description&gt;Blogging about .NET, ASP.NET, AJAX, Silverlight&lt;/Description&gt;
&lt;Image height="16" width="16" type="image/x-icon"&gt;{{BASE_PATH}}/wp-content/themes/notso_freshd2/images/favicon.ico&lt;/Image&gt;
&lt;Url type="text/html" method="get" template="{{BASE_PATH}}/?s={searchTerms}"/&gt;
&lt;/OpenSearchDescription&gt;</pre></div>
</p>

<p>Das wichtigste ist eigentlich der &quot;Url&quot; Tag in dem sp&#228;ter das Suchwort eingef&#252;gt wird - um sp&#228;ter direkt auf z.B. <a title="{{BASE_PATH}}/?s=AJAX" href="{{BASE_PATH}}/?s=AJAX">{{BASE_PATH}}/?s=AJAX</a> zu kommen.</p>

<p><strong><u>Einbindung in den Browser</u></strong></p>

<ul>
  <li>Per Javascript:</li>
</ul>

<p>
  <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:58a635f7-278f-4418-ac7a-aea3c0767f74" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;a href="#" onclick='window.external.AddSearchProvider("{{BASE_PATH}}/browserplugin.xml");'&gt;Code-Inside Blog&lt;/a&gt;</pre></div>
</p>

<p>&#220;ber den Javascript Aufruf &quot;AddSearchProvider&quot; kann man direkt die Funktion aufrufen und der Browser zeigt dann z.B. so ein Fenster:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image379.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="185" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb358.png" width="291" border="0" /></a> </p>

<ul>
  <li>Dem Browser mitteilen, dass es ein Plugin gibt</li>
</ul>

<p>Bei der zweiten M&#246;glichkeit wird der Browser &#252;ber diesen Tag direkt &#252;ber das Plugin informiert:</p>

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:99a9de80-196e-41ea-9abf-e34c1fcfdaee" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">	&lt;link rel="search" type="application/opensearchdescription+xml" href="{{BASE_PATH}}/browserplugin.xml" title="Code-Inside Blog" /&gt;
</pre></div>

<p>Damit wird ein Verweis auf das XML gelegt. Im Firefox f&#228;ngt dann das momentane Icon des Suchenfeldes leicht an zu gl&#252;hen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image380.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="44" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb359.png" width="61" border="0" /></a> </p>

<p>Und mit einem Klick kann man den Searchprovider installieren:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image381.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb360.png" width="238" border="0" /></a> </p>

<p>Im IE7 sieht das ganze &#228;hnlich aus:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image382.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="111" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb361.png" width="244" border="0" /></a> </p>

<p><strong>Einfach und effektiv :)</strong></p>
