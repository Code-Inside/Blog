---
layout: post
title: "Powershell & IIS – Scripting!"
date: 2013-07-09 22:32
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [IIS, Powershell]
language: de
---
{% include JB/setup %}
<p>Vor einiger Zeit hatte ich bereits geschrieben dass man im Grunde <a href="{{BASE_PATH}}/2012/11/06/setup-iis-8-fr-asp-net-webdeploy-auf-windows-8-und-windows-server-2012/">einen kompletten Server allein über Powershell konfigurieren kann</a>. Natürlich gilt das Ganze auch für den IIS. Über die Powershell hat man interessante Möglichkeiten Prozesse zu automatisieren oder um den IIS zu “verscripten”.</p> <h3>Wichtigster Befehl: Import-Module WebAdministration</h3> <p>Über diesen Schritt holt man sich die IIS Cmdlets in die Session. Ähnlich wie man auf ein anderes Laufwerk wechselt kommt man via “<em>cd iis:</em>” einfach in den IIS Kontext und kann sich dort mit den gewohnten Befehlen frei bewegen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1870.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb1014.png" width="574" height="560"></a> </p> <p></p> <h4>Scripting…</h4> <p>Vermutlich lässt sich jede Admin-Aufgabe im IIS verscripten:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">PS IIS:\Sites&gt; New-Item iis:\Sites\TestSite -bindings @{protocol="http";bindingInformation=":80:TestSite"} -physicalPath c:\test

</pre>
<p></p>
<p>Dies legt eine neue Seite im IIS an oder man geht sehr tief ins System und listet z.B. alle Handlers einer Seite auf.</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">PS IIS:\Sites\DemoSite\DemoApp&gt; Get-WebConfigurationProperty -filter //handlers -name Collection[scriptProcessor="*aspnet_isapi.dll"]  | select name,path
name                                              path
----                                              ----
svc-ISAPI-2.0-64                                  *.svc
svc-ISAPI-2.0                                     *.svc
AXD-ISAPI-2.0                                     *.axd
PageHandlerFactory-ISAPI-2.0                      *.mspx
SimpleHandlerFactory-ISAPI-2.0                    *.ashx
WebServiceHandlerFactory-ISAPI-2.0                *.asmx
HttpRemotingHandlerFactory-rem-ISAPI-2.0          *.rem
HttpRemotingHandlerFactory-soap-ISAPI-2.0         *.soap
AXD-ISAPI-2.0-64                                  *.axd
PageHandlerFactory-ISAPI-2.0-64                   *.mspx
SimpleHandlerFactory-ISAPI-2.0-64                 *.ashx
WebServiceHandlerFactory-ISAPI-2.0-64             *.asmx
HttpRemotingHandlerFactory-rem-ISAPI-2.0-64       *.rem
HttpRemotingHandlerFactory-soap-ISAPI-2.0-64      *.soap</pre>
<p>Die Beispiele kommen von <a href="http://www.iis.net/learn/manage/powershell/powershell-snap-in-creating-web-sites-web-applications-virtual-directories-and-application-pools">hier</a> und <a href="http://www.iis.net/learn/manage/powershell/powershell-snap-in-advanced-configuration-tasks">hier</a>. Aber es gibt noch eine ganze Reihe weiterer Themen auf iis.net:</p>
<p><a href="http://www.iis.net/learn/manage/powershell"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image1871.png" width="230" height="554"></a>&nbsp;</p>
<h4>Empfehlenswerte Links</h4>
<p>Wie bereits bei meinem ursprünglichen Post verlinke ich nochmal den Post <a href="http://www.tugberkugurlu.com/archive/script-out-everything-initialize-your-windows-azure-vm-for-your-web-server-with-iis-web-deploy-and-other-stuff">Script Out Everything - Initialize Your Windows Azure VM for Your Web Server with IIS, Web Deploy and Other Stuff</a> und natürlich nochmal auf die offizielle <a href="http://www.iis.net/learn/manage/powershell">IIS Powershell Seite</a>.</p>
<p>Vielleicht war diese Möglichkeit dem einen oder anderen Leser nicht bekannt – bis vor einigen Monaten kannte ich es noch nicht ;)</p>
