---
layout: page
title: "HowTo: Microsoft ASP.NET AJAX (Praktischer Anfang)"
date: 2007-07-04 10:27
author: robert.muehsig
comments: true
categories: []
tags: []
---
{% include JB/setup %}
Nun da die Grundlagen bereits beschrieben sind, möchten ich den praktischen Teil angehen.

Unser Ziel ist es eine einfache ASPX Seitee zu bauen, welche mit tollen AJAX Effekten glänzt. Dazu wollen wir auch das <a target="_blank" href="http://www.codeplex.com/AtlasControlToolkit/Release/ProjectReleases.aspx?ReleaseId=4923" title="AJAX Control Toolkit">Control Toolkit</a> nehmen.

<strong>Schritt 1: Grundlagen beachten</strong>

Wie in dem anderen HowTo bereits gesagt, gibt es 2 Teile die Microsoft bereitstellt. Die <a target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyID=ca9d90fa-e8c9-42e3-aa19-08e2c027f5d6&amp;displaylang=en" title="ASP.NET AJAX Extensions">ASP.NET AJAXÂ Extensions</a> müssen installiert sein.
Sobald man diese installiert hat, bekommt man ein neues Template zur Auswahl: ASP.NET AJAX-Enabled Web Site/Application

<em>Bemerkung am Rande:
Der Unterschied zwischen einer Webapplication und einer Website wird <a target="_blank" href="http://blogs.vertigo.com/personal/swarren/Blog/Lists/Posts/Post.aspx?ID=10" title="Unterschied zwischen Web Site und Web Application">hier</a> gut dargestellt.</em>

<strong>Schritt 2: Website erstellen</strong>

Ich entscheide mich aus Einfachheitsgründen für eine Web Site und wähle das Template für "AJAX Enabled Web Sites".
Dadurch habe ich nun in meiner Toolbox 5 neue Controls (Erklärungen folgen später) :
- Timer
- ScriptManager
- ScriptManagerProxy
- UpdatePanel
- UpdateProgress

<strong>Schritt 3: Toolkit reinladen</strong>

Zwar denk ich, dass ich irgendwo schonmal ein Template dafür gesehen habe, aber ich lad mir das Toolkit seperat in meine Web Site rein. Dazu lad ich mir das <a target="_blank" href="http://www.codeplex.com/AtlasControlToolkit/Release/ProjectReleases.aspx?ReleaseId=4923" title="Toolkit download">Toolkit</a> runter und entpacke es.
Nun geh ich wieder zu meiner Website und füge ihr die Toolkit dll hinzu (Rechtsklick auf die Website &gt; Verweis hinzufügen... &gt; Durchsuchen). Die Toolkit dll versteckt sich in der SampleWebsite. Dort im "Bin" Ordner befindet sich die "<strong>AJAXControlToolkit.dll</strong>".
Nachdem ihr diese dll eurem Projekt hinzugefügt habt, wird in eurem Bin Ordner jetzt viele Ordner erstellt werden - für die unterschiedlichen Sprachen etc.

<strong>Schritt 4: Die Controls in der Toolbox sichtbar machen</strong>

Damit man später die tollen Controls direkt per Drag&amp;Drop auf seine Website ziehen kann, müssen wir diese noch in die Toolbox (dort wo alle Controls drin liegen)Â bekommen.
Dazu ein Rechtsklick auf ein freies Feld und klickt "Registerkarte hinzufügen" und nun ein Name eingeben (AJAX Toolkit z.B.).
Als nächstes dann wieder ein Rechtsklick drauf und dann "Elemente auswählen" &gt; "Durchsuchen" und euer Bin Verzeichnis Suchen (bei mir liegts da: <em>C:\Users\Robert\Documents\Visual Studio 2005\WebSites\TestWebsite\Bin)</em> und die Toolkit dll hinzufügen. Dannach nochmal bestätigen und schon hat man alle Controls in der Toolbox.

<strong>Schritt 5: Loslegen</strong>

Jetzt kann man wie man will seine ASPX Seite zusammenbauen und die Vorzüge von AJAX genießen. Ich möchte jetzt einfach mal auf die <a target="_blank" href="http://www.asp.net/learn/videos/default.aspx?tabid=63" title="How-Do-I with AJAX ASP.NET">How-Do-I Videos </a>verweisen, wo schon sehr viel erklärt wird. Ansonsten ausprobieren.

In einem nächsten Artikel werd ich dann zu den richtig interessanten Themen kommen - zum Beispiel clientseitige Aufrufe von Webdiensten oder die Einbindung des teilweise zickigen Toolkits.

<a href="http://code-inside.de/blog/artikel/howto-microsoft-aspnet-ajax-clientseitiger-aufruf-von-webmethoden/" title="Microsoft ASP.NET AJAX (Clientseitiger Aufurf von Webmethoden)">[Zum nächsten HowTo: Microsoft ASP.NET AJAX (Clientseitiger Aufruf von Webmethoden)]</a>
