---
layout: page
title: "HowTo: Microsoft Virtual Earth (Praktischer Einstieg)"
date: 2007-10-10 23:51
author: robert.muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-microsoft-virtual-earth-praktischer-einstieg
---
{% include JB/setup %}
<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image64.png"><img border="0" width="191" src="{{BASE_PATH}}/assets/wp-images/image-thumb43.png" alt="image" height="55" style="border: 0px" /></a>

Nachdem ich bereits sehr kurz mal <a target="_blank" href="http://code-inside.de/blog/artikel/howto-google-maps-api-grundvoraussetzungen/">Google Map</a> angerissen habe, möchte ich mich nun etwas intensiver mit Microsofts Variante beschäftigen: <a target="_blank" href="http://maps.live.de/LiveSearch.LocalLive">Virtual Earth</a>.

Anders als Googles Dienst, kann man den Microsoft Dienst <strong>ohne</strong> Anmeldung nutzen und die Regeln für das Nutzen des Dienstes ist nicht ganz so streng.
Man kann zum Beispiel in einem Windows Programm (wie das geht erklär ich hoffentlich ein ander mal ;) ) Live Daten mit Virtual Earth anzeigen - bei Google Maps gabs wohl da Probleme (rechtliche - technisch bestimmt ebenso machbar), aber es kann sein, dass ich mich hier täusche.

<strong>Schritt 1: Informationen besorgen</strong>

Informationen rund um Virtual Earth findet man auf verschiedenen Stellen:
<ul>
	<li><a target="_blank" href="http://dev.live.com/virtualearth/sdk/#">Das SDK mit Beispielcode</a></li>
	<li><a target="_blank" href="http://msdn2.microsoft.com/en-us/library/bb429619.aspx">Virtual Earth @ MSDN Library</a></li>
	<li><a target="_blank" href="http://msdn2.microsoft.com/en-us/virtualearth/default.aspx">Virtual Earth @ MSDN</a></li>
	<li><a target="_blank" href="http://www.microsoft.com/germany/msdn/webcasts/serien/MSDNWCS-0612-01.mspx">Einführung in Windows Live (darunter auch Virtual Earth) von Oliver Scheer</a></li>
</ul>
Insbesondere bei dem letzten Link sieht man mal, wie einfach es doch ist.
Wer allerding genau aufpasst und sich fragt, warum Oliver dort mit Koordinaten und nicht mit den Adressen von München arbeitet, der wird später feststellen, dass es keine schöne "Geocoder" Klasse gibt wie bei Google Maps, sondern nur eine "Find" Methode.

<strong>Schritt 2: Simple HTML Seite basteln</strong>

Den kompletten Beispielcode kann man am Ende runterladen, hier möchte ich nur kurz die wichtigsten Punkte erwähnen:

Das Einbinden des Virtual Earth Javascripts:
<em>"&lt;script language="javascript" type="text/javascript" src="</em><a href="http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=5"><em>http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=5"</em></a><em>&gt;&lt;/script&gt;"</em>

Dannach erstellt man einfach ein "<em><a target="_blank" href="http://msdn2.microsoft.com/en-us/library/bb429586.aspx">VEMap(ZielDiv)</a>"</em> Objekt und gibt als Parameter noch ein Zieldiv an wo es angezeigt wird. Dannach initialisiert man die Karte mit "<em><a target="_blank" href="http://msdn2.microsoft.com/en-us/library/bb412546.aspx">LoadMap()"</a></em> und schon gehts ab:

<u>Javascript für das erstellen der Karte:</u>

<em>function GetMap()
{
map = new VEMap('&lt;%=PanelMap.ClientID%&gt;'); // ZielDiv
map.LoadMap();                                              // Karte initialisieren
map.SetZoomLevel(14);                                  // Zoomlevel
map.HideDashboard();                                    // Auswahloptionen verstecken
map.SetMapStyle(VEMapStyle.Aerial);           // Auf Arealsicht stellen
map.SetScaleBarDistanceUnit(VEDistanceUnit.Kilometers); // Von Meilen auf Kilometer umstellen </em>

<em>map.Find('','&lt;%=Request.QueryString["destination"] %&gt;, Germany',null,null,0,1,false,false,false,true, onComplete); // Suchen
}</em>

Am komplexesten ist die <a target="_blank" href="http://msdn2.microsoft.com/en-us/library/bb429645.aspx">Find-Methode</a> - anstatt dem &lt;%=Request.QueryString["destination"] %&gt; könnte man zum Beispiel auch "Dresden" hinschreiben - das brauchen wir nur für später.

Am wichtigsten ist eigentlich die "onComplete" Callbackmethode

<strong>Schritt 3: Verstehen wie das Geocoding funktioniert</strong>

Das wichtigste ist hier das Geocodeing zu verstehen - in der Find-Methode werden mehrere Parameter übergeben. Der letzte ist die Callbackmethode.
Diese Methode wird aufgerufen, nachdem der geocoding Vorgang abgeschlossen wurde.

<u>Die onComplete Methode bei mir sieht so aus:</u>

<em>function onComplete(shape, FindResult, VEPlace, HasMoreFlag)
{
shape = new VEShape(VEShapeType.Pushpin, VEPlace[0].LatLong);
shape.SetTitle(VEPlace[0].Name);
map.AddShape(shape);
}</em>

In dem <a target="_blank" href="http://msdn2.microsoft.com/en-us/library/bb429615.aspx">VEPlace</a> Array (!) verstecken sich die Koordinaten, diese übergebe ich dem <a target="_blank" href="http://msdn2.microsoft.com/en-us/library/bb412535.aspx">VEShape</a> Konstruktor und hab am Ende so ein "Pushpin".

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image65.png"><img border="0" width="336" src="{{BASE_PATH}}/assets/wp-images/image-thumb44.png" alt="image" height="162" style="border: 0px" /></a>

<strong>Downloads:</strong>

<a target="_blank" href="http://code-developer.de/democode/virtualearth/">[Hier ein Link zur Demopage (Deutschland, normale größe)]</a> &amp; <a target="_blank" href="http://code-developer.de/democode/virtualearth/?width=500&amp;height=800&amp;destination=berlin">[Noch ein Link, diemal mit anderen Parametern dran(Berlin, größer)]</a>

<strong>Als IFrame:</strong>
<iframe height="310" width="310" src="http://code-developer.de/democode/virtualearth/?width=300&height=300&destination=berlin" name="VirtualEarthDemo"></iframe>

<a target="_blank" href="http://{{BASE_PATH}}/assets/files/democode/virtualearth/virtualearthdemo.zip">[Demo Source Code Downloaden]</a>

<strong>Links:</strong>

<a target="_blank" href="http://maps.live.de/LiveSearch.LocalLive">Virtual Earth auf der dt. Live Seite</a>
<a target="_blank" href="http://msdn2.microsoft.com/en-us/library/bb429619.aspx">Virtual Earth @ MSDN Library</a>
<a target="_blank" href="http://msdn2.microsoft.com/en-us/virtualearth/default.aspx">Virtual Earth @ MSDN</a>
<a target="_blank" href="http://dev.live.com/virtualearth/sdk/#">Virtual Earth SDK</a>
<a target="_blank" href="http://www.microsoft.com/germany/msdn/webcasts/serien/MSDNWCS-0612-01.mspx">Einführung in Windows Live (darunter auch Virtual Earth) von Oliver Scheer</a>
