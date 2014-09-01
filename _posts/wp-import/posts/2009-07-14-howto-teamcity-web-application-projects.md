---
layout: post
title: "HowTo: TeamCity & Web Application Projects"
date: 2009-07-14 22:33
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Build, Build Server, How, TeamCity, Visual Studio, Web Applicaiton Projects]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image802.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 10px 0px 0px; border-right-width: 0px" height="113" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb780.png" width="167" align="left" border="0"></a>TeamCity ist ein sehr nette <a href="{{BASE_PATH}}/2009/07/14/howto-continuous-integration-mit-teamcity/">Build- &amp; CI-Lösung</a>. Wenn man allerdings ein Web Application Project in seiner Solution hat (z.B. ein ASP.NET MVC Projekt), wird es wahrscheinlich erstmal nicht bauen, weil ein MSBuild "Target" nicht ausgeführt wird. Mit einem <a href="http://odetocode.com/Blogs/scott/archive/2006/05/30/3802.aspx">kleinen Trick</a> geht auch dies.</p><p><strong>.csproj - MSBuild</strong></p> <p>Wer mal ein Blick in eine Projektdatei geworfen hat, wird feststellen, dass dies eine XML Datei ist. Was man vor sich sieht ist <a href="http://msdn.microsoft.com/de-de/library/wea2sca5.aspx">MSBuild</a>. Dort stehen für das bauen verschiedenste Anweisungen drin.</p> <p><strong>Web Application Projects</strong></p> <p>Wenn man ein "Web Application Project" hat, z.B. eine ASP.NET MVC Anwendung oder eine andere ASP.NET Anwendung, dann wird u.a. automatisch ein "Target" in der Projektdatei verlinkt:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:703c8e98-834a-4b74-934b-ec0228baf9cb" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">  &lt;Import Project="$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v9.0\WebApplications\Microsoft.WebApplication.targets" /&gt;</pre></div>
<p><strong>TeamCity / Build Server + Web Application Projects</strong></p>
<p>Wenn man diese Projektdatei nun mit bei einem Build Server nutzen kann, muss dieses target auch auf dem Build Server vorhanden sein. Dazu muss man zwei Datein von dem Entwicklerrechner auch auf dem Build Server kopieren:</p>
<ul>
<li>Microsoft.WebApplication.Build.Tasks.Dll 
<li>Microsoft.WebApplication.targets</li></ul>
<p>Beide befinden sich (standardmäßig) unter diesem Pfad:</p>
<p><em>C:\Program Files\MSBuild\Microsoft\VisualStudio\v9.0\WebApplications</em></p>
<p>Damit nun auch das bauen mit dieser Projektdatei klappt, muss derselbe Pfad mit den beiden Datein auch auf den Build Server vorhanden sein.</p>
