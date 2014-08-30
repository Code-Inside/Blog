---
layout: post
title: "HowTo: AppSettings aus der .Config auslesen"
date: 2009-09-23 21:24
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Client, Config, HowTo, Web]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image823.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="116" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb7.png" width="153" align="left" border="0"></a> Heute ein weiteres, total einfaches HowTo. In die Web.Config/App.Config gibt es einen so genannten "<a href="http://msdn.microsoft.com/de-de/library/ms228154(VS.80).aspx">appSettings</a>" Bereich in dem man bequem bestimmte Einstellungen abspeichern kann. Damit ich mir vielleicht das nächste mal die 5 Minuten googlen sparen kann, schreib ich es einfach mal auf.</p><!--more--> <p><strong>In der web.config bzw. app.config:</strong></p> <p>... gibt es Bereich namens "<a href="http://msdn.microsoft.com/de-de/library/ms228154(VS.80).aspx">appSettings</a>":</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cc5cce83-ab78-4e10-a2db-0edd992d9b2b" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">	&lt;appSettings/&gt;</pre></div></p>
<p>Dort kann man recht simpel Einstellungen abspeichern:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ec510eba-2b9a-4326-a382-3ce62e83c16c" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">	&lt;appSettings&gt;
		&lt;add key="HelloWorldKey" value="... #Yeah From the Web.config..."/&gt;
	&lt;/appSettings&gt;</pre></div>
<p><strong>Darauf zugreifen:</strong></p>
<p>Über den <a href="http://msdn.microsoft.com/de-de/library/system.configuration.configurationmanager(VS.80).aspx">ConfigurationManager</a> bzw. <a href="http://msdn.microsoft.com/de-de/library/system.web.configuration.webconfigurationmanager(VS.80).aspx">WebConfigurationManager</a> kann man nun bequem auf die <a href="http://msdn.microsoft.com/de-de/library/ms228154(VS.80).aspx">appSettings</a> &amp; <a href="http://msdn.microsoft.com/de-de/library/bf7sd233.aspx">connectionStrings</a> zugreifen. <br>Die veraltete <a href="http://msdn.microsoft.com/de-de/library/system.configuration.configurationsettings(VS.80).aspx">ConfigurationSettings</a> - Klasse war in .NET 1.1 Zeiten aktuell.
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:97f68591-02a3-4706-a910-d5399a79e240" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">ViewData["Message"] = WebConfigurationManager.AppSettings["HelloWorldKey"];
</pre></div></p>
<p><strong>Unterschied ConfigurationManager &amp; WebConfigurationManager</strong></p>
<p>Generell kann man sagen:</p>
<p>- Clientanwendung: ConfigurationManager<br>- Webanwendung: WebConfigurationManager</p>
<p>Der WebConfiguratioManager ist speziell für ASP.NET Anwendungen gedacht. So kann man pro Ordner in ASP.NET eine eigene web.config anlegen. Damit soll der WebConfiurationManager besser klar kommen, als der normale ConfigurationManager.<br>Weiteres kann man <a href="http://stackoverflow.com/questions/698157/whats-the-difference-between-the-webconfigurationmanager-and-the-configurationma">hier nachlesen</a>.</p>
<p><strong>Ergebnis:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image824.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="67" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb8.png" width="284" border="0"></a> </p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvcconfig/mvcconfig.zip">[ Download Democode ]</a></strong></p>
