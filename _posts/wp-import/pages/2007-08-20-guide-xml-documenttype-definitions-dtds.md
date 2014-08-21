---
layout: page
title: "Guide: XML (DocumentType Definitions DTDs)"
date: 2007-08-20 21:40
author: robert.muehsig
comments: true
categories: []
tags: []
permalink: /artikel/guide-xml-documenttype-definitions-dtds
---
{% include JB/setup %}

<p align="center"><a target="_blank" href="{{BASE_PATH}}/artikel/guide-xml-basiswissen/" title="Guide:XML (Basiswissen)"><strong>[Aufbauend auf den vorherigen Guide]</strong></a></p>

<h1><u>4. Documenttype Definitions</u></h1>
Die Documenttype Definitionen beschreiben die Struktur von XML- und SGML Dokumenten. Es bestimmt die Struktur von Dokumenten. In einer DTD werden Attribute, Elemente usw. definiert.

Da die DTD ist ein Bestandteil der XML Spezifikation, was allerdings später von vielen kritisiert wurde, da der DTD Syntax kein XML Syntax ist. Für XML Dokumente wurde ein eigene Spezifikation, das XML Schema (oder in kurz: XSD) geschaffen.

Diese XSD verfolgt dasselbe Ziel wie die DTD, ist jedoch etwas komplexer und ist komplett im XML Syntax verfasst.

Da die DTD jedoch trotzdem noch eine Rolle spielt, wird sie hier trotzdem noch behandelt.
 
<h2><u>4.1 "Documenttyp-Definition" (DTD) und Instanzen</u></h2>
Die wenigsten die HTML Dokumente verfassen, werden sich mit der DTD beschäftigt haben, da die DTD für HTML fest in den Händen des W3Cs liegt, allerdings gibt es nun mit XML die Möglichkeit eigene Elemente zu schaffen, welche z.B. aber nur bestimmte Attribute bekommen dürfen.

Einige Beispiele entstammen der XHTML DTD vom W3C, welche sich hier einsehbar ist:

<a href="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd</a>
 
<h3><u>4.1.1 Elementtypen</u></h3>
Die wichtigsten Komponenten einer DTD sind die Element-Deklarationen.

Die Elementtypen weisen einem Element und sein möglicher Inhalt definiert.

Folgende Elementtypen gibt es in einer DTD:
<ul>
	<li>Empty - kein Inhalt</li>
	<li>Any - für beliebigen Inhalt</li>
	<li>, - Reihenfolge</li>
	<li>| - Alternative</li>
	<li>Runde Klammern zum Gruppieren</li>
	<li>Stern für keinmal oder mehrmals</li>
	<li>Plus für einmal oder mehrmals</li>
	<li>Fragezeichen für einmal oder keinmal</li>
	<li>Wird weder Stern, Plus oder Fragezeichen verwendet, muss das Element min. einmal vorkommen</li>
	<li>Texte, welche den Elementen angehören, werden als PCDATA (Parsed Character Data) deklariert.</li>
</ul>
<strong>Syntax</strong>: &lt;!ELEMENT <em>elementname</em> <em>elementtyp</em>&gt;

<u>Beispiel:</u>
&lt;!ELEMENT img EMPTY&gt;
&lt;!ELEMENT table
     (caption?, (col*|colgroup*), thead?, tfoot?, (tbody+|tr+))&gt;
<h3><u>4.1.2 Entities</u></h3>
Wie bereits schon vorhin kurz erwähnt, dienen Entities der Wiederverwendbarkeit. Dabei wird eine bestimmte Zeichenkette festgelegt, welche beim Aufrufen dieser durch eine vorher festgelegte andere Zeichenkette oder ein anderes Dokument ersetzt wird.
<h4><u>4.1.2.1 Interne Entities</u></h4>
Ein internes Entity besteht nur aus dem Namen und der Zeichenkette, welche später eingesetzt werden soll.

<strong>Syntax</strong>: &lt;!ENTITY <em>name</em> "<em>zeichenkette</em>"&gt;

Aufgerufen wird dieses Entity mit einem &amp; und dem namen sowie einem Semikolon.

Syntax: &amp;<em>name</em>;

<style>          <!--  .csharpcode, .csharpcode pre  {  	font-size: small;  	color: black;  	font-family: consolas, "Courier New", courier, monospace;  	background-color: #ffffff;  	/*white-space: pre;*/  }

.csharpcode pre { margin: 0em; }

.csharpcode .rem { color: #008000; }

.csharpcode .kwrd { color: #0000ff; }

.csharpcode .str { color: #006080; }

.csharpcode .op { color: #0000c0; }

.csharpcode .preproc { color: #cc6633; }

.csharpcode .asp { background-color: #ffff00; }

.csharpcode .html { color: #800000; }

.csharpcode .attr { color: #ff0000; }

.csharpcode .alt   {  	background-color: #f4f4f4;  	width: 100%;  	margin: 0em;  }

.csharpcode .lnum { color: #606060; }

--></style>
<pre class="csharpcode"><u>Beispiel:</u> 

&lt;!ENTITY dtag "Deutsche Telekom AG"&gt;</pre>
<p class="CodeFormatContainer">Anwenden würden wir dieses Entity mit "&amp;dtag;"</p>
<p class="CodeFormatContainer">Die Zeichenkette kann im Prinzip alles enthalten: Normale Texte, neue Entitys oder XML.</p>

<pre class="csharpcode"><u>Beispiel:</u> 

&lt;!ENTITY dtag "Deutsche Telekom AG"&gt; 

&lt;!ENTITY tt_link "&lt;a href=”™training.telekom.de”™&gt;Telekom Training&lt;/a&gt;” &gt; 

&lt;!ENTITY division "&amp;dtag; - Telekom Training"&gt;</pre>
<h4 class="CodeFormatContainer"><u>4.1.2.2 Externe Entities</u></h4>
<p class="CodeFormatContainer">Externe Entities verweisen auf den Inhalt von den angegebenen Dateien. Nach dem Namen wird noch notiert, ob dieses Entity öffentlich ("PUBLIC"), d.h. es wird nicht nur auf der Website sondern im ganzen Intranet oder ist vom W3C standardisiert oder es ist nur systemweit ("SYSTEM"). Allerdings spielen diese beiden Sachen keine große Rolle.</p>
<p class="CodeFormatContainer">Syntax: &lt;!ENTITY <em>name</em> SYSTEM/PUBLIC "<em>datei</em>"&gt;</p>

<pre class="csharpcode"><u>Beispiel:</u> 

&lt;!ENTITY kapitel1 SYSTEM "kapitel1.xml"&gt;</pre>
Bei Externen Entities kann man zusätzlich angeben, wenn es um ein nicht analysiertes Entity handelt, d.h. der Inhalt besteht aus beliebigen Daten. In diesem Fall muss eine Notation angegeben werden:
<pre class="csharpcode"><u>Beispiel:</u> 

&lt;!ENTITY BMP_Bildchen SYSTEM "bild.bmp" NDATA bmp&gt;</pre>
<h3><u>4.1.3 Parameter-Entities</u></h3>
Normale Entities werden verwendet, wenn man auf der Website bestimmte Abkürzungen nutzen will. Da sich auch in einer DTD häufig Deklarationen doppeln, wird hier mit sog. Parameter-Entities gearbeitet. Dadurch lassen sich auch externe Daten in die DTD einbinden.

<strong>Syntax</strong>: &lt;!ENTITY % <em>name</em> "<em>zeichenkette</em>"&gt;
<pre class="csharpcode"><u>Beispiel:</u> 

&lt;!ENTITY % headlines "H1|H2|H3|H4|H5|H6|H7"&gt;</pre>
<h3><u>4.1.4 Attribute</u></h3>
Elemente können bestimmte Attribute enthalten. Welches Element, welches Attribut enthält wird in der DTD festgehalten.
<h4><u>4.1.4.1 Attributtypen</u></h4>
<ul>
	<li><strong>CDATA</strong> - steht für beliebigen Inhalt
<ul>
	<li>PCDATA und CDATA sind vom Prinzip her gleich</li>
	<li>In ihnen werden beliebige Texte gespeichert</li>
	<li>Unterschied liegt daran, dass PCDATA vom Parser durchsucht wird und kann zum Beispiel Entities oder XML Daten parsen ("Parsed Character Data").</li>
	<li>In CDATA werden keine Markupzeichen, wie z.B. spitze Klammern erkannt.</li>
</ul>
</li>
</ul>
<pre class="csharpcode"><u>Beispiel <span class="kwrd">in</span> der DTD:</u> 

&lt;!ATTLIST IrgendEinElement 

Sprache CDATA 

&gt; 

<u>Beispiel <span class="kwrd">in</span> der XML Datei:</u> 

&lt;IrgendEinElement Sprache="deutsch123"&gt;Dies hier ist ein Text.&lt;/IrgendEinElement&gt;</pre>
<pre class="csharpcode"> </pre>
<ul>
	<li><strong>ID</strong>
<ul>
	<li>steht für einen eindeutigen Bezeichner</li>
	<li>darf aus Buchstaben und Zahlen und Kombinationen dessen bestehen</li>
</ul>
</li>
</ul>
<pre class="csharpcode"><u>Beispiel <span class="kwrd">in</span> DTD:</u> 

&lt;!ATTLIST IrgendEinElement 

Sprache_id ID 

&gt;<u>Beispiel <span class="kwrd">in</span> der XML Datei:</u> 

&lt;IrgendEinElement Sprache_id="123"&gt;Dies hier ist ein Text.&lt;/IrgendEinElement&gt;</pre>
<ul>
	<li><strong>IDREF</strong>
<ul>
	<li>steht für eine Referenz auf einen Bezeichner</li>
	<li>dient dazu, dass eine ID nicht zweimal vergeben wird, wenn ein Element die augenscheinliche selbe ID vergeben will</li>
</ul>
</li>
</ul>
<pre class="csharpcode"><u>Beispiel <span class="kwrd">in</span> DTD:</u> 

&lt;!ATTLIST Produkt 

Hersteller_id IDREF 

&gt;<u>Beispiel <span class="kwrd">in</span> der XML Datei:</u> 

&lt;Produkt Herstellter_id="123"&gt;Hammer&lt;/Produkt&gt;</pre>
<pre class="csharpcode"> </pre>
<ul>
	<li><strong>NMTOKEN</strong>
<ul>
	<li>ähnelt dem CDATA, hat allerdings ein paar Einschränkungen</li>
	<li>steht für Name Token</li>
</ul>
</li>
</ul>
<pre class="csharpcode"><u>Beispiel <span class="kwrd">in</span> DTD:</u> 

&lt;!ATTLIST IrgendEinElement 

Sprache NMTOKEN 

&gt;<u>Beispiel <span class="kwrd">in</span> der XML Datei:</u> 

&lt; IrgendEinElement Sprache="de DE"&gt;Testtext&lt;/ IrgendEinElement &gt;</pre>
<pre class="csharpcode"> </pre>
<ul>
	<li><strong>Aufzählungen</strong>
<ul>
	<li>Nur angegebene Werte dürfen im Attribut vorkommen</li>
</ul>
</li>
</ul>
<pre class="csharpcode"><u>Beispiel <span class="kwrd">in</span> der DTD:</u> 

&lt;!ATTLIST IrgendEinElement 

Sprache (deutsch|englisch|spanisch) 

&gt;<u>Beispiel <span class="kwrd">in</span> der XML Datei:</u> 

&lt;IrgendEinElement Sprache="deutsch"&gt;Dies hier ist ein Text.&lt;/IrgendEinElement&gt; 

&lt;IrgendEinElement Sprache="englisch"&gt;Nice work!&lt;/IrgendEinElement&gt;</pre>
<h4 class="CodeFormatContainer"><u>4.1.4.2 Attributvorgaben</u></h4>
Mittels Vorgaben kann man Attribute vorbelegen oder sagen, ob das Attribut zwingend vorhanden sein muss oder nicht.
<ul>
	<li>#REQUIRED - Attribut muss angegeben werden</li>
	<li>#IMPLIED - Attribut kann angegeben werden</li>
	<li>#FIXED "..." - Attribut hat immer einen Standardwert</li>
	<li>"..." - Attribut hat bei Nichtzuweisung diesen Standardwert</li>
</ul>
<h4>
<h4><u>4.1.4.3 Attributlisten</u></h4>
In den Listen erfolgt die Zuordnung.

<strong>Syntax</strong>: &lt;!ATTLIST <em>elementname</em>

<em>Name typ Vorgabewert</em>

...

&gt; 
<pre class="csharpcode"><u>Beispiel:</u> 

&lt;!ATTLIST wohnort 

plz   CDATA #REQUIRED 

strasse    CDATA #REQUIRED 

hausnr   CDATA #IMPLIED 

land   CDATA #FIXED "germany" 

&gt;</pre>
<h3>4.1.5. Einbindung der DTD in XML</h3>
<h4>4.1.5.1 Externe Verweise</h4>

<pre class="csharpcode"><u>Beispiel:</u> 

&lt;?xml version=”1.0” standalone=”yes”?&gt; 

&lt;!DOCTYPE lala SYSTEM "lala.dtd”&gt; 

&lt;lala&gt;Dumdidum&lt;/lala&gt;</pre>
<h4>4.1.5.2 Interne Verweise</h4>
</h4>
<pre class="csharpcode"><u>Beispiel:</u> 

&lt;?xml version=”1.0” standalone=”yes”?&gt; 

&lt;!DOCTYPE lala [ &lt;!ELEMENT (#PCDATA) &gt;] &gt; 

&lt;lala&gt;Dumdidum&lt;/lala&gt;</pre>
Der Name muss dem des Wurzelelementes entsprechen!
