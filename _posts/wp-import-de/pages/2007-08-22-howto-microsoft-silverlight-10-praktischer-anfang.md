---
layout: page
title: "HowTo: Microsoft Silverlight 1.0 (Praktischer Anfang)"
date: 2007-08-22 20:22
author: Robert Muehsig
comments: true
categories: []
tags: []
permalink: /artikel/howto-microsoft-silverlight-10-praktischer-anfang
---
{% include JB/setup %}
<p>Wie bereits in dem ersten HowTo (mit den Grundlagen) geht es diesmal um den praktischen Anfang - also was braucht der Entwickler und was braucht hinterher der Anwender?&nbsp;&nbsp;Am Ende des HowTos sind wir dann an einem guten "Anfangspunkt" - mit allem was man zu Silverlight 1.0 braucht.</p> <p><strong>Was braucht nun der Anwender?</strong></p> <p>Der Anwender benötigt nur das <a title="Silverlight Runtime" href="http://www.microsoft.com/silverlight/downloads.aspx" target="_blank">Browser Plugin</a> - das ist allerdings für Windows und Mac gibt. Also offiziel von MS - die Linuxer sollten nach "Moonlight" suchen.</p> <p>&nbsp;</p> <p><strong>Und was braucht ein toller und fähiger Entwickler?</strong></p> <p>Eigentlich nur ein Texteditor und die MSDN. Günstiger wäre allerdings eine richtige IDE, Visual Studio bietet sich an, und das <a title="Silverlight 1.0 SDK" href="http://msdn.microsoft.com/vstudio/eula.aspx?id=a40f3ffc-2657-02ec-7d67-7a79b4eac832" target="_blank">SDK</a>.</p> <p>&nbsp;</p> <p><strong>Ein Wort noch zu Visual Studio &amp; ASP.NET Futures:</strong></p> <p>Silverlight Applikationen lassen sich auch leicht mit Visual Studio 2005 entwickeln. Nachdem man das SDK installiert hat, bekommt man sogar ein Template dazu, allerdings wird die Unterstützung mit Visual Studio 2008 wahrscheinlich besser. Insbesondere da VS 2008 auch IntelliSens für Javascript verfügt. Für alle die es interessiert: Visual Studio 2008 ist momentan noch in der Betaphase, kann aber <a title="Visual Studio 2008 Beta 2" href="http://msdn2.microsoft.com/en-us/vstudio/aa700831.aspx" target="_blank">hier</a> ausprobiert werden. Ich werde hier mit Visual Studio 2005 arbeiten.</p> <p>Nun noch ein Wort zu den <a title="ASP.NET AJAX Futures" href="http://asp.net/downloads/futures/" target="_blank">ASP.NET Futures</a>: Mit den Futures (die ebenfalls Beta sind) kommt wohl auch ein Silverlight Control sowie noch mehr zum AJAX Framework. Ich hab die jetzt nicht installiert, sondern nutze die normalen <a title="MS AJAX" href="http://www.asp.net/ajax/" target="_blank">ASP.NET AJAX Extensions</a>. </p> <p>So... fangen wir nun an.</p> <p>&nbsp;</p> <p><strong>Schritt 1: Das SDK installieren und das Template ausprobieren.</strong></p> <p>Nachdem das SDK installiert wurde, gibt es ein neues Template:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image2.png" atomicselection="true"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="136" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb2.png" width="455" border="0"></a> </p> <p>Wenn man das SDK für Silverlight 1.1 noch installiert hat, sieht man in den Vorlagen noch ein Template für Silverlight .NET Applikationen.</p> <p>Hier das Template nun:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image3.png" atomicselection="true"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="134" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb3.png" width="191" border="0"></a></p> <p>Was sehen wir nun?&nbsp;Grob sieht man drei Teile:&nbsp;Die Default.html samt Javascript, die Scene.xaml samt Javascript und das Silverlight Javascript - doch was macht was?</p> <p>Die Hauptkomponente die auch die Überprüfung durchführt ist die "<strong>Silverlight.js</strong>" Datei. Hier wird geprüft ob die richtige Version des Plugins installiert ist&nbsp;etc.</p> <p>&nbsp;</p> <p>&nbsp;Die "<strong>Default.html</strong>" lädt die Javascript Datein rein:</p> <div class="CodeFormatContainer"> <style>
<!--
.csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}

.csharpcode pre { margin: 0em; }

.csharpcode .rem { color: #008000; }

.csharpcode .kwrd { color: #0000ff; }

.csharpcode .str { color: #006080; }

.csharpcode .op { color: #0000c0; }

.csharpcode .preproc { color: #cc6633; }

.csharpcode .asp { background-color: #ffff00; }

.csharpcode .html { color: #800000; }

.csharpcode .attr { color: #ff0000; }

.csharpcode .alt 
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}

.csharpcode .lnum { color: #606060; }

-->
</style> <pre class="csharpcode">   &lt;script type=<span class="str">"text/javascript"</span> src=<span class="str">"Silverlight.js"</span>&gt;&lt;/script&gt;
   &lt;script type=<span class="str">"text/javascript"</span> src=<span class="str">"Default.html.js"</span>&gt;&lt;/script&gt;
   &lt;script type=<span class="str">"text/javascript"</span> src=<span class="str">"Scene.xaml.js"</span>&gt;&lt;/script&gt;</pre></div>
<p>&nbsp;</p>
<p>Zudem gibt es noch ein Div und die Funktion, welche das Silverlight (einen Button) erstellt:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">   &lt;div id=<span class="str">"SilverlightPlugInHost"</span>&gt;
      &lt;script type=<span class="str">"text/javascript"</span>&gt;
         createSilverlight();
      &lt;/script&gt;
   &lt;/div&gt;</pre></div>
<p>Die "createSilverlight()"-Funktion ist in der "<strong>Default.html.js</strong>" definiert und erstellt das Gerüst und ruf dann die XAML Datei - "<strong>Scene.xaml</strong>" - auf um das was darin definiert ist, anzuzeigen.</p>
<p>In der "<strong>Scene.xaml" </strong>ist die Oberfläche definiert. Ein einfacher Button.</p>
<p>In der "<strong>Scene.xaml.js</strong>" wird der Oberfläche verhalten zugewiesen - was passiert, wenn ein Benutzer klickt oder was passiert wenn die Maus drüber geht. Die Verbindung zwischen "<strong>Scene.xaml</strong>" und "<strong>Scene.xaml.js</strong>" wird über die "<strong>Default.html.js</strong>" erreicht - nach dem erstellen der XAML wird noch die "<strong>Scene.xaml.js</strong>" aufgerufen.</p>
<p>Wenn man das ganze jetzt anschaut, sieht man einen Button auf den man klicken kann und es kommt ein kleines Fenster, dass das Element geklickt wurde.</p>
<p><strong>Schritt 2:</strong> Ein ASP.NET AJAX Enabled Website erstellen</p>
<p>Da in dem Silverlight Template keine ASP.NET AJAX komponenten installiert sind und die Anpassung an die Web.Config doch recht kompliziert sind und wir aber auf die Funktionalität nicht verzichten wollen, erstellen wir eine einfache ASP.NET AJAX enabled Website und werden die benötigten Komponenten reinladen.</p>
<p><strong>Schritt 3:</strong> Komponenten reinladen - doch welche?</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image4.png" atomicselection="true"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="169" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image-thumb4.png" width="188" border="0"></a> </p>
<p>Man füge folgende Elemente hinzu:</p>
<ul>
<li>Default.html.js 
<li>Scene.xaml 
<li>Scene.xaml.js 
<li>Silverlight.js</li></ul>
<p>Und kopiert aus der Default.html diese Zeilen und fügt sie in die Default.aspx richtig ein:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">   &lt;script type=<span class="str">"text/javascript"</span> src=<span class="str">"Silverlight.js"</span>&gt;&lt;/script&gt;
   &lt;script type=<span class="str">"text/javascript"</span> src=<span class="str">"Default.html.js"</span>&gt;&lt;/script&gt;
   &lt;script type=<span class="str">"text/javascript"</span> src=<span class="str">"Scene.xaml.js"</span>&gt;&lt;/script&gt;</pre><pre class="csharpcode">...</pre></div>
<div class="CodeFormatContainer"><pre class="csharpcode">   &lt;div id=<span class="str">"SilverlightPlugInHost"</span>&gt;
      &lt;script type=<span class="str">"text/javascript"</span>&gt;
         createSilverlight();
      &lt;/script&gt;
   &lt;/div&gt;</pre><pre class="csharpcode">&nbsp;</pre>
<p>Am Ende sieht man das selbe Ergebnis wie bei dem normalen Template - mit dem Unterschied, dass uns jetzt noch die MS AJAX Funktionalität offen steht, welche wir bestimmt später noch brauchen.</p>
<p>&nbsp;</p>
<p>Das wärs erstmal - weiter gehts an einer anderen Stelle.</p></div>
