---
layout: post
title: "Der ASP.NET Webstack ist Open Source!"
date: 2012-03-29 00:40
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [Open Source]
---
{% include JB/setup %}
<p><a href="http://weblogs.asp.net/scottgu/archive/2012/03/27/asp-net-mvc-web-api-razor-and-open-source.aspx">ScottGu</a> und <a href="http://www.hanselman.com/blog/ASPNETMVC4ASPNETWebAPIAndASPNETWebPagesV2RazorNowAllOpenSourceWithContributions.aspx">ScottHa</a> haben es verkündet und es gab großen Beifall in der Community: Der <a href="http://aspnetwebstack.codeplex.com">ASP.NET Webstack ist Open Source</a>! Der Blogpost <a href="http://lostechies.com/jimmybogard/2012/03/28/asp-net-mvc-web-api-razor-and-open-source-and-what-it-means/">“ASP.NET MVC, Web API, Razor and Open Source and what it means”</a> von Jimmy Bogard ist auch lesenswert!</p> <p><strong>ASP.NET MVC, Razor, Web Pages und die Web API sind Open Source</strong></p> <p>Besagte Frameworks liegen <a href="http://aspnetwebstack.codeplex.com">auf Codeplex in einem Git Repository</a> mit Apache 2.0 Lizenz. Anders als bei <a href="{{BASE_PATH}}/2007/10/03/net-framework-goes-open-source/">der Offenlegung des .NET Frameworks</a> akzeptiert das Web Team ausdrücklich Code von “Nicht”-Microsoft Entwicklern.</p> <p><strong>Ändert das nun irgendwas?</strong></p> <p>Alle Frameworks werden weiterhin von Microsoft supportet und haben entsprechende Teams dahinter. Für 99.9% der jetzigen ASP.NET Entwickler ändert sich mit der Offenlegung als Open Source nichts, aber für die restlichen 0.1% gibt es nun die Chance Bugs oder Features evtl. selber zu patchen und Microsoft zu schicken. Natürlich ist es auch für die Transparenz sehr hilfreich, wenn man sieht woran gearbeitet wird. Man kann die Änderungen <a href="http://aspnetwebstack.codeplex.com/SourceControl/list/changesets">welche zuletzt von den Entwicklern eingecheckt wurden</a> <a href="http://aspnetwebstack.codeplex.com/SourceControl/list/changesets">hier</a> sehen.</p> <p><strong>Was ist mit ASP.NET WebForms?</strong></p> <p>ASP.NET WebForms schlummert in der System.Web.dll und hat einige Abhängigkeiten zu Komponenten, welche noch nicht in diesem offenen Modell bearbeitet werden können.&nbsp;&nbsp; </p> <p><strong>Erste Schritte:</strong></p> <p>Um den Source Code sich runterzuholen benötigt man Git. Auf der Codeplex Seite sind einige Clients für Windows empfohlen (wie man mit <a href="{{BASE_PATH}}/2011/08/05/einstieg-in-git-fr-net-entwickler/">Git anfängt hab</a> ich auch mal geschrieben) Danach einfach ein</p><pre>git clone https://git01.codeplex.com/aspnetwebstack.git</pre>
<p>und schon hat man die Sourcen samt Tests:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1483.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb654.png" width="492" height="122"></a></p>
<p>Als erstes muss man dann per CMD diesen Befehl im root Verzeichnis der Sourcen ausführen:</p><pre>build RestorePackages
build</pre>
<p>Dies lädt einige NuGet Packages runter und baut die Solution.</p>
<p>Um die Tests auszuführen benötigt man noch ein kleines Tool “<a href="http://www.codeplex.com/Download?ProjectName=aspnetwebstack&amp;DownloadId=360565">SkipStrongNames</a>”, damit man gegen die signierten Assemblies testen kann.</p>
<p><strong>Die Solution im Visual Studio:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1484.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 5px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb655.png" width="261" height="712"></a></p>

<p>Aktuell gibt es wohl aber noch Probleme beim Bauen wenn man die .NET 4.5 Preview samt MVC4 installiert hat. Auch einige Tests laufen bei mir nicht. In den <a href="http://aspnetwebstack.codeplex.com/discussions/topics/5323/general">Diskussionforen</a> auf Codeplex findet man einige solcher Sachen. </p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><strong>In diesem Sinne: Wer Bugs findet… der macht ein Unit-Test und schickt ein Pull Request! ;)</strong></p>
