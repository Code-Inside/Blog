---
layout: post
title: "HowTo: Home Directory / Local Path in IIS6 mit adsutil.vbs anpassen"
date: 2010-03-19 22:18
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ADSUTIL, Deployment, HowTo, IIS, Powershell]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image939.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="160" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb124.png" width="123" align="left" border="0"></a> Gestern <a href="http://code-inside.de/blog/2010/03/19/howtocode-builddeploymentwtf-oder-auch-automatisierung-mit-msbuild/">bloggte</a> ich über das Thema Deployment. Dabei fehlte mir noch ein kleiner Teil: Ich will per Klick mehrere Webseiten im IIS6 ein neues Home Directory zuweisen. Gelöst hab ich das mit <a href="http://www.microsoft.com/technet/prodtechnol/WindowsServer2003/Library/IIS/d3df4bc9-0954-459a-b5e6-7a8bc462960c.mspx?mfr=true">adsutil.vbs</a> und einem <a href="http://stackoverflow.com/questions/1427320/adsutil-vbs-usage-on-iis6">Batch File</a>.</p> <p>Wenn jemand Ideen hat, wie man das mit Powershell umsetzt, dann bitte in den Kommentaren melden ;)</p> <p>&nbsp;</p><!--more--> <p><strong>ADSUTIL.vbs</strong></p> <p><a href="http://www.microsoft.com/technet/prodtechnol/WindowsServer2003/Library/IIS/d3df4bc9-0954-459a-b5e6-7a8bc462960c.mspx?mfr=true">ADSUTIL.vbs</a> liegt standardmäßig im wwwroot unter "AdminScripts". Mit diesem Tool kann man den IIS relativ leicht konfigurieren, z.B.</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a7456bb7-3bc4-4c7e-9b3d-79219097c58b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">Cscript.exe adsutil.vbs SET W3SVC/1/ServerBindings ":81:"</pre></div></p>
<p>(was genau unter einem Serverbinding zu verstehen ist, sollte man wohl lieber nochmal in der Doku nachlesen ;) ). Jedenfalls setzt das Script das Serverbinding der SiteID 1 auf 81.</p>
<p><strong>Woher bekommt man die SiteID?</strong></p>
<p>Am einfachsten bekommt man die <a href="http://weblogs.asp.net/owscott/archive/2005/07/29/421058.aspx">SiteID im IIS5 &amp; IIS6</a> über die <strong>Loggingproperties</strong> raus:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image940.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="338" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb125.png" width="359" border="0"></a> </p>
<p>Hier ist die SiteID 38. Zu sehen im LogfileName.</p>
<p><strong>Home Directory setzen:</strong></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:01396d31-0635-405d-989a-ebfb2a6cf254" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">cscript.exe adsutil.vbs set W3SVC/1/root/path c:\mywebs\prod1</pre></div>
<p>Damit wird das Home Directory auf "c:\mywebs\prod1" gesetzt.</p>
<p><strong>Virtual Directories</strong></p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:bb659acf-bcd4-4d54-8945-3c30d6a9af9f" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">cscript.exe adsutil.vbs set W3SVC/1/VIRTUALDIRECTORY/path c:\mywebs\prod1</pre></div>
<p>Ähnlicher Aufbau. Anstatt der 1 die gewünschte SiteID und dann den Namen wie er im IIS geschrieben steht.</p>
<p><strong>Geht. Powershell wäre schöner und vor allem zukunftsträchtiger</strong></p>
<p>Diese Variante wird wahrscheinlich nur im IIS5/6 funktionieren. Im IIS7 würde ich eher per Powershell da rangehen. Wenn jemand da ein passendes Script hat oder einen Blogpost wo man sowas simples mal nachlesen kann, wäre das sehr hilfreich. Vor allem ob man mit der Powershell auch genauso den IIS6 "administrieren" kann würde mich interessieren :)</p>
