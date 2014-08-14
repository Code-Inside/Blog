---
layout: post
title: "HowTo: Xml mit Javascript Parsen (Zugriff auf Nodes & Attribute)"
date: 2007-11-13 23:24
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Javascript, Xml]
---
{% include JB/setup %}
JSON ist eigentlich eine feine Sache - allerdings hat man manchmal keine Wahl und muss in Javascript ein XML parsen.

Das dies eigentlich fast genauso einfach ist, wie JSON, sieht man allerdings erst hinterher. Da der Zugriff manchmal allerdings etwas blöder ist als unter .NET selbst, schreibe ich kurz dieses HowTo. Die Demoanwendung samt kompletten Sourcecode gibts am Ende.

<strong><u>Vorbereitung: ASP.NET AJAX Projekt, XML DateinÂ samt Webservice mit "ScriptService" versehen und einbinden</u></strong>

Unsere Demoappliaktion ist sehr einfach - das Hauptaugenmerk liegt sowieso späterÂ auf dem Javascript:

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image148.png"><img border="0" width="185" src="{{BASE_PATH}}/assets/wp-images/image-thumb127.png" alt="image" height="167" style="border: 0px" /></a>

Die 3 XML Datein werden wir mit Javascript auswerten:

"Example_1.xml"

<p class="CodeFormatContainer">
<pre class="csharpcode">&lt;?xml version=<span class="str">"1.0"</span> encoding=<span class="str">"utf-8"</span> ?&gt; 
&lt;root&gt;FooBar&lt;/root&gt;</pre>
"Example_2.xml"

<p class="CodeFormatContainer">
<pre class="csharpcode">&lt;?xml version=<span class="str">"1.0"</span> encoding=<span class="str">"utf-8"</span> ?&gt; 
&lt;root&gt; 
   &lt;itemCollection&gt; 
      &lt;item&gt;FooBar1&lt;/item&gt; 
      &lt;item&gt;FooBar2&lt;/item&gt; 
      &lt;item&gt;FooBar3&lt;/item&gt; 
   &lt;/itemCollection&gt; 
&lt;/root&gt;</pre>
"Example_3.xml"

<p class="CodeFormatContainer">
<pre class="csharpcode">&lt;?xml version=<span class="str">"1.0"</span> encoding=<span class="str">"utf-8"</span> ?&gt; 
&lt;root&gt; 
   &lt;itemCollection category=<span class="str">"Products"</span>&gt; 
      &lt;item id=<span class="str">"1234523"</span>&gt; 
         &lt;title&gt;Foo1&lt;/title&gt; 
         &lt;subtitle&gt;Bar1&lt;/subtitle&gt; 
      &lt;/item&gt; 
      &lt;item id=<span class="str">"123797590"</span>&gt; 
         &lt;title&gt;Foo2&lt;/title&gt; 
         &lt;subtitle&gt;Bar2&lt;/subtitle&gt; 
      &lt;/item&gt; 
      &lt;item id=<span class="str">"889774395"</span>&gt; 
         &lt;title&gt;Foo3&lt;/title&gt; 
         &lt;subtitle&gt;Bar3&lt;/subtitle&gt; 
      &lt;/item&gt; 
   &lt;/itemCollection&gt; 
&lt;/root&gt;</pre>
Wie man sieht - am Ende ist quasi die Königsdisziplin dran - verschachtelte Elemente und Attribute.

Der Webservice hat folgende Methode:

<p class="CodeFormatContainer">
<pre class="csharpcode">        [WebMethod] 
        [ScriptMethod(ResponseFormat=ResponseFormat.Xml)] 
        <span class="kwrd">public</span> XmlDocument LoadExample(<span class="kwrd">int</span> id) 
        { 
            <span class="kwrd">string</span> filename = <span class="str">"Example_"</span> + id.ToString() + <span class="str">".xml"</span>; 
            <span class="kwrd">string</span> path = Path.Combine(<span class="kwrd">this</span>.Context.Request.PhysicalApplicationPath, filename); 

            XmlDocument ExampleDocument = <span class="kwrd">new</span> XmlDocument(); 
            ExampleDocument.Load(path); 

            <span class="kwrd">return</span> ExampleDocument; 
        }</pre>
<strong>Achtung:</strong> Da die AJAX Extensions (<a target="_blank" href="http://code-inside.de/blog/artikel/howto-microsoft-aspnet-ajax-grundlagen/">siehe auch dazu hier die Grundlagen</a>)Â immer ein Json zurückgeben, muss man erst das "ResponseFormat" auf "ResponseFormat.Xml" stellen.
Ansonsten einfaches einlesen der einzelnen XML "Example_X.xml" Datein und über den Webservice zurückgeben.
Diesen Webservice jetzt noch als Scriptservice im Scriptmanager bekannt machen und gut ist (<a target="_blank" href="http://code-inside.de/blog/artikel/howto-microsoft-aspnet-ajax-clientseitiger-aufruf-von-webmethoden/">das dazugehörige HowTo</a>).

<strong><u>Einfaches Interface basteln</u></strong>

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image149.png"><img border="0" width="339" src="{{BASE_PATH}}/assets/wp-images/image-thumb128.png" alt="image" height="92" style="border: 0px" /></a>

Das sehr einfache Interface besteht aus einer Überschrift und 3 Buttons welche die AJAX Requests starten, damit wir im Anschluss das XML auswerten können.
Unter den Buttons erfolgt dabei die Ausgabe und eine kurze Erklärung was da passiert.

<strong><u>Javascript: Example_1.xml parsen (einfacher Javascript Zugriff auf ein Element)</u></strong>

<p class="CodeFormatContainer">
<pre class="csharpcode">var myResult = result.getElementsByTagName(<span class="str">"root"</span>)[0].firstChild.nodeValue;</pre>
Das ist der Zugriff auf unser "nodeValue" "FooBar". In dem Screenshot kann man den Verlauf auch folgen:Â 

<a atomicselection="true" href="{{BASE_PATH}}/assets/wp-images/image150.png"><img border="0" width="234" src="{{BASE_PATH}}/assets/wp-images/image-thumb129.png" alt="image" height="284" style="border: 0px" /></a>Â 
(Ausschnitt aus dem Firebug - <a target="_blank" href="http://code-inside.de/blog/artikel/howto-webanwendung-debuggen-javascript-html-debuggen-mit-den-entsprechenden-tools/">siehe dazu HowTo JS debuggen</a>)

<strong>Erklärung:</strong>

getElementsByTagName: Liefert alle Nodes mit den übergebenen Namen zurück
getElementsByTagName("root")[0]: Liefert das erste vorkommen dieses Nodes zurück
firstChild: Liefert auch das erste Vorkommen eines Nodes zurück - wenn man aber auf den Value des Nodes Zugreifen will, muss man vorher ebenfalls über firstChild und dann erst nodeValue rein (siehe Screenshot)

<strong><u>Javascript: Example_2.xml parsen (Javascript Zugriff auf mehrere Element)</u></strong>

<p class="CodeFormatContainer">
<pre class="csharpcode">                var myResult = <span class="str">""</span>; 
                <span class="kwrd">for</span>(i = 0; i &lt; result.getElementsByTagName(<span class="str">"item"</span>).length; i++) 
                    { 
                    myResult += result.getElementsByTagName(<span class="str">"item"</span>)[i].firstChild.nodeValue + <span class="str">"&lt;br/&gt;"</span>; 
                    }</pre>
<strong>Erklärung:</strong>

Hier macht man sich den selben Mechanismus zunutze, diesmal fragt man allerdings vorher die Anzahl der gefunden Nodes über "<strong>getElementsByTagName('xxx').length</strong>" ab.
Dannach wieder jede Node durchgehen und auf unseren Inhalt über "<strong>firstChild.nodeValue</strong>" zugreifen.

<strong><u>Javascript: Example_3.xml parsen (Javascript Zugriff auf Xml Attribute)</u></strong>

Da es ja auch vorkommt, dass Attribute mit in den Nodes vorhanden sind, können diese natürlich ebenfalls über Javascript abgerufen werden:

<p class="CodeFormatContainer">
<pre class="csharpcode">result.getElementsByTagName(<span class="str">"itemCollection"</span>)[0].getAttribute(<span class="str">"category"</span>)</pre>
Über die Methode "getAttribute" wird direkt der gefundene Value des Attributes zurückgegeben. Eine andere (aber nicht so schöne) Möglichkeit ist über "<strong>element.attributes[0].value</strong>" - alledings geht "<strong>element.attributes["category"].value</strong>" nicht (jedenfalls bei mir gerade nicht).

Getestet alles mit IE 7 und Firefox 2 - sollte aber generell bei allen Browsern so funktionieren.

<strong>[ <a href="http://{{BASE_PATH}}/assets/files/democode/javascriptxml/javascriptandxml.zip">Source Code</a> | <a href="http://code-developer.de/democode/javascriptandxml/">Demoapplikation</a>* ]</strong>

* auf dem Webspace funktioniert es momentan noch nicht so wie lokal - hängt mit dem Hoster zusammen - einfach die Demoapp runterladen und freuen ;)

<strong>Links:</strong>

<a target="_blank" href="http://code-inside.de/blog/artikel/howto-microsoft-aspnet-ajax-grundlagen/">HowTo - ASP.NET AJAX Grundlagen</a>
<a target="_blank" href="http://code-inside.de/blog/artikel/howto-microsoft-aspnet-ajax-clientseitiger-aufruf-von-webmethoden/">HowTo - Clientseitiger Aufruf von Webmethoden</a>
<a target="_blank" href="http://code-inside.de/blog/artikel/howto-webanwendung-debuggen-javascript-html-debuggen-mit-den-entsprechenden-tools/">HowTo - JS debuggen</a>
