---
layout: page
title: "HowTo: Microsoft ASP.NET AJAX (PageMethods - Webmethoden aufrufen ohne ASMX Datein)"
date: 2007-10-01 21:41
author: robert.muehsig
comments: true
categories: []
tags: []
---
In <a href="http://code-inside.de/blog/artikel/howto-microsoft-aspnet-ajax-clientseitiger-aufruf-von-webmethoden/">diesem</a>Â HowTo erklärte ich, wie man eine ASMX Datei so erweitern kann, dass man die Methoden auch über Javascript (und über den ScriptManager) zugänglich macht.
Da man allerdings nicht immer eine ASMX Datei erstellen will um vielleicht nur eine kleine Aufgabe zu erledigen gibt es die so genannten PageMethods.

Da das nicht weiter schwer ist, werde ich kurz die Schritte zeigen:

<strong>Schritt 1: AJAX Enabeld Website erstellen &amp; ScriptManager anpassen</strong>

Durch das Template (wie man das bekommt, ist <a href="http://code-inside.de/blog/artikel/howto-microsoft-aspnet-ajax-praktischer-anfang/">hier</a> beschrieben)

<em>&lt;asp:ScriptManager ID="ScriptManager1" runat="server" <strong>EnablePageMethods="True"</strong> /&gt;</em>

Wichtig hierÂ ist das "EnablePageMethods" auf "True" zu setzen.

<strong>Schritt 2: Die PageMethod in der Code Behind erstellen</strong>

Meine einfache PageMethod sieht so aus:

<em><strong>[WebMethod]
</strong>public <strong>static</strong> string HelloWorld(string name)
{
Â Â Â  return "Hello World " + name;
}</em>

Die wichtigen Teile sind fett markiert. Für das "WebMethod" Attribut muss der Namespace "System.Web.Services" eingebunden werden. Erst durch dieses Attribut baut der ScriptManager den JS Wrapper drum herum.
Der nächste (und sehr wichtige Punkt) - nur statische Methoden können genutzt werden. Um die Objekthierarchie von ASP.NET nicht zu zerstören, können keine Instanzmethoden aufgerufen werden. In der CTP ging dies wohl noch, wurde aber aus Sicherheitsgründen aus dem Release herausgenommen. Allerdings hat man Zugriff auf die Session oder kann dort andere Klassen aufrufen.

<strong>Schritt 3: Die Methode im Javascript ansprechen</strong>

Die entscheidente Javascriptzeile (die Demoapplikation kann unten runtergeladen werden):

<em><strong>PageMethods</strong>.HelloWorld("Robert", onComplete);</em>

Über das Javascript Objekt "PageMethods" sind alle Methoden zu finden, welche mit dem WebMethod-Attribut ausgestattet sind und statisch sind. Dann einfach die jeweilige Methode aufrufen und freuen.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image30.png"><img border="0" width="418" src="{{BASE_PATH}}/assets/wp-images/image-thumb30.png" alt="image" height="391" style="border: 0px" /></a>

<a href="http://{{BASE_PATH}}/assets/files/democode/aspnetajax/ajaxpagemethods.zip" title="Demo Source Code PageMethods">[Download Demo Source Code]</a>
