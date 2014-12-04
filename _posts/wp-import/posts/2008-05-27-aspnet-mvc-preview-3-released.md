---
layout: post
title: "ASP.NET MVC Preview 3 released"
date: 2008-05-27 23:02
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [ASP.NET MVC, MVC]
language: de
---
{% include JB/setup %}
<p>Das ASP.NET Team (<a href="http://weblogs.asp.net/scottgu/archive/2008/05/27/asp-net-mvc-preview-3-release.aspx">siehe Scotts Blog</a>) hat die 3. Preview des MVC Modells zum Downloaden freigegeben:</p> <ul> <li><a href="http://www.microsoft.com/downloads/details.aspx?FamilyId=92F2A8F0-9243-4697-8F9A-FCF6BC9F66AB&amp;displaylang=en">Setup MSI Download</a></li> <li><a href="http://www.codeplex.com/Release/ProjectReleases.aspx?ProjectName=aspnet&amp;ReleaseId=13792">Sourcecode @ Codeplex</a></li></ul> <p>Die 3. Preview knüpft an den <a href="http://weblogs.asp.net/scottgu/archive/2008/04/16/asp-net-mvc-source-refresh-preview.aspx">Code Release im April</a> an und bringt eine ganze Reihe Verbesserung:</p> <ul> <li>Control Action Methods &amp; ActionResults z.B. für...</li> <ul> <li>AJAX: JsonResult</li> <li>Streaming Data: ContentResult</li> <li>Web: HttpRedirect / RedirectToAction/Route </li> <li>Dies ermöglicht sehr elegantes Unit-Testen</li></ul> <li>HTML Helper wurden verbessert</li> <li>URL Routing &amp; Mapping wurde erweitert (und ist nun Teil des .NET 3.5 SP1 für WebForms <strong>und</strong> MVC)</li></ul> <p>Was leider noch nicht enthalten ist, sind Sub-Controller, bessere AJAX Integration, Authentication, Authorization, Components - dies soll in späteren Releases nachgeschoben werden (Achtung: Zum Teil geht es hier auch um eine nettere Integration - Logingeschichten können sehr wohl mit dem <a href="http://www.codeplex.com/MvcMembership">MVC Framework gemacht werden</a>.).</p> <p>Weitere Infos einfach <a href="http://weblogs.asp.net/scottgu/archive/2008/05/27/asp-net-mvc-preview-3-release.aspx">bei Scott nachschauen</a>...</p>
