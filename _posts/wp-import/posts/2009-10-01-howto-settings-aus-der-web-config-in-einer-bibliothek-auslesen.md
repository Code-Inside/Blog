---
layout: post
title: "HowTo: Settings aus der Web.config in einer Bibliothek auslesen"
date: 2009-10-01 22:38
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [app.config, Config, HowTo, Konfiguration, web.config]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image829.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="138" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb13.png" width="193" align="left" border="0"></a> Das heutige HowTo behandelt ein sehr simples Thema, was mir aber bis gestern nicht bewusst war. Folgendes Problem: Ich hab eine Web Anwendung mit vielen appSettings in der web.config - wie lese ich jetzt am besten diese Daten in einer Klassenbibliothek aus?<br></p><!--more--> <p><strong>Szenario</strong></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image830.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 5px 0px 0px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb14.png" width="179" align="left" border="0"></a>Wir&nbsp; haben zwei Projekte: Eine Klassenbibliothek und eine Webanwendung. Nun möchte ich in der "ReadFromConfig.cs" gerne auf die appSettings der Web.Config zugreifen, wie macht man das am einfachen?</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p>&nbsp;</p> <p><strong>Lösung des Problems</strong></p> <p>Die Lösung ist eigentlich total einfach - man verwendet einfach den <a href="{{BASE_PATH}}/2009/09/23/howto-appsettings-aus-der-config-auslesen/">ConfigurationManager</a>.<br><strong><u>Achtung:</u></strong> In einem Klassenbibliotheks-Projekt muss man die "<strong>System.Configuration.dll</strong>" mit einbinden!</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9edb07f0-4702-41fe-abb2-0ba6e46e005a" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">    public static class ReadFromConfig
    {
        public static string Get()
        {
            return ConfigurationManager.AppSettings["ConfigKey"];
        }
    }</pre></div></p>
<p>Über den ConfigurationManager wird automatisch auf die Web.config, welche in dem anderen Projekt ist, zugegriffen - ohne noch viel zu machen.</p>
<p><strong>Welche Konfiguration nimmt .NET?</strong></p>
<p>(vereinfach gesagt) Lädt .NET immer die Konfiguration der "Hauptanwendung". Ich starte das "MvcLibConfig" Projekt und .NET lädt genau diese web.config. referenzierte Projekte können dann nahtlos auf die gleiche Konfiguration zugreifen.<br> Mit app.Configs aus der Desktop-Welt sollte es ähnlich sein.</p>
<p><strong>Simpel, oder?</strong></p>
<p><img style="border-right: 0px; border-top: 0px; margin: 0px 0px 0px 10px; border-left: 0px; border-bottom: 0px" height="244" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb15.png" width="183" align="right" border="0">Ich war mir nicht ganz sicher ob ich das überhaupt bloggen sollte, aber da es mir bis gestern nicht klar war, dass sowas so einfach geht, wollte ich es euch nicht verschweigen.</p>
<p>Im Prinzip recht einleuchtend ;)</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/mvclibconfig/mvclibconfig.zip">[ Download Demosource ]</a></strong></p>
