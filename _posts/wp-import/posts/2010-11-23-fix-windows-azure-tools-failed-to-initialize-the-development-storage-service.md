---
layout: post
title: "Fix: Windows Azure Tools: Failed to initialize the Development Storage service."
date: 2010-11-23 23:03
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Azure, SQL]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1109.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb291.png" width="151" height="133" /></a> </p>  <p>Ich habe das Azure SDK 1.2 bei mir installiert und wollte nun eine Anwendung debuggen. Allerdings erhielt ich folgende Fehlermeldungen. Grund: Ich hab bei mir keine SQLExpress Installation, sondern einen richtigen SQL Server 2008R2 bei mir installiert.</p>  <p>Mit einem kleine Trick geht es natürlich trotzdem...</p>  <p><strong>Fehlermeldung</strong></p>  <p>Diese Fehlermeldung bekam ich:</p>  <p><em>Windows Azure Tools: Failed to initialize the Development Storage service. Unable to start Development Storage. Failed to start Development Storage: the SQL Server instance 'localhost\SQLExpress' could not be found.&#160;&#160; Please configure the SQL Server instance for Development Storage using the 'DSInit' utility in the Windows Azure SDK.</em></p>  <p>Wie gesagt: Ich hab einen SQL Server 2008R2 installiert.</p>  <p>Das DSInit Tool findet man für gewöhnlich da:</p>  <p>C:\Program Files\Windows Azure SDK\v1.2\bin\devstore</p>  <p>Beim Aufruf gab es jedoch einen Fehler:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1110.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb292.png" width="328" height="259" /></a> </p>  <p>Grund: Er versucht den SQLExpress Server zu finden. Den gibt es nicht. </p>  <p><strong>Problemlösung</strong></p>  <p>Man kann als Parameter dem Tool auch noch den SQL Instanznamen mitgeben. In der Standardinstallation hat der SQL Server aber keinen Instanznamen. Dies in die CMD eingeben und es geht: </p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:30b90f48-b607-47ca-9cb5-06ed2ec567b1" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Program Files\Windows Azure SDK\v1.2\bin\devstore&gt;DSInit.exe /sqlinstance:</pre></div>

<p><strong>Jetzt klappts auch ;)</strong></p>

<p><strong>Gefunden habe ich diesen Tipp hier:</strong></p>

<ul>
  <li><a href="http://suntsu.ch/serendipity/index.php?/archives/190-Visual-Studio-2010-Problem-Windows-Azure-Tools-Failed-to-initialize-the-Development-Storage-service..html">Visual Studio 2010 Problem: Windows Azure Tools: Failed to initialize the Development Storage service.</a></li>
</ul>
