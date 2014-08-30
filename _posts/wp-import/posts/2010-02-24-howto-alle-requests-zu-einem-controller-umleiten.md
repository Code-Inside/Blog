---
layout: post
title: "HowTo: Alle Requests zu einem Controller umleiten"
date: 2010-02-24 00:12
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo, MVC, Routing]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image931.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="119" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb116.png" width="181" align="left" border="0"></a>Wer in einer <a href="http://asp.net/mvc">ASP.NET MVC</a> Anwendung <strong>ALLE</strong> Requests zu einem Controller umgeleitet haben möchte, kann dies sehr einfach über <a href="http://msdn.microsoft.com/de-de/library/cc668201.aspx">das Routing</a> einstellen.</p> <p>&nbsp;</p><!--more--> <p><strong>ALLE Requests umleiten</strong></p> <p>Mit dem kleinen Trick ist es möglich, alle Requests zu einem Controller umzuleiten. Das kann zum Beispiel nützlich sein, wenn man sich selber um das Ausliefern einer "404-Fehler-Seite" kümmern möchte oder einfach z.B. weil gerade Wartungsarbeiten durchgeführt werden, alle Requests hart auf einen Controller umbiegen möchte.</p> <p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:fe256bf9-d7a2-4099-ad5c-6cd6a53a2271" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">            routes.MapRoute(
                "CatchAll",  
                "{*url}",               
                new { controller = "Home", action = "Index", id = "" } 
            );</pre></div></p>
<p>In Zeile 3 steckt die Magie. Natürlich müsste diese Route als erstes registriert werden, wenn wirklich alle Requests abgefangen werden sollen. Wenn andere Routen "über" dieser liegen, funktioniert das natürlich nur für Requests wo die anderen Routen nicht matchen.</p>
<p>Andere Möglichkeiten gibt es natürlich auch, aber ich fand das heute ganz interessant :) </p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/catchallroutes/catchallroute.zip">[ Download Democode ]</a></strong></p>
