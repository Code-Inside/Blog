---
layout: post
title: "HowTo: Mauseingaben & Javascript (Wie bastelt man ein Paint mit Javascript?)"
date: 2007-10-31 15:18
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Javascript]
language: de
---
{% include JB/setup %}
In diesem HowTo schauen wir uns mal an, wie man auf Mauseingaben mit Javascript reagiert. Es ist etwas schwammig formuliert, allerdings fiel mir nichts besseres ein.
Auf einfache "onclick" Events oder "onhover" etc. zu reagieren, ist nicht besonders schwer. Allerdings ist es manchmal wichtig zu wissen, wo der Nutzer hingeklickt hat - direkt dort wo der Nutzer hinklickt muss irgendwas passieren. In Zeiten von Drag`n`Drop wird es auch immer wichtiger, die Maus intuitiv mit in die Weboberfläche zu integrieren - also mehr als nur simples klicken.

Hier setzt dieses HowTo an. Die Fragestellung in dem Titel ist zwar etwas überspitzt, allerdings wollen wir ein ganz einfaches Paint mit Javascript nachbasteln.

<strong>So sieht die Anwendung hinterher aus:</strong>

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images-de/image142.png"><img border="0" width="240" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb121.png" alt="image" height="235" style="border: 0px" /></a>

<strong>Schritt 1: Grundsätzlicher Aufbau</strong>

Der Hauptteil der Anwendung ist eigentlich nur ein "Div" in dem wir malen wollen:
<pre class="csharpcode">    &lt;div id=<span class="str">"PaintingArea"</span>&gt; 
    &lt;/div&gt;</pre>
Hier die Styleangaben:
<pre class="csharpcode">    #PaintingArea 
    { 
    cursor: pointer; 
    margin-top: 10px; 
    border: solid 1px #000; 
    height: 270px; 
    width: 420px; 
    z-index: 10; 
    }</pre>
<strong>Schritt 2: Eventhandler setzen</strong>

Wie in den oberen Angabe zu sehen ist, werden keine Javascript Eventhandler hinzugefügt. Damit es auf allen Browsern läuft, muss man die Eventhandler per Code setzen (und am besten im Body onload aufrufen) :
<pre class="csharpcode">    function init() 
    { 
    document.getElementById(<span class="str">"PaintingArea"</span>).onmousedown = startPainting; 
    document.getElementById(<span class="str">"PaintingArea"</span>).onmousemove = performPainting; 
    document.getElementById(<span class="str">"PaintingArea"</span>).onmouseup = endPainting; 
    }</pre>
<u>onmousedown:</u>

Bei einem einfachen "onmousedown" (also sobald die Maustaste gedrückt wird) wird ein Flag "Global_Painting" gesetzt, dass momentan gezeichnet wird und im Anschluss wird einfach unser Punkt (also ein Div gezeichnet).

<u>onmousemove:
</u>Wenn die Mause über den Div bewegt wird UND das Flag gesetzt ist, wird weiterhin gezeichnet. Falls vorher kein Klick (und kein Flag gesetzt wurde), wird nicht gemalt. So ist es möglich, dass man mit der Maus über das Div bewegt, ohne das was passiert.

<u>onmouseup:
</u>Wenn die Maustaste losgelassen wird, wird das Flag auf false gesetzt - also wird nicht mehr gemalt und die Maus kann wieder über das Div bewegt werden, ohne das was passiert.

<strong>Schritt 3: Mausposition auslesen</strong>

Hier kommt eigentlich der wichtigste Schritt - das auslesen der aktuellen Mausposition.

Im IE / Opera kann man über diese Eigenschaft darauf zurückgreifen:
<pre class="csharpcode">        Global_Painting_offsetLeft = window.<span class="kwrd">event</span>.clientX; 
        Global_Painting_offsetTop = window.<span class="kwrd">event</span>.clientY;</pre>
Im Firefox über diese hier (daher einfach eine kleine JS Browserweiche mit "<strong>if(document.all)</strong>" einbauen) :
<pre class="csharpcode">            Global_Painting_offsetLeft = clickEvent.clientX; 
            Global_Painting_offsetTop = clickEvent.clientY;</pre>
Dabei ist "clickEvent" als Parameter der Funktion übergeben (obwohl in der init nichts angegeben wird - es funktioniert ;) ).
Die "Global_Painting_offsetXXX" Variablen speichern die momentane Mausposition.

<u>Hier mal die komplette startPainting Funktion:</u>
<pre class="csharpcode">    function startPainting(clickEvent) 
    { 
    Global_Painting = <span class="kwrd">true</span>;    

    <span class="kwrd">if</span>(!clickEvent) clickEvent = window.<span class="kwrd">event</span>; 
    <span class="kwrd">if</span>(document.all) 
        { 
        Global_Painting_offsetLeft = window.<span class="kwrd">event</span>.clientX; 
        Global_Painting_offsetTop = window.<span class="kwrd">event</span>.clientY; 
        } 
    <span class="kwrd">else</span> 
        { 
        Global_Painting_offsetLeft = clickEvent.clientX; 
        Global_Painting_offsetTop = clickEvent.clientY; 
        }    

    paint(); 
    }</pre>
Die "perfomPainting" ist eigentlich ebenso.

<strong>Schritt 4: Das Malen implementieren</strong>

Die gemalten "Pixel" sind in wahrheit Divs mit einer Hintergrundfarbe. Den Div wird einfach als "style.top" und "style.left" Attribut die Werte aus unseren "Global_Painting_offsetXXX" gegeben.

<strong>Schritt 5: Fertig</strong>

Der Rest ist eigentlich nur noch simples Javascript - z.B. Farbe setzen oder "Pinselgröße". Das kann ja jeder sich im Code anschauen.

<strong>Nachtrag:</strong>

Bei dem Malen verwende ich einfache Divs - das sieht für den Nutzer schön aus und ist auch recht easy. Man hätte auch eine Tabelle nehmen können, da wäre das programmatische Auswerten wesentlich einfacher, hätte aber das Raster begrenzt. Auch das es im FF etwas buggy ist, stimmt - allerdings soll dies nur eine Anregung sein und mal zeigen, wie man auf die Mauspositionsdaten zugreifen kann.

Viel Spaß beim Benutzen und Weiterverwenden :) 

<strong>Links:</strong>

[ <a href="http://code-developer.de/democode/jspaint/">Zur Javascript Paint Anwendung + Source Code</a> ]
