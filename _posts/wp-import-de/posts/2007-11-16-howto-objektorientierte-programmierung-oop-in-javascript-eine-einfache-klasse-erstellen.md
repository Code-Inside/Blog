---
layout: post
title: "HowTo: Objektorientierte Programmierung / OOP in Javascript (Eine einfache Klasse erstellen)"
date: 2007-11-16 13:05
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Javascript, OOP]
language: de
---
{% include JB/setup %}
<p>Durch den (berechtigten) Hype um AJAX und das "Daten-Format" JSON wird eine Sache in der Webentwicklung immer interessanter: Die Javascriptentwicklung.</p> <p>Insgesamt vollzieht sich meiner Meinung nach ein kleiner Wandel in der Webentwicklung - man versucht sehr viele Sachen auf den Client auszuführen. Diese Entwicklung kann ich nur begrüßen, denn warum muss ich bei einer Sortierung von einer Tabelle wieder mit den Server kommunizieren, obwohl die Daten bereits auf dem Client sind? </p> <p>Genau solche Aufgaben können heute bereits Javascript-Frameworks erledigen. Auch bei Microsofts ASP.NET AJAX Extensions ist eine Clientbibliothek enthalten, doch nun kommen wir zur generellen Frage: Wie kann ich Daten in so einem Framework kapseln? Wie kann ich eigene Javascript Klassen mit Methoden definieren? </p> <p><strong>Klassen und Methoden in Javascript definieren - Schlagwort "prototype"</strong></p> <p>Prototype ist nicht nur ein Javascript Framework, sondern auch allgemein in der JS Welt ein Schlüsselwort für das definieren von Methoden. Aber erstmal Schritt für Schritt.<br>Wir machen ein ganz einfaches Beispiel - ein Rechteck. Das als Eigenschaft eine Höhe und Breite und wir möchten nun den Flächeninhalt berechnen.</p> <p>&nbsp;</p> <p><strong>Schritt 1: Konstruktor samt Member definieren</strong></p> <div class="CodeFormatContainer"><pre class="csharpcode">    function Rectangle() 
    {
        <span class="kwrd">this</span>.height;
        <span class="kwrd">this</span>.width;
    }</pre></div>
<p>Der Konstruktor ist eigentlich eine ganz normale JS Funktion, denn es gibt kein Schlüsselwort "class" in JS. Dannach sagen wir noch, dass wir zwei Eigenschaften height und width haben und schreiben noch (wie in der OOP üblich) ein "this" davor.</p>
<p><strong>Schritt 2: Getter / Setter definieren</strong></p>
<p>Wir können natürlich die Werte auch direkt dem Konstruktor übergeben ("<em>Rectangle(10, 5)"</em>), aber wir machen das direkt mit Getter/Setter-Methoden, wo auch das "prototype" zum Tragen kommt:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    Rectangle.<strong>prototype</strong>.setHeight = function(<span class="kwrd">value</span>)
    {
            <span class="kwrd">this</span>.height = <span class="kwrd">value</span>;
    }        
    Rectangle.<strong>prototype</strong>.getHeight = function()
    {
            <span class="kwrd">return</span> <span class="kwrd">this</span>.height;
    } </pre></div>
<p>Wir "prototypen" das Rectangle und sagen, ass es eine "setHeight" und "getHeight" Funktion gibt, welche über das Schlüsselwort "this"&nbsp;Zugang zu den Eigenschaften der Klasse haben.<br>Das ganze natürlich auch noch für die&nbsp;andere Eigenschaft.&nbsp;</p>
<p><strong>Schritt 3: Calc Methode erstellen</strong></p>
<p>Die Methode wo wir die Fläche errechnen wollen ist genauso einfach geschrieben wie bereits vermutet. "prototype" und über "this" auf die Werte zugreifen:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    Rectangle.prototype.calc = function()
    {
            var result = <span class="kwrd">this</span>.getWidth() * <span class="kwrd">this</span>.getHeight();
            <span class="kwrd">return</span> result;
    }    </pre></div>
<p><strong><strong>Schritt 4: Objekte erstellen und testen</strong></strong></p>
<p>In der ganz einfachen Demoanwendung (siehe Link unten) erstellen wir unsere Obejekte in einer JS Funktion welche im onload aufgerufen wird.</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    function initApp()
    {
        var objectA = <span class="kwrd">new</span> Rectangle();
        objectA.setHeight(10);
        objectA.setWidth(2);
        
        var objectB = <span class="kwrd">new</span> Rectangle();
        objectB.setHeight(15);
        objectB.setWidth(3);
        
        alert(objectA.calc());
        alert(objectB.calc());
    }</pre></div>
<p><strong><strong>Schritt 5: Ergebnis</strong></strong></p>
<p>Funktioniert wunderbar (getestet IE7 und FF2):</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image151.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="169" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb130.png" width="193" border="0"></a> </p>
<p><strong><a href="{{BASE_PATH}}/assets/wp-images-de/image152.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="169" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb131.png" width="193" border="0"></a> </strong></p>
<p>Ein Blick in den Firebug zeigt uns auch die Hierarchie:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image153.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="98" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb132.png" width="424" border="0"></a> </p>
<p>&nbsp;</p>
<p><strong><strong>Weiterführende Links</strong></strong></p>
<p><strong></strong>&nbsp;</p>
<p>Ich wollte dieses Beispiel ganz bewusst simple halten, da ich ansonsten immer nur sehr komplexe Beispiele gesehen hab. Wer sich tiefergehender darüber informieren möchte, der sollte sich <a href="http://mckoss.com/jscript/object.htm" target="_blank">diese Seite</a> mal anschauen.</p>
<p><strong><a href="http://code-developer.de/democode/jsoop/default.htm" target="_blank">[ Source Code + Demoanwendung ]</a></strong></p>
