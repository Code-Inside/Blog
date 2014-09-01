---
layout: post
title: "HowTo: Scheduled Tasks mit &quot;schtasks&quot; lokal & remote per Kommandozeile administrieren"
date: 2010-04-21 06:55
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Deployment, HowTo]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image945.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="108" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb130.png" width="146" align="left" border="0"></a>In dem letzten HowTo ging es um <a href="{{BASE_PATH}}/2010/04/13/howto-windows-services-remote-installieren/">Windows Services und sc.exe,</a> diesmal wende ich mich den Scheduled Tasks zu.&nbsp; "<a href="http://msdn.microsoft.com/en-us/library/bb736357(VS.85).aspx">schtasks</a>" ist ein nettes Tool mit dem man lokal und remote Scheduled Tasks anlegen, löschen, abfragen und bearbeiten kann. </p><p><strong>schtasks</strong></p> <p>Hier mal der <a href="http://msdn.microsoft.com/en-us/library/bb736357(VS.85).aspx">Syntax aus der MSDN</a> für das Erstellen eines Tasks:</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:1c62f0db-3d55-4280-ab8e-a09ce980120e" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">schtasks /Create 
[/S system [/U username [/P [password]]]]
[/RU username [/RP [password]] /SC schedule [/MO modifier] [/D day]
[/M months] [/I idletime] /TN taskname /TR taskrun [/ST starttime]
[/RI interval] [ {/ET endtime | /DU duration} [/K] 
[/XML xmlfile] [/V1]] [/SD startdate] [/ED enddate] [/IT] [/Z] [/F]</pre></div></p>
<p><strong>Anwendungsfall</strong></p>
<p>Wir benutzen eine Batch-Datei für das "installieren" einer neuen Version. Mit einem Klick werden <a href="{{BASE_PATH}}/2010/03/19/howto-home-directory-local-path-in-iis6-mit-adsutil-vbs-anpassen/">IIS 6 Websites</a>, <a href="{{BASE_PATH}}/2010/04/13/howto-windows-services-remote-installieren/">Windows Services</a> und nun auch Scheduled Tasks entsprechend angepasst. Für uns am interessantesten war der "TR" Parameter mit dem man den genauen Pfad des Programm angibt und der "change" Befehl.</p>
<p>Wenn wir eine neue Version gebaut haben und auf den Server kopiert haben haben wir z.B. folgende Ordnerstruktur:</p>
<p>C:\Projektname\1.0.0.0\WindowsService1\windowsservice1.exe<br>C:\Projektname\1.0.0.0\Website1\...aspx...<br>C:\Projektname\1.0.0.0\ScheduledTasks1\scheduledtask1.exe</p>
<p>Wenn jetzt Version 1.0.0.1 dazukommt legen wir diesen in den "Projektname" Ordner. Im Version 1.0.0.1 Ordner liegt dazu noch das Batchfile zum "scharf" schalten der Version - keine große Magie, aber praktisch und falls doch was schief geht ist die alte Version auch noch vorhanden :)</p>
