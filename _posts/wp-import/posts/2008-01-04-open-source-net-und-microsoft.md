---
layout: post
title: "Open Source, .NET und Microsoft"
date: 2008-01-04 11:16
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [.NET, Microsoft, Open Source]
---
{% include JB/setup %}
Open Source ist sicherlich eines der großen Themen 2007 gewesen und wird auch 2008 nicht minder erfolgreich sein. Wenn es allerdings um .NET geht, denken die wenigsten an Open Source. PHP, Java oder C++ sind meist die Wahlsprachen der Open Sourceler - meine Vermutung ist, dass Open Source in Verbindung mit einem Microsoft Produkt kaum vorstellbar ist.

Dass es aber tatsächlich sehr interessante Open Source .NET Projekte in den verschiedensten Bereichen gibt und sogar Microsoft langsam auf Open Source zugeht, möchte ich hier zeigen.

<strong>.NET Open Source Projekte</strong>

<strong> <u>Paint.NET - Fotobearbeitung</u></strong>

Angefangen möchte ich mit dem wohl bekanntesten .NET Programm in dieser Liste: <a target="_blank" href="http://www.getpaint.net/download.html">Paint.NET</a>

<a href="{{BASE_PATH}}/assets/wp-images/image206.png"><img border="0" width="302" src="{{BASE_PATH}}/assets/wp-images/image-thumb185.png" alt="image" height="183" style="border: 0px" /></a>

Paint.NET ist eines der wenigen .NET Open Source Projekte, welche auch der normale Endkunde nutzen kann.

Kommen wir nun zu den anderen - nicht Endkundentauglichen - Projekten:

<u><strong>SubSonic - .NET O/R Mapper für MySQL, Oracle, SQL Server</strong></u>

<a href="{{BASE_PATH}}/assets/wp-images/image207.png"><img border="0" width="244" src="{{BASE_PATH}}/assets/wp-images/image-thumb186.png" alt="image" height="47" style="border: 0px" /></a>

<a target="_blank" href="http://www.subsonicproject.com/">SubSonic</a> ist ein sehr schickes "Toolset", wenn es darum geht, eine Objektstruktur aus einer Datenbankstruktur zu bekommen. Auch die ganzen CRUD Befehle kann man sich hier sparen. Auf der Website gibt es auch <a target="_blank" href="http://www.subsonicproject.com/view/for-web-sites---using-the-buildprovider.aspx">ein guten Einstieg</a> (mit <a target="_blank" href="http://www.wekeroad.com/ss_setup2.html">Video</a>) in SubSonic und die <a target="_blank" href="http://www.subsonicproject.com/view/api-documentation.aspx">API Dokumentation</a>. Begonnen wurde das Projekt von Rob Conery, der nun für Microsoft am ASP.NET MVC Modell arbeit.

<u><strong>NHibernate - .NET O/R Mapper</strong></u>

<a href="{{BASE_PATH}}/assets/wp-images/image208.png"><img border="0" width="244" src="{{BASE_PATH}}/assets/wp-images/image-thumb187.png" alt="image" height="60" style="border: 0px" /></a> 

Ähnlich wie SubSonic, ist <a target="_blank" href="http://www.hibernate.org/343.html">NHibernate</a> ein anderer O/R Mapper. Das Konzept ist hier etwas anders (per XML wird dieser konfiguriert), allerdings ist Hibernate schon lange im Java Umfeld genutzt und NHibernate die Portierung auf .NET.

<u><strong>CruiseControl.NET - Continous Integration Server</strong></u>

<a href="{{BASE_PATH}}/assets/wp-images/image209.png"><img border="0" width="244" src="{{BASE_PATH}}/assets/wp-images/image-thumb188.png" alt="image" height="52" style="border: 0px" /></a>

Um Builds und co. in einem Team besser im Auge zu behalten ist das Stichwort "<a target="_blank" href="http://en.wikipedia.org/wiki/Continuous_integration">Continuous integration</a>" - also das automatische bauen der gesamten Solutions mit Tests etc. - sehr wichtig. <a target="_blank" href="http://confluence.public.thoughtworks.org/display/CCNET/Welcome+to+CruiseControl.NET">CruiseControl.NET</a> setzt hier ein und definiert sich selber als ein "Automated Continuous Integration server"

<u><strong>DotNetNuke - CMS</strong></u>

<a href="{{BASE_PATH}}/assets/wp-images/image210.png"><img border="0" width="244" src="{{BASE_PATH}}/assets/wp-images/image-thumb189.png" alt="image" height="70" style="border: 0px" /></a>

<a target="_blank" href="http://www.dotnetnuke.com/">DotNetNuke</a> ist eine Portierung von <a target="_blank" href="http://phpnuke.org/">PHPNuke</a> und basiert auf ASP.NET 2.0. Wie bereits PHPNuke ist dieses Projekt ein CMS für Web Portale, welches eine aktive Nutzerschaft verfügt und auch viele Module anbietet.

<u><strong>Subtext - Blog System</strong></u>

<a href="{{BASE_PATH}}/assets/wp-images/image211.png"><img border="0" width="183" src="{{BASE_PATH}}/assets/wp-images/image-thumb190.png" alt="image" height="67" style="border: 0px" /></a>

<a target="_blank" href="http://www.subtextproject.com/">Subtext</a> ist ein ASP.NET Blog System. Interessant ist aber hier, dass MySpace China eine <a target="_blank" href="http://haacked.com/archive/2007/10/29/subtext-powers-myspace-china-blogs.aspx">modifizierte Version von Subtext</a> für ihr Blogsystem nutzt.

<u><strong>DasBlog - Blog System</strong></u>

<a href="{{BASE_PATH}}/assets/wp-images/image212.png"><img border="0" width="116" src="{{BASE_PATH}}/assets/wp-images/image-thumb191.png" alt="image" height="98" style="border: 0px" /></a>

Ein anderes ASP.NET Blog System ist <a target="_blank" href="http://www.dasblog.info/">DasBlog</a>.

<strong><u>DotNetKicks - Post Voting System</u></strong>

<a href="{{BASE_PATH}}/assets/wp-images/image213.png"><img border="0" width="244" src="{{BASE_PATH}}/assets/wp-images/image-thumb192.png" alt="image" height="27" style="border: 0px" /></a>

<a target="_blank" href="http://www.dotnetkicks.com/">DotNetKicks</a> ist eine Plattform ähnlich wie <a target="_blank" href="http://digg.com/">Digg.com</a>. Da man solche Plattformen im Prinzip auf jedes Thema ausdehnen kann, ist es für den einen oder anderen bestimmt interessant, dass <a target="_blank" href="http://code.google.com/p/dotnetkicks/">DotNetKicks Source Code</a> offen gelegt wurde.

<strong><u>AForge.NET - C# Framework für Bildbearbeitung, Neuronale Netze, künstliche Intelligenz...</u></strong>

Das letzte Projekt hier ist etwas anders geartet - dafür aber umso interessanter. <a target="_blank" href="http://code.google.com/p/aforge/">AForge.NET</a> ist ein Framework für Bildbearbeitung/-manipulation, Neuronale Netze usw. (besser ihr lest selber nach, um was es sich dabei handelt ;) ).

Wo man sowas praktisch einsetzen kann, ist bei diesem CodeProject Artikel beschrieben: <a target="_blank" href="http://www.codeproject.com/KB/audio-video/Motion_Detection.aspx">Motin Detection</a>

<strong><u>Fazit</u></strong>

Es gibt sehr viele .NET Open Source Projekte und diese hier waren nur ein Teil davon. Interessierte Entwickler sollten sich den einen oder anderen Source Code mal anschauen.

<strong>... und wo bewegt sich Microsoft?</strong>

Vor einigen Wochen hat <a target="_blank" href="http://code-inside.de/blog/2007/10/03/net-framework-goes-open-source/">Scott Guthrie in seinem Blog</a> berichtet, dass der Source Code des .NET Frameworks nach und nach veröffentlicht werden soll. Allerdings hat es Microsoft letztes Jahr wohl nicht mehr geschafft die Infrastruktur aufzubauen. In Micheals Schwarz seinem Blog wird gezeigt, was später möglich sein wird: <a target="_blank" href="http://weblogs.asp.net/mschwarz/archive/2007/12/19/debug-net-source-code.aspx">Debug .NET Source Code</a>.

Die Veröffentlichung ist ein großer Schritt für Microsoft. Microsoft hat dazu einige <a target="_blank" href="http://www.microsoft.com/resources/sharedsource/licensingbasics/sharedsourcelicenses.mspx">"Shared Source" Lizenzen</a> veröffentlicht, darunter ist die "Microsoft Public Licence" auch <a target="_blank" href="http://blogs.guardian.co.uk/technology/2007/10/17/osi_approves_microsofts_open_source_licences.html">offiziel von der OSI als Open Source Lizenz abgesegnet wurden</a>. Mit <a target="_blank" href="http://codeplex.com/">CodePlex</a> hat Microsoft seine eigene Open Source Project Hosting Plattform geschaffen.

Bereits im letzten Jahr hat Microsoft zudem den Source Code für die <a target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyID=EF2C1ACC-051A-4FE6-AD72-F3BED8623B43&amp;displaylang=en">ASP.NET AJAX Extensions freigegeben</a>.

Insgesamt scheint Microsoft langsam in die Richtung Open Source zu gehen - das es zum Teil "aus Zwang" ist, da der Markt es fordert ist die eine Seite, auf der anderen Seite findet man aber in vielen MS Mitarbeiter Blogs viel positives über den Open Source Gedanken.

<strong>Open Source, .NET und Microsoft - geht doch</strong>

Auch wenn der Firmenlenker von Microsoft desöfteren etwas abfällige Kommentare über Open Source gemacht hat (und bestimmt weiter macht), wird es wohl immer mehr Open Source in der Welt geben. In der .NET Welt gibt es schon einige gute Open Source Projekte und das Microsoft sich auch langsam für Open Source erwärmt, zeigt, dass Open Source nicht immer gegen Microsoft gerichtet sein muss.

<em>(Die Logos die hier verwendet wurden, sind Eigentum der jeweiligen Urheber (siehe Links zu den jeweiligen Seiten).)</em>
