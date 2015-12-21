---
layout: post
title: "ASP.NET MVC & Web Client Software Factory (WCSF)"
date: 2007-11-20 23:26
author: Robert Muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET, MVC, Software Factories, WCSF]
language: de
---
{% include JB/setup %}
Als ich mich mit den <a target="_blank" href="{{BASE_PATH}}/artikel/howto-microsoft-patterns-practices-software-factories-verstehen/">Software Factories von Microsoft</a> beschäftigt hab, viel mir auch die "Web Client Software Factory" auf. Da ich von der <a target="_blank" href="{{BASE_PATH}}/artikel/howto-microsoft-pp-web-service-factory-service-factory-teil-3-praktisches-hello-world/">Service Factory</a> doch sehr angetan war, wollte ich mir diese Factory mal genauer anschauen.

Zur selben Zeit ungefähr hat Scott Guthrie dann das <a target="_blank" href="http://weblogs.asp.net/scottgu/archive/2007/10/14/asp-net-mvc-framework.aspx">ASP.NET MVC Modell angekündigt</a> - daher war eine ganz einfache Frage: Wenn die WCSF bereits ein ähnliches Modell unterstützt - wie gehts dann weiter? Neben dem MVC basierden Design, bietet das ASP.NET MVC Modell ja <a target="_blank" href="http://weblogs.asp.net/scottgu/archive/2007/10/14/asp-net-mvc-framework.aspx">noch mehr Vorteile</a>.

Auf Codeplex findet man für das ASP.NET MVC Thema bereits eine <a target="_blank" href="http://www.codeplex.com/websf/Thread/View.aspx?ThreadId=16460">kleine Diskussion</a>, die schon eine Weile nicht mehr weitergeführt wird.
Entwickler die bereits Erfahrungen mit WCSF gemacht haben, können natürlich ohne große Bedenken weiterentwickeln, aber Glenn Block hat es gut <a target="_blank" href="http://blogs.msdn.com/gblock/archive/2007/10/07/alt-net-headline-mvc-for-asp-net-is-coming.aspx">in seinem Blog</a> zusammengefasst:
<blockquote>What about WCSF? Well the simple answer is at this point in time we don't have one :) However as we are committed to aligning to the platform, we will be working closely with the MVC.NET guys to see what a WCSF / MVC world looks like. Many of the capabilities we provide in WCSF like Dependency Injection, Separation of logic, appear to be inherent in MVC. As this is an add on to ASP.NET and not a replacement, I can assure you this is not another case of Acropolis. WCSF will be here for a long time.</blockquote>
Ich habe erstmal abstand von den Service Factories für Smart Clients (WPF Anwendungen sind möglich, ist aber wohl nur "getricksts" bzw. einige WPF Features werden einfach nicht verwendet) sowie für Web Client genommen, werde mich aber Überraschen lassen, was ein zukünfigtes "Acropolis" noch so kann und wie es bei der WCSF weitergeht.
