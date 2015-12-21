---
layout: page
title: "HowTo: Microsoft ASP.NET AJAX (Grundlagen)"
date: 2007-05-30 18:33
author: Robert Muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-microsoft-aspnet-ajax-grundlagen
---
{% include JB/setup %}
Da ich mich momentan mit einem Neuentwurf von <a target="_blank" href="http://shoppingmap.de" title="Shoppingmap">ShoppingMap</a> beschäftige, will ich natürlich auch etwas Web 2.0 mit reinbringen. Da ich mich mehr oder weniger auf Microsoft Produkte eingeschossen habe, bleib ich ASP.NET treu und verwende dazu ebenfalls noch die AJAX Extensions und das Toolkit von Microsoft.

<a target="_blank" href="http://de.wikipedia.org/wiki/Ajax_(Programmierung)" title="Wikipedia AJAX">AJAX</a> allg. möchte ich hier jetzt nicht erklären. Dafür gibt es neben dem Wiki Artikel noch genug andere Leitfäden.

Die Hauptadresse wenn es um ASP.NET geht ist natürlich Microsofts <a target="_blank" href="http://asp.net" title="MS ASP.NET">ASP.NET Website</a>.

Ein paar kurze Sätz zu ASP.NET: Es ist die serverseitige Programmiersprache, welche in der <a target="_blank" href="http://de.wikipedia.org/wiki/.NET" title="Wiki .NET">.NET </a>Welt für Websites und Webservices zum Einsatz kommt. Webserver für ASP.NET ist meist der <a target="_blank" href="http://de.wikipedia.org/wiki/Microsoft_Internet_Information_Services" title="Wiki IIS">IIS von Microsoft</a>. <a target="_blank" href="http://www.mono-project.com/Main_Page" title="Open Source .NET">Das Mono-Projekt </a>hat aber glaub ich auch ein Webserver (Apache?) so umgestaltet, dass er auch für ASP.NET Seiten eingesetzt werden kann.

Nun zum eigentlichen Thema: AJAX in der ASP.NET Welt. Hauptadresse ist hier <a target="_blank" href="http://ajax.asp.net" title="MS AJAX">ajax.asp.net</a>. Um es schnell einzusetzen ist es ratsam sich einfach das kostenlose <a target="_blank" href="http://www.microsoft.com/germany/msdn/vstudio/products/express/vwd/default.mspx" title="Visual Web Developer">Visual Web Developer</a> oder dem für .NET Entwickler vermutlich bekannten Visual Studio.
Früher hieß das AJAX Framework für ASP.NET "Atlas", allerdings hat Microsoft dieses "Framework" in zwei Teile geteilt:

- <a target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyID=ca9d90fa-e8c9-42e3-aa19-08e2c027f5d6&amp;displaylang=en" title="ASP.NET AJAX">ASP.NET AJAX Extensions</a>:
Mit dem Download werden die ASP.NET Anwendungen eigentlich erst mit der ASP.NET Funktionalität ausgestattet. Für andere Plattformen (PHP z.B.) gibt es eine <a target="_blank" href="http://ajax.asp.net/downloads/library/default.aspx?tabid=47&amp;subtabid=471" title="JS Bibliothek">Java Script Bibliothek zum runterladen </a>- diese hab ich allerdings nicht getestet und kann auch nichts dazu sagen.

- <a target="_blank" href="http://www.codeplex.com/AtlasControlToolkit/Release/ProjectReleases.aspx?ReleaseId=1425" title="AJAX Control Toolkit @ Codeplex">ASP.NET AJAX Toolkit</a>:
Das Toolkit ergänzt einge neue nette Controls welche nicht immer was mit AJAX direkt zutun haben. Es sind kleine, aber nützliche Kontrols, z.B. eine Autocomplete Box (wie z.B. bei Google Suggest zu sehen). Diese müssen nicht runtergeladen werden, können aber und ich würde es auch empfehlen.

Nachdem beides runtergeladen und installiert ist, hat man in seinem Visual Studio/Web Developer ein paar neue Vorlagen welche bereits die AJAX Funktionalität und das Toolkit bereits beinhalten.

Für das Toolkit ist <a target="_blank" href="http://ajax.asp.net/ajaxtoolkit/" title="ASP.NET AJAX Toolkit">diese Seite</a> sehr interessant - im Prinzip werden dort alle wesentlichen Controls gezeigt. Die komplette Seite kann man von <a target="_blank" href="http://www.codeplex.com/Wiki/View.aspx?ProjectName=AtlasControlToolkit" title="Codeplex - AJAX Toolkit">Codeplex</a> ebenfalls runterladen.

 Dokumentation &amp; Videos zu dem ganzen AJAX ASP.NET Thema befinden sich auf <a target="_blank" href="http://ajax.asp.net/documentation/default.aspx?tabid=47" title="ASP.NET AJAX Docs">dieser Seite</a>.
    - <a target="_blank" href="http://ajax.asp.net/docs/" title="AJAX Docs">Direkt Link zur Dokumentation</a>
    - <a target="_blank" href="http://www.asp.net/learn/videos/default.aspx?tabid=63" title="ASP.NET Videos">Direkt Link zu den How-Do-I Lern Videos</a>

Ein kurzer Kommentar noch, weil ich damit arge Probleme bei dem Toolkit hatte:
Verwendet beim Entwickeln einer Website immer "position: relative". Ansonsten kann es manchmal zu Problemen bei manchen Controls kommen.

Ausblick: Wenn ich mal sehr viel Zeit habe, werd ich näheres zu den eigentlichen Controls schreiben. Leider ist das Toolkit sehr "undokumentiert" - das Webprojekt zum Runterladen beantwortet auch nicht immer alle Fragen.

Soviel erstmal dazu.

<a href="{{BASE_PATH}}/artikel/howto-microsoft-aspnet-ajax-praktischer-anfang/" title="ASP.NET AJAX Praktischer Anfang">[Weiter zu Teil 2...]</a>
