---
layout: page
title: "Guide: XML (XML Schema XSD - Teil 1)"
date: 2007-08-21 21:35
author: robert.muehsig
comments: true
categories: []
tags: []
---
{% include JB/setup %}
<h2><u>4.2 XML Schema</u></h2> <p>&nbsp;</p> <p>Das XML - Schema ist eine Empfehlung vom W3C, welche dem Prinzip der XML-DTD ähnelt - es definiert die XML Baumstruktur. Im Gegensatz zur herkömmlichen XML-DTD ist die XSD komplexer und bietet mehr Datentypen zur Auswahl. Zudem ist die XSD komplett im XML Format beschrieben.  <p>Anmerkungen zu diesem Abschnitt: Es gibt immer mehrere Wege ein Element zu beschreiben. Scheinbar herrscht unter den XSD Liebhabern noch keine Einigkeit zu bestehen, welche Form man nun genau wählt. Vom Prinzip her unterscheiden sich die Formen aber nur in kleinen Teilen.  <p>&nbsp;</p> <h3><u>4.2.1 Einbindung</u></h3> <p>Eingebunden wird das Schemat im Rootelement des XMLs.  <div class="CodeFormatContainer"> <style>
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
</style> <pre class="csharpcode"><u>Beispiel:</u>
&lt;?xml version=”1.0” standalone=”no”?&gt;
&lt;ROOT xmlns:xsi=<span class="str">"http://www.w3.org/2000/10/XMLSchema-instance"</span> xsi:noNamespaceSchemaLocation=<span class="str">"SCHEMADATEINAME.xsd"</span>
 &gt;
&lt;/ROOT&gt;
</pre></div>
<p>Direkt hinter dem Rootelement wird ein XML Namespace mit dem Präfix xsi gebildet, welche direkt vom W3C kommt. Dannach erfolgt die Einbindung unserer XSD. 
<h3><u>4.2.2 Schemaelemente</u></h3>
<p>Hier ein kurzer Überblick, was im Schema enthalten sein kann.</p>
<h4><u>4.2.2.1 Wurzelelemente</u></h4>
<p>Das Wurzelelement in der XSD ist entweder das &lt;xsd:schema&gt;, das &lt;xs:schema&gt; oder nur &lt;schema&gt; - je nach eingebundenen Namespace. 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel <span class="kwrd">in</span> XSD:</u>
&lt;?xml version=”1.0” encoding=”UTF-8”?&gt;
&lt;xsd:schema xmlns:xsd=<spaan class="str">"http://www.w3.org/2001/XMLSchema"</span>&gt;
.
.
.
&lt;/xsd:schema&gt;
</pre></div>
<p>Da die XSD auch nur ein XML Dokument ist, wird in der ersten Zeile die XML Version sowie die Kodierung festgelegt. 
<p>Dannach erfolgt ein Tag "schema" mit einem Präfix, welcher standardmäßig entweder xs oder xsd ist. 
<p>Dies wird durch den Namensraum, welcher auch wieder vom W3C kommt, festgelegt. 
<p>Das xs oder xsd kann auch weggelassen werden, wenn ich anstatt "xmlns:xsd=..." direkt "xmlns=..." schreibe. Hierbei spricht man, wie schon einmal erwähnt, vom sogenannten default Namespace. 
<p>Da meistens mit dem XSD Präfix gearbeitet wird, werde ich es in den folgenden Teilen ebenfalls verwenden. 
<p>&nbsp;</p>
<h4><u>4.2.2.2 Deklarationselemente</u></h4>
<p>&nbsp;</p>
<p><strong><u>Elemente:</u></strong></p>
<p>Ähnlich leicht wie in der DTD können in der XSD Elemente erstellt werden. 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel <span class="kwrd">in</span> XSD (Datei: element.xsd):</u>
&lt;?xml version=”1.0” encoding=”UTF-8”?&gt;
&lt;xsd:schema xmlns:xsd=<span class="str">"http://www.w3.org/2001/XMLSchema"</span>&gt;
&lt;xsd:element name="Bauunternehmen" /&gt;
&lt;/xsd:schema&gt;

<u>Beispiel <span class="kwrd">in</span> XML:</u>
&lt;?xml version=”1.0” encoding=”UTF-8”?&gt;
&lt;Bauunternehmen xmlns:xsi=<span class="str">"http://www.w3.org/2000/10/XMLSchema-instance"</span> xsi:noNamespaceSchemaLocation="element.xsd"&gt;
.
.
.
&lt;/Bauunternehmen&gt;
</pre></div>
<p><strong><u>Attribute:</u></strong></p>
<p>Ähnlich leicht wie in der DTD können in der XSD Elemente erstellt werden. 
<p>Da es nicht unbedingt ratsam ist, direkt im Root Element Attribute festzulegen, ist in diesem Beispiel "Bauunternehmen" ein Element irgendwo in dem XML Dokument. 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel <span class="kwrd">in</span> XSD (Datei: attribut.xsd):</u>
&lt;?xml version=”1.0” encoding=”UTF-8”?&gt;
&lt;xsd:schema xmlns:xsd=<span class="str">"http://www.w3.org/2001/XMLSchema"</span>&gt;
  &lt;xsd:element name="Rootelement" type="wurzel" /&gt;
   &lt;xsd:element name="Bauunternehmen"&gt;
   &lt;xsd:complexType&gt;
      &lt;xsd:complexContent&gt;
         &lt;xsd:extension <span class="kwrd">base</span>=”xsd:<span class="kwrd">string</span>”&gt;
               &lt;xsd:attribute name="Regionalcode" type="xsd:<span class="kwrd">string</span>" /&gt;
         &lt;/xsd:extension&gt;
      &lt;/xsd:complexContent&gt;
   &lt;/xsd:complexType&gt;
   &lt;/xsd:element&gt;
&lt;/xsd:schema&gt;

<u>Beispiel <span class="kwrd">in</span> XML:</u>
&lt;?xml version=”1.0” encoding=”UTF-8”?&gt;
&lt;Rootelement xmlns:xsi=<span class="str">"http://www.w3.org/2000/10/XMLSchema-instance"</span> xsi:noNamespaceSchemaLocation="element.xsd"&gt;
   &lt;Bauunternehmen Regionalcode="asA3555"&gt;...&lt;/Bauunternehmen&gt;
&lt;/Rootelement&gt;
</pre></div>
<p>Attribute haben, anders als Elemente, nur einfache Typen. Nur komplexe Elemente können Attribute enthalten. 
<p>Attribute werden, wenn nichts anderes angegeben ist, nur optional verlangt. 
<p>Liste der Zustände eines Attributs: 
<ul>
<li>use 
<ul>
<li>optional 
<ul>
<li>Attribut muss nicht vorhanden sein</li></ul>
<li>required 
<ul>
<li>Attribut muss vorhanden sein</li></ul>
<li>prohibited 
<ul>
<li>Attribut ist verboten</li></ul></li></ul>
<li>fixed 
<ul>
<ul>
<li>definiert festen Wert</li></ul></ul>
<li>"..." 
<ul>
<ul>
<li>Enthält beliebigen Standardwert (Default) 
<li>Wenn nichts anderes angegeben, wird dieses genommen</li></ul></ul></li></ul>
<p><strong>Achtung</strong>: Fixed und Default dürfen nicht beide definiert werden</p>
<p><b>Syntax</b> 
<p>&lt;xsd:attribute name="<i>name</i>" type="<i>type</i>" use="<i>use</i>" default="<i>default</i>"/fixed="<i>fixed</i>" /&gt; 
<div class="CodeFormatContainer"><pre class="csharpcode">Beispiel:
&lt;xsd:attribute name=”gender” use="required" <span class="kwrd">default</span>="m" type="xsd:<span class="kwrd">string</span>" /&gt;
</pre></div>
