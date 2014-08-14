---
layout: post
title: "HowTo: ASP.NET Seiten komprimieren per global.asax"
date: 2008-02-26 11:01
author: oliver.guhr
comments: true
categories: [Allgemein, HowTo]
tags: [.NET, ASP.NET, deflate, gzip, HowTo, komprimieren]
---
Wenn man größere Datenmegen auf einer ASP Seite anzeigen oder per Webservice übertragen möchte, kann man die Übertragungsdauer durch Komprimierung erheblich reduzieren (je nach Inhalt schrumpft die Datenmenge auf ca. 1/4).
Eine ausführliche Anleitung wie man die Komprimierung (gzip und deflate) ohne großen Aufwand und Änderungen am Code einrichtet findet ihr <a href="http://www.stardeveloper.com/articles/display.html?article=2007110401&page=1">hier</a>.

Hier die Kurzanleitung:

1. Füge <a href="{{BASE_PATH}}/assets/wp-images/global.asax">diese Datei </a>in dein Projekt ein.
2. Webseite neu bauen.
3. Fertig :)



