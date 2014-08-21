---
layout: post
title: "HowTo: Javascript Mouse Over - Mousepositionen für Details"
date: 2007-11-27 22:17
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Javascript, MouseOver, Source]
---
{% include JB/setup %}
Der Effekt ist eigentlich wohl bekannt und wir bei vielen Javascript Bibliotheken angeboten: Mouse Over Effekte. So werden z.B. Details oder weitere Informationen nachgeladen, sobald man mit dem Mousecursor über dem Element ist.

Doch bei einer solch einfachen Funktion ist ein komplettes Javascript Framework wie mit Kanonen auf Spatzen zu schießen, daher nun ein kleines HowTo wie man das selber in 5 Minuten implementieren kann:

<strong>Schritt 1: Grundgerüst erstellen</strong>
<pre class="csharpcode"><strong>&lt;body&gt;</strong> 

    &lt;h1&gt;Javascript Mouse Over&lt;/h1&gt; 

    <strong>&lt;div</strong> id=<span class="str">"MouseOver"</span> style=<span class="str">"display: none;"</span>&gt;<strong>&lt;/div&gt; 

<strong>&lt;p</strong> onmousemove=<span class="str">"showMouseOver('Mouse Over Text... Test...', event)"</span> 
</strong><strong>onmouseout=<span class="str">"hideMouseOver()"</span>&gt;[Mouse Over<strong>]&lt;/p&gt;</strong> 

</strong>    <strong>&lt;p&gt;...</strong><strong>&lt;/p&gt;</strong> 

<strong>&lt;/body&gt;</strong></pre>
In unserem Body Element ist ein Div namens "MouseOver" definiert, in welchen später unsere Mouseover Text drin ist. Danach folgt etwas Beispieltext, in welchen ich bestimmte Wörter über Javascript mit unserem kleinen Javascript verknüpft hab (onmousemove = anzeigen des Textes, onmouseout = verstecken des MouseOver Divs).

<strong>Schritt 2: Style hinzufügen</strong>

Als Style haben wir nur unser MouseOver etwas gestaltet:
<pre class="csharpcode">    &lt;style type=<span class="str">"text/css"</span>&gt; 

        #MouseOver 

        { 

        border: solid 1px black; 

        position: absolute; 

        background-color: #FFF; 

        } 

    &lt;/style&gt;</pre>
Dabei ist eigentlich nur das "position: absolute" wichtig.

<strong>Schritt 3: Javascript hinzufügen</strong>

Jedes Tag kann über "showMouseOver" einen Text übergeben und das Schlüsselwort event um auf die Mausposition zuzugreifen (dies hatte ich bei <a target="_blank" href="http://code-inside.de/blog/2007/10/31/howto-mauseingaben-javascript-wie-bastelt-man-ein-paint-mit-javascript/">diesem HowTo</a> nicht berücksichtig - dort wird der Eventhandler programmatisch zugeordnet, was aber nicht notwenig ist). Bei onmouseout muss dieser Detailtext wieder ausgeblendet werden - über "hideMouseOver".
<ul>
	<li>Javascript Funktionen:
<ul>
	<li>onmousemove=showMouseOver("text", event)</li>
	<li>onmouseout=hideMouseOver()</li>
</ul>
</li>
</ul>
Javascript Code:
<pre class="csharpcode">
function showMouseOver(text, <span class="kwrd">event</span>) 

    { 

     document.getElementById(<span class="str">'MouseOver'</span>).innerHTML = text; 

     var topPixel = <span class="kwrd">event</span>.clientY + 10; 

     var leftPixel = <span class="kwrd">event</span>.clientX + 10; 

     document.getElementById(<span class="str">'MouseOver'</span>).style.top = topPixel + <span class="str">"px"</span>; 

     document.getElementById(<span class="str">'MouseOver'</span>).style.left = leftPixel + <span class="str">"px"</span>; 

     document.getElementById(<span class="str">'MouseOver'</span>).style.display = <span class="str">"block"</span>; 

    }</pre>
<pre class="csharpcode">
function hideMouseOver() 

    { 

     document.getElementById(<span class="str">'MouseOver'</span>).innerHTML = <span class="str">""</span>; 

     document.getElementById(<span class="str">'MouseOver'</span>).style.top = <span class="str">"0px"</span>; 

     document.getElementById(<span class="str">'MouseOver'</span>).style.left = <span class="str">"0px"</span>; 

    document.getElementById(<span class="str">'MouseOver'</span>).style.display = <span class="str">"none"</span>; 

    }</pre>
Über das Schlüsselwort "event" kann auf die Mauspositionsdaten zugegriffen werden - über clientX und clientY wird dann unser MouseOver Div positioniert und über innerHTML mit dem jeweiligen Text befüllt. Dabei werden bei der Positionierung nochmal 10 Pixel zugerechnet, da es a) designtechnisch besser ist und b) sonst die "mouseout" Funktion aufgerufen wird.

Bei hideMouseOver wird das MouseOver Div "geleert" und wieder versteckt.

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image169.png"><img border="0" width="436" src="{{BASE_PATH}}/assets/wp-images/image-thumb148.png" alt="image" height="158" style="border: 0px" /></a>

Diese Technik funktioniert im IE7 und Firefox2 ohne Probleme - andere Browser müssten auch keine Probleme bringen. Hoff ich ;)

Viel Spaß...

<strong><a target="_blank" href="http://code-developer.de/democode/javascriptmouseover/default.htm">[ Download Source Code &amp; Demoanwendung ]</a></strong>
