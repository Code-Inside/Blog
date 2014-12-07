---
layout: post
title: "Features & Rollen über die Kommandozeile in Windows Server 2008 installieren: ServerManagerCmd.exe"
date: 2013-01-30 22:39
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Powershell, RampUp, Server 2008, Windows Server 2008]
language: de
---
{% include JB/setup %}
<p>Der Windows Server 2008 hat schon ein paar Jährchen auf dem Buckel, allerdings trifft man ihn trotzdem noch hier und da. Wer das Server-Ramp-Up automatisieren möchte, der kann unter dem Windows Server 2012 und Windows Server 2008 R2 das <a href="http://technet.microsoft.com/en-us/library/ee662311.aspx">Powershell Modul “ServerManager” benutzen</a>. </p> <p><strong>Unter Windows Server 2008:</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1747.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb901.png" width="584" height="103"></a></p> <p>:(</p> <p><strong>Wie weiter?</strong></p> <p> Nach ein wenig Suchen bin ich dann auf den Vorgänger des Powershell Modules aufmerksam geworden – das Kommandozeilen Tool “ServerManagerCmd.exe” </p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1748.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb902.png" width="566" height="272"></a> </p> <p>Die Anwendung sollte unter C:\Windows\System32 vorhanden sein und kann daher direkt über die Kommandozeile aufgerufen werden. </p> <p>Das Tool funktioniert dabei ähnlich wie die Powershell Module:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1749.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb903.png" width="563" height="160"></a> </p> <p>Man kann auch mehrere Features angeben etc.</p> <p>Damit sollte es auch unter dem alten Server klappen die Installation zu automatisieren. Vielleicht hilft es dem einen oder anderem.</p>
