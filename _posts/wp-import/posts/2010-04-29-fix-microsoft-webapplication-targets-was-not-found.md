---
layout: post
title: "Fix: “Microsoft.WebApplication.targets was not found.”"
date: 2010-04-29 22:43
author: robert.muehsig
comments: true
categories: [Fix]
tags: [Build, MSBuild, TFS, WebApplications]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image962.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb147.png" width="174" height="157" /></a>Wer mit MSBuild Webapplikationen baut (z.B. im Zusammenhang mit dem TFS 2008/2010) kann u.U. folgende Fehlermeldung erhalten:    <br />"The imported project C:\Program Files (x86) \MSBuild\Microsoft\VisualStudio\ v10.0\WebApplications\ Microsoft.WebApplication.targets was not found.”. Einfachste Problemlösung: Visual Studio 2010/2008 installieren.</p>  <p><u>Vor der .NET 4.0 Zeit:</u> "The imported project &quot;C:\Program Files\MSBuild\Microsoft\VisualStudio\<strong>v8.0</strong>\WebApplications\Microsoft.WebApplication.targets&quot; was not found” </p>  <p><u>Wer mit .NET 4.0 baut:</u> "The imported project &quot;C:\Program Files\MSBuild\Microsoft\VisualStudio\<strong>v10.0</strong>\WebApplications\Microsoft.WebApplication.targets&quot; was not found”</p>  <p><strong>Einfachste Fehlerbehebung:</strong> Visual Studio auf dem Build Server installieren.</p>  <p><strong>Eine andere Variante:</strong> Einfach den WebApplications Ordner mit Inhalt (ein .target File + dll) kopieren. </p>  <p>Im Zusammenhang mit TeamCity ist mir dieser "Bug” <a href="{{BASE_PATH}}/2009/07/14/howto-teamcity-web-application-projects/">bereits aufgefallen</a>. Mit dem neuen TFS2010 hat sich das auch nicht geändert, daher der "nochmalige” Blogpost.</p>
