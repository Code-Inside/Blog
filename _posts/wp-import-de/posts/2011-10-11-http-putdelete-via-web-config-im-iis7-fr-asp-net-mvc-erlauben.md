---
layout: post
title: "Http PUT/DELETE via Web.config im IIS7 für ASP.NET MVC erlauben"
date: 2011-10-11 01:04
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [DELETE, HowTo, IIS, PUT, REST]
language: de
---
{% include JB/setup %}
<p>Im Standardfall erlaubt der IIS keine Requests mit den HTTP Verben PUT &amp; DELETE. Diese sind allerdings in einer <a href="http://en.wikipedia.org/wiki/Representational_state_transfer">REST</a> Welt pflicht. Man kann nun im IIS rumdoktern und dort die beiden Verben aktivieren, allerdings habe ich solche Sachen als Entwickler lieber selbst in der Hand als dem Admin ein Handbuch zu schreiben ;)</p> <p>Ziel ist es also, HTTP PUT &amp; Delete über die Web.config zu aktivieren.</p> <p><strong>Web.config</strong></p> <p>Unter dem Konfigurationspunkt system.webServer können die entsprechenden Einstellungen gemacht werden:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a6739e4c-8082-4ee0-a223-92add6af02bf" class="wlWriterEditableSmartContent"><pre name="code" class="c">  &lt;system.webServer&gt;
    ...
    &lt;modules runAllManagedModulesForAllRequests="true"&gt;
      &lt;remove name="WebDAVModule" /&gt;
	  ...
    &lt;/modules&gt;
    &lt;validation validateIntegratedModeConfiguration="false" /&gt;
    &lt;handlers&gt;
      &lt;remove name="WebDAV" /&gt;
      &lt;remove name="ExtensionlessUrlHandler-Integrated-4.0"/&gt;
      &lt;add name="ExtensionlessUrlHandler-Integrated-4.0" path="*." verb="GET,HEAD,POST,DEBUG,PUT,DELETE" modules="IsapiModule" scriptProcessor="C:\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_isapi.dll" resourceType="Unspecified" requireAccess="Script" preCondition="classicMode,runtimeVersionv4.0,bitness64" responseBufferLimit="0" /&gt;
      ...
    &lt;/handlers&gt;
  &lt;/system.webServer&gt;</pre></div>
<p>&nbsp;</p>
<p><strong>Erklärung:</strong></p>
<p>Wir entfernen den “ExtensionlessUrlHandler” (wenn die Anwendung im Integrated Modus läuft, dann ist es der ExtensionlessUrlHanler-Integrated – später dazu noch mehr) und fügen ihn darauf neu hinzu und erlauben neben den GET, HEAD, POST Verben noch PUT und DELETE. Ohne das entfernen, wäre der Eintrag zwei mal drin und der IIS würde eine Fehlerseite generieren.</p>
<p><strong>Warum das entfernen von dem WebDav Modul wichtig ist</strong></p>
<p>Wenn auf dem IIS noch das WebDav Feature aktiviert ist, dann muss man es für diese Seite deaktivieren, weil sowohl WebDav als auch unser eigentlicher REST Service sprechen auf dieselben Verben an. </p>
<p><strong>Zu den Handlern</strong></p>
<p>In meinem Fall habe ich nur den Handler, welcher für die “extensionless” Sachen notwendig ist freigeschalten. Alle Handler einer Webanwendung können im IIS unter Handler Mappings betrachtet werden:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1373.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb555.png" width="616" height="324"></a></p>

<p>Unter den Details können auch die “Request Restrictions” betrachtet werden:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1374.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb556.png" width="600" height="365"></a></p>
<p>Bei mir hat es jedenfalls mit der web.config Einstellung geklappt ;)</p>
<p>Als Abschluss noch der Hinweis für alle die sich fragen “Was ist eigentlich der Unterschied zwischen einem Modul und einem Handler?” – <a href="{{BASE_PATH}}/2010/08/09/unterschied-von-httpmodule-httphandler/">Hier die Antwort</a>.</p>
