---
layout: page
title: "Guide: XML (XML Schema XSD - Teil 3)"
date: 2007-08-21 21:41
author: robert.muehsig
comments: true
categories: []
tags: []
---
{% include JB/setup %}
<h4><u>4.2.2.5 Elemente für Schlüssel</u></h4> <p>In der XSD gibt ebenso wie in der DTD die Möglichkeit einmalige Schlüssel, ähnlich wie der Index in einer Datenbank, zu definieren.  <p>In XSD gibt es fünf Arten, die hier kurz vorgestellt werden:  <ul> <li>xsd:key  <ul> <li>eindeutige Schlüsselwerte</li></ul> <li>xsd:field  <ul> <li>gibt Gültigkeitsbereich an</li></ul> <li>xsd:unique  <ul> <li>optional, muss aber eindeutig sein</li></ul> <li>xsd:refkey  <ul> <li>Referenz auf den Schlüssel</li></ul> <li>xsd:selector  <ul> <li>gibt Gültikeitsbereich mit XPath an</li></ul></li></ul> <p>&nbsp;</p> <h4><u>4.2.2.6 Modularisierung</u></h4> <p>Modularisierung in der XSD erlaubt, dass gewisse Teile immer wieder verwendet werden können und somit diese wesentlich besser nutzen kann. XSD kennt drei Arten, eine andere XSD zu importieren.  <p>&nbsp;</p> <p><b><u>xsd:include</u></b>  <p>Typdefinitionen innerhalb eines Namensraumes, die auf mehrere Dateien verteilt sind, lassen sich mittels include zusammenfügen.  <div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;schema xmlns=<span class="str">"http://www.w3.org/2001/XMLSchema"</span>
         xmlns:pcTeile=<span class="str">"http://www.example.com/pcTeile"</span>
         targetNamespace=<span class="str">"http://www.example.com/pcTeile"</span>&gt;
   ...
   &lt;include schemaLocation=<span class="str">"http://www.example.com/schemata/harddisk.xsd"</span>&gt;
   &lt;include schemaLocation=<span class="str">"http://www.example.com/schemata/ram.xsd"</span>&gt;
   ...
 &lt;/schema&gt;
</pre></div>
<p>&nbsp; 
<p><b><u>xsd:import</u></b> 
<p>Der import-Tag erlaubt es, Elemente aus anderen Namensräumen zu importieren, mit einem Präfix zu versehen und damit Schema-Bestandteile aus unterschiedlichen Namespaces wiederzuverwenden.<br>Annahme ist, dass es einen definierten Typ "superTyp" in "pcTeile" gibt. 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;schema xmlns=<span class="str">"http://www.w3.org/2001/XMLSchema"</span>
         xmlns:pcTeile=<span class="str">"http://www.example.com/pcTeile"</span>
         targetNamespace=<span class="str">"http://www.example.com/firma"</span>&gt;
   ...
   &lt;import <span class="kwrd">namespace</span>=<span class="str">"http://www.example.com/pcTeile"</span>/&gt;
   ...
     &lt;...
       &lt;xsd:attribute name=<span class="str">"xyz"</span> type=<span class="str">"pcTeile:superTyp"</span>/&gt;
     .../&gt;
   ...
 &lt;/schema&gt;
</pre></div>
<p><b><u>xsd:redefine</u></b> 
<p>Gleiches Beispiel wie gerade. Annahme es gäbe einen <i>complexType</i> "Hersteller" im Schema "harddisk.xsd"". 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;schema xmlns=<span class="str">"http://www.w3.org/2001/XMLSchema"</span>
         xmlns:pcTeile=<span class="str">"http://www.example.com/pcTeile"</span>
         targetNamespace=<span class="str">"http://www.example.com/pcTeile"</span>&gt;
   ...
   &lt;redefine schemaLocation=<span class="str">"http://www.example.com/schemata/harddisk.xsd"</span>&gt;
     &lt;complexType name=<span class="str">"Hersteller"</span>&gt;
       &lt;complexContent&gt;
         &lt;restriction <span class="kwrd">base</span>=<span class="str">"pcTeile:Hersteller"</span>&gt;
           &lt;xsd:sequence&gt;
             &lt;xsd:element name=<span class="str">"hersteller"</span> type=<span class="str">"xsd:string"</span> minOccurs=<span class="str">"10"</span> maxOccurs=<span class="str">"10"</span>/&gt;
           &lt;/xsd:sequence&gt;
         &lt;/restriction &gt;
       &lt;/complexContent&gt;
     &lt;/complexType&gt;
   &lt;redefine/&gt;
   ...
   &lt;include schemaLocation=<span class="str">"http://www.example.com/schemata/ram.xsd"</span>&gt;
   ...
 &lt;/schema&gt;
</pre></div>
<p>&nbsp; 
<h4><u>4.2.2.7 Dokumentation</u></h4>
<p>In der XSD gibt es die Möglichkeit zu den einzelnen Elementen oder auch generell zur XSD eine Art Kommentare zu erstellen. Diese werden hier kurz aufgelistet. 
<ul>
<li><b><u>xsd:annotation</u></b> 
<ul>
<li>sind Anmerkungen</li></ul>
<li><b><u>xsd:documentation</u></b> 
<ul>
<li>dient der Dokumentation</li></ul>
<li><b><u>xsd:appinfo</u></b> 
<ul>
<li>gibt Information über Applikation</li></ul></li></ul>
<p>&nbsp; 
<h4><u>4.2.2.8 Facetten</u></h4>
<p>Beim Thema der Beschränkung ist schon kurz der Begriff der Facetten gefallen. In der XSD gibt mehrere Arten der Beschränkung. 
<ul>
<li><b><u>xsd:length</u></b> 
<ul>
<li>Gibt die genaue Länge eines Strings an</li></ul>
<li><b><u>xsd:maxLength</u></b> 
<ul>
<li>Maximale Länges eines Strings</li></ul>
<li><b><u>xsd:minLength</u></b> 
<ul>
<li>Minimale Länge eines Strings</li></ul>
<li><b><u>xsd:pattern</u></b> 
<ul>
<li>Reguläre Ausdrücke</li></ul>
<li><b><u>xsd:maxExclusive</u></b> 
<ul>
<li>Setzt eine obere Schranke für numerische Werte. Werte müssen kleiner sein.</li></ul>
<li><b><u>xsd:minExclusive</u></b> 
<ul>
<li>Setzt eine untere Schranke für numerische Werte. Werte müssen größer sein.</li></ul>
<li><b><u>xsd:minInclusive</u></b> 
<ul>
<li>Setzt eine untere Schranke für numerische Werte. Werte müssen größer oder gleich groß sein.</li></ul>
<li><b><u>xsd:maxInclusive</u></b> 
<ul>
<li>Setzt eine obere Schranke für numerische Werte. Werte müssen kleiner oder gleich groß sein.</li></ul>
<li><b><u>xsd:enumeration</u></b> 
<ul>
<li>Definiert eine Liste möglicher Werte</li></ul>
<li><b><u>xsd:whiteSpace</u></b> 
<ul>
<li>Definiert wie white Spaces behandelt werden sollen</li></ul>
<li><b><u>xsd:totalDigits</u></b> 
<ul>
<li>Gibt die exakte Anzahl der Ziffern an.</li></ul>
<li><b><u>xsd:fractionDigits</u></b> 
<ul>
<li>Definiert die max. Erlaubten Dezimalstellen</li></ul></li></ul>
<p>&nbsp;</p>
<h3><u>4.2.3 Datentypen</u></h3>
<p>Komplexe Datentypen haben wir ja schon kennen gelernt, aber die Frage, welche Datentypen direkt von der XSD unterstützt werden, ist noch nicht ganz geklärt. 
<p>XML Schema stellt einige einfache Datentypen bereit, welche auch schon aus anderen Programmiersprachen bekannt sind. 
<p>Hier ein kleine Auswahl über die wichtigsten Datentypen: 
<ul>
<li>string - "Test" 
<li>decimal - 23.3 
<li>boolean - true/false 
<li>data - Jahr/Monat/Tag (2006-12-05) 
<li>time - Stunde/Minute/Sekunde/Hundertstel (21:03:43.03) 
<li>datetime - Jahr/Monat/Tag Stunde/Minute/Sekunde (2006-02-23T23:23:23) "T"=Trennzeichen 
<li>float - -23.6 
<li>anyURI - eine URI (<a href="http://www.heise.de/">http://www.heise.de</a>) 
<li>gYearMonth - Jahr/Monat (2005-12) 
<li>gMonthDay - Monat/Tag (12-05) 
<li>gYear - Jahr (2005) 
<li>gMonth - Monat (12) 
<li>gDay - Tag (12) 
<li>hexBinary - Hexadezimaler Wert (12EA) 
<li>language - Sprachbezeichnung (de-DE) 
<li>QName - Qualifizierter Name innerhalb eines Namensraumes 
<li>ID - Identifikationsattribut innerhalb eines XML 
<li>IDREF - Referenz auf ID 
<li>Integer - 12 
<li>positivInteger - 12 
<li>negativInteger - -12 
<li>long - -9223372036854775808 bis 9223372036854775808 
<li>int - -2147483648 bis 2147483647 32-Bit Integer 
<li>byte - -127 bis 128 8-Bit Integer</li></ul>
<p>&nbsp;</p>
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;?xml version=<span class="str">"1.0"</span> encoding=<span class="str">"ISO-8859-1"</span>?&gt;
&lt;xsd:schema xmlns:xsd=<span class="str">"http://www.w3.org/2000/10/XMLSchema"</span> elementFormDefault=<span class="str">"qualified"</span>&gt;
   &lt;xsd:element name=<span class="str">"p"</span> type=<span class="str">"xsd:string"</span>/&gt;
&lt;/xsd:schema&gt;
</pre></div>
<p>&nbsp;</p>
<h3><u>4.2.4 Namensräume in der XSD</u></h3>
<p>Namensräume, welche in dem XML Dokument angeben werden, finden sich auch in der XSD wieder. 
<p>Der vollständige Namespace wird im Attribut "targetNamespace" festgehalten. 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;schema targetNamespace=<span class="str">"http://www.example.com/BEST"</span>/&gt;
...
&lt;/schema&gt;
</pre></div>
<p>&nbsp;</p>
<h2><u>4.3 Andere Schemaarten</u></h2>
<p>&nbsp;</p>
<p>Die DTD und die XSD sind direkt vom W3C, allerdings gibt es noch zwei andere bekannte Schemasprachen, welche auch auf XML aufbauen. 
<ul>
<li>Relax NG 
<li>WSDL</li></ul>
