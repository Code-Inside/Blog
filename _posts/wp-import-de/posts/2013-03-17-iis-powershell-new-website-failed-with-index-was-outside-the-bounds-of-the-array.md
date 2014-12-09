---
layout: post
title: "IIS & Powershell: New-Website failed with “Index was outside the bounds of the array”"
date: 2013-03-17 01:25
author: robert.muehsig
comments: true
categories: [Fix]
tags: [IIS, Powershell]
language: de
---
{% include JB/setup %}
<p>Wer ein Windows Server 2008 bzw. Windows Server 2008R2 nutzt, der kann den <a href="http://www.iis.net/learn/manage/powershell/powershell-snap-in-creating-web-sites-web-applications-virtual-directories-and-application-pools">IIS über die Powershell relativ einfach administrieren</a>, allerdings bin ich da über einen kleinen Fehler gestolpert, der auf Windows Server 2012 nicht auftritt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1791.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb945.png" width="574" height="76"></a> </p> <p></p> <p>Wenn der IIS keine Seiten enthält und ich über New-WebSite eine Seite anlegen möchte, dann kommt der Fehler “Index was outside the bounds of the array.”</p> <p><strong>Fehlerbehebung: ID explizit mitgeben</strong></p><pre>New-Website -Name Foobar <strong>-Id 1</strong> -PhysicalPath C:\inetpub\wwwroot</pre>
<p>Auf einem Windows Server 2012 ist dies nicht nötig. </p>
<p>Gefunden habe ich diesen Tipp <a href="http://forums.iis.net/t/1159761.aspx/3/10">hier</a>.</p>
