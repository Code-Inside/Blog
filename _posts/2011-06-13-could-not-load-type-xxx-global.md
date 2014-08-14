---
layout: post
title: "“Could not load type 'XXX.Global'.”"
date: 2011-06-13 23:04
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Error, Fix]
---
<p>Der Blogpost gehört zur Reihe “seltsame Fehlermeldung und stundenlanges Googlen hat nichts gebracht.” Mein Kollege Daniel Kubis bekam beim Starten einer ASP.NET Anwendung folgenden Fehler:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e0e7dac7-06f7-45b2-a967-e4f24ca9fd49" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Parser Error Message: Could not load type 'ApplicationName.Global'.

Source Error: Line 1: &lt;%@ Application Codebehind="Global.asax.cs" Inherits="ApplicationName.Global" %&gt; Source File: Path of Application \global.asax Line: 1
</pre></div>
<p>&nbsp;</p>
<p>Der Fehler ist recht allgemein und es gibt einige Gründe, <a href="http://stackoverflow.com/questions/54001/could-not-load-type-xxx-global">warum dieser Fehler auftreten kann</a>. Im Fall von meinem Kollegen war des Rätsels Lösung folgendes:</p>
<p>Die Web.config aus “C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config” war nicht mehr da. Kurzer Hintergrund zum Ordner “C:\Windows\Microsoft.NET\Framework64\FRAMEWORK_VERSION\Config”: In diesem Ordner liegen allerhand “maschinenweite” Konfigurationen und eine Manipulation dieser Dateien kann zu sehr seltsamen Fehlern führen. Die Datei sollte man auch gefahrlos von einem anderen Rechner kopieren können, ansonsten evtl. nochmal das .NET Framework Setup anwerfen.</p>
