---
layout: post
title: "Fix: .NET 4.0 ASP.NET MVC on IIS 7.5 &quot;PageHandlerFactory-Integrated&quot; has a bad module &quot;ManagedPipelineHandler&quot;"
date: 2010-04-29 00:09
author: robert.muehsig
comments: true
categories: [Fix, HowTo]
tags: [.NET 4.0, ASP.NET MVC, HowTo, IIS, IIS 7.5, MVC]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image954.png"><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb139.png" width="244" height="104" /></a>Wer .NET 4.0 und ASP.NET MVC (und wahrscheinlich viele weitere ASP.NET Beispiele/Frameworks) nutzen möchte, der muss eine kleine Sache beachten: Man muss .NET 4.0 am IIS installieren, ansonsten quittiert der IIS es mit&#160; engl. "Internal Server Error Handler &quot;PageHandlerFactory-Integrated&quot; has a bad module &quot;ManagedPipelineHandler&quot; in its module list”</p>  <p></p>  <p></p>  <p><strong>"Der Handler &quot;PageHandlerFactory-Integrated&quot; weist das ungültige Modul &quot;ManagedPipelineHandler&quot; in der Modulliste auf.” (dt.)</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images-de/image955.png"><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb140.png" width="244" height="170" /></a> <strong>1.</strong> Sicherstellen dass die Website unter .NET 4.0 läuft (siehe z.B. Default Website -&gt; Erweiterte Einstellungen -&gt; schauen ob der <strong>ASP.NET v4.0 AppPool</strong> ausgewählt ist).</p>  <p><strong>2.</strong> In der <strong>CMD ASP.NET 4.0 installieren</strong>: </p>  <p><strong>Für 64bit:</strong></p>  <p>C:\Windows\Microsoft.NET\Framework64\v4.0.30128\aspnet_regiis.exe -ir</p>  <p><strong>Für 32bit:</strong></p>  <p>C:\Windows\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe -ir</p>
