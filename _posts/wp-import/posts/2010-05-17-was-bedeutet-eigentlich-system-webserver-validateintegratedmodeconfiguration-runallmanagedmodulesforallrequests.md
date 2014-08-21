---
layout: post
title: "Was bedeutet eigentlich System.webServer -  “validateIntegratedModeConfiguration” & “runAllManagedModulesForAllRequests”"
date: 2010-05-17 00:03
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [IIS, IIS7]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image974.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb158.png" width="199" height="102" /></a> </p>  <p>Ein Kollege, der eine IIS6 Webapplikation auf IIS7 migriert, fragte mich was denn eigentlich dieses Validation Tag bedeutet. Unter ASP.NET 4.0 ist die Web.config um einiges schlanker, allerdings taucht das Validation und Modules Tag wieder auf. Was hat es mit den beiden Flags auf sich?</p> <!--more-->  <p><strong>Migration auf IIS7</strong></p>  <p>Der Post soll nur die beiden Properties beleuchten. Wer eine Migration auf von IIS6 auf IIS7 machen möchte, der sollte <a href="http://mvolo.com/blogs/serverside/archive/2007/12/08/IIS-7.0-Breaking-Changes-ASP.NET-2.0-applications-Integrated-mode.aspx">hier</a> sich genauere Informationen besorgen. </p>  <p><strong>system.webServer</strong></p>  <p>Wer eine frische ASP.NET MVC Anwendung erstellt findet in der web.config diese Konfiguration:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f91f3b93-c2f6-4e11-b5de-546215c79d81" class="wlWriterEditableSmartContent"><pre name="code" class="c#">  &lt;system.webServer&gt;
    &lt;validation validateIntegratedModeConfiguration="false"/&gt;
    &lt;modules runAllManagedModulesForAllRequests="true"/&gt;
  &lt;/system.webServer&gt;</pre></div>

<p><strong>Validation: "validateIntegratedModeConfiguration”</strong></p>

<p> Im Standardfall ist dies auf "false” gesetzt. Vor dem IIS7 hat man alle Handler &amp; Module unter "System.Web” oder irgendwo in der web.config verstreut&#160; reingeschrieben. Ab dem IIS7 wurde ein spezieller Bereich in der web.config für den Webserver eingerichtet: system.webServer. Mit dem IIS7 gibt es mehrere Möglichkeiten sich in den ASP.NET Prozess einzuklinken. Das ist der s.g. "Integrated” Mode. 
  <br />Mit dem validation Tag &amp; dem Property <a href="http://msdn.microsoft.com/en-us/library/bb422433(VS.90).aspx">validateIntegratedModeConfiguration</a> wird im Grunde nur geprüft ob die web.config vollständig richtig konfiguriert ist. Würde das Flag auf "true” stehen, würde eine Fehlermeldung kommen wenn unter in der web.config einfach so ein &lt;HttpModules&gt; stehen würde.

  <br />Da viele Anwendung aber trotzdem noch korrekt auf dem IIS6 laufen sollen und auch der interne Entwicklungsserver im Visual Studio (Cassini) auf IIS6 aufbaut, ist das Flag auf "false” gesetzt. Es wird im Grunde nur die Fehlermeldung ignoriert. </p>

<p><strong>Modules: "runAllManagedModulesForAllRequests”</strong></p>

<p>Wer auf dem IIS6 versucht hat "endunglose” URLs wie z.B. </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f442b90a-19f0-4fe6-9561-c4d824a1d5da" class="wlWriterEditableSmartContent"><pre name="code" class="c#">{{BASE_PATH}}/2010/05/16/howto-visual-studio-immer-als-admin-starten/</pre></div>

<p>Der musste entweder direkt am IIS etwas ändern oder etwas <a href="http://weblogs.asp.net/scottgu/archive/2007/02/26/tip-trick-url-rewriting-with-asp-net.aspx">rumbasteln</a>. Ähnliche Änderungen am IIS6 sind auch notwendig wenn man eine ASP.NET MVC Anwendung <a href="http://haacked.com/archive/2008/11/26/asp.net-mvc-on-iis-6-walkthrough.aspx">zum Laufen</a> bekommen will. </p>

<p>Mit dem Flag "runAllManagedModulesForAllRequests” wird der IIS nur angewiesen alle registrierten "verwalteten” Module bei jedem Request zu durchlaufen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image975.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb159.png" width="533" height="374" /></a> </p>

<p>Diese kann man pro Seite jeweils im <a href="http://learn.iis.net/page.aspx/121/iis-7-modules-overview/">IIS verwalten</a>. Das Flag ist also nur ein Shortcut um die web.config nicht unendlich aufzublähen und damit man im IIS zentral dies steuern kann.</p>

<p>Statische Dateien, wie z.B. jpegs, durchlaufen nicht diese Module. "Statische Datein” können ebenfalls im IIS verwaltet werden.</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image976.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb160.png" width="369" height="220" /></a></p>
