---
layout: post
title: "ASP.NET MVC 3: Wenn sich die FormsAuthentication.LoginUrl nicht ändern lässt…"
date: 2011-05-11 23:54
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET MVC 3]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1276.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb458.png" width="143" height="148" /></a> </p>  <p>Über das <a href="http://msdn.microsoft.com/en-us/library/1d3t3c61.aspx">Forms-Tag in der Web.config</a> einer ASP.NET Anwendung kann man die FormsAuthentication konfigurieren. Darunter gehört z.B. &quot;Lebensdauer” des FormsAuth Cookie oder die LoginURL.</p>  <p>Seltsamerweise wurde die Änderung der LoginURL bei mir ignoriert - leider kann ich es auch nicht nachstellen (warum auch immer), aber wie ich gelernt habe: Es ist ein "<a href="http://www.asp.net/learn/whitepapers/mvc3-release-notes#0.1__Toc274034230">Known Issue</a>” in ASP.NET MVC 3. Die Behebung ist auch recht trivial...</p> <!--more-->  <p><strong>Folgende Einstellungen wurden gemacht:</strong></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a278d7c5-2779-44b7-b773-02e18431c2a5" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    &lt;authentication mode="Forms"&gt;
      &lt;forms loginUrl="~/Acc/CustomUrl" timeout="2880" /&gt;
    &lt;/authentication&gt;</pre></div>

<p>Wenn aus unerfindlichen Gründen die loginUrl ignoriert wird und immer die Standard-Login-Url (~/Account/LogOn) genutzt wird, dann hatte folgende AppSettings Einstellungen geholfen:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:99e02fbd-01b7-43de-90e6-a687ac6251d4" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;appSettings&gt;
  &lt;add key="enableSimpleMembership" value="false" /&gt;
  &lt;add key="autoFormsAuthentication" value="false" /&gt;
&lt;/appSettings&gt;</pre></div>

<p>Magic-Appsettings: FTL. :(</p>

<p>Danke an <a href="http://twitter.com/#!/philipproplesch/statuses/67587279887138816">Philip Proplesch für den Tipp</a>!</p>
