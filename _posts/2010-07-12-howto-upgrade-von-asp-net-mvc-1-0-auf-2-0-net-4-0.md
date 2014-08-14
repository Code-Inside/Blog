---
layout: post
title: "HowTo: Upgrade von ASP.NET MVC 1.0 auf 2.0 & .NET 4.0"
date: 2010-07-12 23:19
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo]
---
<p><a href="{{BASE_PATH}}/assets/wp-images/image1001.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb185.png" width="108" height="106" /></a>Wir hatten vor kurzem eine Umstellung einer ASP.NET MVC 1.0 Anwendung, welche unter .NET 3.5 lief, auf ASP.NET MVC 2 mit .NET 4.0 vollzogen. Hier ein paar kleine Anmerkungen dazu.</p>  <p>&#160;</p> <!--more-->  <p>Sobald mit mit VS2010 eine Solution öffnet, welche mit VS2008 erstellt wurde und unter .NET 3.5 oder älter läuft, kommt sofort der Konvertierungswizard und fragt ob man auch die .NET Framework Version 4.0 haben möchte.</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1002.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb186.png" width="485" height="381" /></a> </p>  <p>Nach der Konvertierung wurden auch automatisch die MVC 2 dlls hinzugefügt. Für <strong>VS 2008</strong> gibt es auch einen <a href="http://weblogs.asp.net/leftslipper/archive/2009/10/19/migrating-asp-net-mvc-1-0-applications-to-asp-net-mvc-2.aspx">Konverter</a>, weil man diverse Änderungen in den web.configs machen muss.</p>  <p><strong>MvcHtmlString</strong></p>  <p>Die Helper im MVC 2 geben nun ein <a href="http://msdn.microsoft.com/en-us/library/system.web.mvc.mvchtmlstring.aspx">MvcHtmlString</a> anstatt eines einfachen Strings zurück. Das kann z.B. <a href="http://stackoverflow.com/questions/2382942/mvchtmlstring-mvc-2-conversion-error">beim ActionLink Helper zu Problemen</a> führen, da der MvcHtmlString nicht die Methoden eines normalen Strings enthält (z.B. Substring)</p>  <p><strong>ValueProvider</strong></p>  <p>Der Zugriff auf die ValueProvider ist jetzt anders geregelt. War vorher der Zugriff so:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:51731c35-d551-4f30-9978-e35d3989fddc" class="wlWriterEditableSmartContent"><pre name="code" class="c#">ViewContext.Controller.ValueProvider["Bla"].AttemptedValue</pre></div>

<p>So ist er nun so:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:72f98e37-505e-4eb4-aa96-a3088c1cfd20" class="wlWriterEditableSmartContent"><pre name="code" class="c#">ViewContext.Controller.ValueProvider.GetValue("Bla").AttemptedValue</pre></div>

<p>&#160;</p>

<p></p>

<p><strong>Render View To String</strong></p>

<p>In einem <a href="http://code-inside.de/blog/2010/01/29/howto-excel-export-mit-asp-net-mvc-und-render-view-to-string/">HowTo</a> ging es darum, wie man das Ergebnis eines Views als String zurückbekommt um dies z.B. für Email-Templates zu verwenden.

  <br />In diesem <a href="http://stackoverflow.com/questions/483091/render-a-view-as-a-string">Stackoverflow Thread</a> gibts auch eine MVC 2 kompatible Lösung.</p>

<p><strong>RedirectToAction&lt;&gt;</strong></p>

<p>Auch im neuen MVC 2 Framework gibt es kein streng typisiertes RedirectToAction. Dies befindet sich wieder in den <a href="http://aspnet.codeplex.com/wikipage?title=MVC&amp;referringTitle=Home">Futures</a>. </p>

<p><strong>Für das Deployment</strong></p>

<p>Wichtig ist natürlich auch, dass im <a href="http://code-inside.de/blog/2010/04/29/howto-net-4-0-asp-net-mvc-on-iis-7-5-pagehandlerfactory-integrated-has-a-bad-module-managedpipelinehandler/">IIS alles richtig konfiguriert ist</a>.</p>

<p><strong>Mehr Schwierigkeiten sind uns jedenfalls nicht aufgetreten - happy upgrading :)</strong></p>
