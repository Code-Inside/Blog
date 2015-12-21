---
layout: post
title: ".NET 4.0 & IIS6 mit WCF und REST"
date: 2013-03-19 23:10
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [IIS6, REST, WCF]
language: de
---
{% include JB/setup %}
<p>Seit Ewigkeiten hatte ich mal wieder einen IIS6 vor mir und hatte die Aufgabe unsere WCF und ASP.NET MVC App (basierend noch auf .NET 4.0) auf diesem System zu installieren. <br>Da die Plattform doch schon etliche Jahre auf den Buckel hat gibt es hier jetzt nur die wichtigsten Knackpunkte (ohne auf die Unzulänglichkeiten des IIS6 einzugehen), damit eure .NET 4.0 App auf dem IIS6 funktioniert:</p> <p><strong>Checkliste:</strong></p> <p>- .NET 4.0 installiert?</p> <p>- aspnet_regiis.exe –i ausgeführt?</p> <p>- ASP.NET 4.0 in den “web server extensions” aktiviert?</p> <p>- Wildcard-Mapping (in der Website gibt es irgendwo ein “Configure” Button) auf aspnet_isapi.dll (und “Verify file exists” rausnehmen!)?</p> <p>Dann lief es zumindest bei mir – mit ASP.NET 4.0, HTTP PUT/DELETE etc. und WCF.</p> <p><strong>Das “Ende” ist absehbar</strong></p> <p>Die (meiner Meinung nach) gute Nachricht zuerst: Das .NET 4.0 Framework ist das letzte Framework was für Windows Server 2003 (und Windows XP auf der Clientseite) zur Verfügung steht. Danach muss man wohl oder übel sich ein neueres Betriebssystem installieren. </p> <p>Wer .NET 4.5 einsetzen möchte, der braucht mindestens Windows Server 2008!</p> <p><strong>Weitere Hilfe benötigt?</strong></p> <p>In <a href="http://forums.asp.net/post/4134821.aspx">diesem Post</a> stehen noch ein paar weitere Tipps (<a href="http://forums.asp.net/t/1551597.aspx/1?+NET+4+0+and+IIS+6+Deployment+problem">hier zum ganzen Foren-Thread</a>).</p>
