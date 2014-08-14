---
layout: page
title: "Guide: XML (Einführung)"
date: 2007-06-18 18:51
author: robert.muehsig
comments: true
categories: []
tags: []
---
<strong>XML - Thema: Einführung</strong>

XML - Schulung: Warum?
Warum schreib ich in einem Blog eigentlich eine Schulung für <a target="_blank" href="http://de.wikipedia.org/wiki/Xml" title="XML">XML</a>? Ist das nicht sinnlos oder gar Zeitverschwendung? Definitiv ja. Hab ich langeweile? Auch... jedenfalls teilweise. Da ich momentan (wie schon viele vor mir) ein Bibliothekprogramm in <a target="_blank" href="http://de.wikipedia.org/wiki/C_Sharp" title="C# Wiki">C#</a> schreibe und auch XML als Datenspeicher verwenden will. Jetzt verflucht mich, aber irgendwie hat es mir XML angetan. Zudem hatte ich die Aufgabe im Rahmen meiner Ausbildung sowieso eine XML Schulung zu verfassen. Da die Dokumentation hier rum liegt, hab ich mir gedacht, pass ich sie doch mal in den Blog rein. Leider hab ich manche "Zitate" etwas unsauber gemacht, daher werd ich wohl jetzt alles nochmal schreiben. Aber ich hab ja Zeit. Falls ihr doch noch Sachen findet, die ich von anderen Seiten "geklaut" habe, dann seid mir bitte nicht gar zu sehr böse. Danke. Von woher ich die Quellen habe, werde ich entweder direkt im Text oder im Anschluss machen.

<em>Quellen</em>

Bücher
- Marco Skulschus, Marcus Wiederstein:
<a target="_blank" href="http://www.amazon.de/XSLT-XPath-HTML-Text-XML/dp/3826615328/ref=sr_1_1/028-3931242-9435702?ie=UTF8&amp;s=books&amp;qid=1182187996&amp;sr=8-1" title="XSLT und XPath für HTML, Text und XML"><em>XSLT und XPath für HTML, Text und XML.</em>
</a>- Henning Behme, Stefan Minter:
<em><a target="_blank" href="http://www.amazon.de/Professionelles-Web-Publishing-Extensible-networking-communications/dp/3827316367/ref=sr_1_1/028-3931242-9435702?ie=UTF8&amp;s=books&amp;qid=1182188101&amp;sr=1-1" title="XML in der Praxis . ">XML in der Praxis, Professionelles Web-Publishing mit der Extensible Markup Language</a></em>
- Horst-Dieter Radke:
<a target="_blank" href="http://www.amazon.de/PC-Spicker-XML-Horst-Dieter-Radke/dp/3815503264/ref=sr_1_1/028-3931242-9435702?ie=UTF8&amp;s=books&amp;qid=1182188136&amp;sr=1-1" title="PC Spicker XML"><em>PC Spicker XML</em> </a>

Internet:
<a href="http://www.wikipedia.de/">www.wikipedia.de</a>
<a href="http://www.obqo.de/w3c-trans/xpath-de-20020226">http://www.obqo.de/w3c-trans/xpath-de-20020226</a>
<a href="http://www.edition-w3c.de/">http://www.edition-w3c.de/</a>

... weitere Quellen könnten noch folgen.
<p align="center"><strong>I Einführung</strong></p>
<p align="left"><strong>1. Was ist XML?</strong></p>
<p align="left">XML ist das Akronym für "Extensible Markup Language". Zu deutsch bedeutet das ungefähr "erweitere Auszeichnungssprache".</p>
XML ist heute ein Standard für die Erstellung von maschinen- und menschenlesbaren Dokumenten. Dies alles wird in Form einer Baumstruktur dargestellt. Der Standard selbst wird vom <a target="_blank" href="http://de.wikipedia.org/wiki/W3c" title="W3C">W3C</a> definiert und ständig erweitert.

XML ist eine Teilmenge von <a target="_blank" href="http://de.wikipedia.org/wiki/SGML" title="SGML Wiki">SGML</a>, welches beides <a target="_blank" href="http://de.wikipedia.org/wiki/Metasprache" title="Metasprachen Wiki">Metasprachen</a> sind.

Beispiel:
<pre>
<pre>&lt;?xml version="1.0" encoding="UTF-8" standalone="yes"?&gt;</pre>
<pre>&lt;addressbuch&gt;</pre>
<pre>Â Â Â Â  &lt;addresse&gt;</pre>
<pre>Â Â Â Â Â Â Â Â Â  &lt;vorname&gt;Ben&lt;/vorname&gt;</pre>
<pre>Â Â Â Â Â Â Â Â Â  &lt;nachname&gt;James&lt;/nachname&gt;</pre>
<pre>Â Â Â Â Â Â Â Â Â  &lt;wohnort&gt;New York&lt;/wohnort&gt;</pre>
<pre>Â Â Â Â  &lt;/addresse &gt;</pre>
<pre>Â Â Â Â  &lt;addresse&gt;</pre>
<pre>Â Â Â Â Â Â Â Â Â  &lt;vorname&gt;Hans&lt;/vorname&gt;</pre>
<pre>Â Â Â Â Â Â Â Â Â  &lt;nachname&gt;Herrman&lt;/nachname&gt;</pre>
<pre>Â Â Â Â Â Â Â Â Â  &lt;wohnort&gt;Dortmund&lt;/wohnort&gt;</pre>
<pre>Â Â Â Â  &lt;/addresse&gt;</pre>
<pre>&lt;/addressbuch &gt;</pre>
</pre>
<addressbuch></addressbuch><addresse></addresse><vorname></vorname><strong>2. Sinn von XML
</strong>
In der heutigen Zeit nimmt die Vernetzung unserer Welt immer mehr zu. Daten werden gesammelt, zusammengefasst und angerufen. Würde jedes Unternehmen eigene Standards einführen, was teilweise so ist, würde dieser Datenaustausch wesentlich gehemmt.Durch den relativ einfachen Aufbau von XML, können Daten in dieser Form überall gelesen, verarbeitet und selbst die unterschiedlichsten Systeme können diese verarbeiten.<strong>3. Das Web und XML
</strong>
3.1 Ersetzt XML HTML
Auf die Frage, ob <a target="_blank" href="http://de.wikipedia.org/wiki/Html" title="HTML">HTML</a> durch XML ersetzt wird, kann man ganz klar mit einem "nein" beantworten. HTML hat allerdings Grenzen was der Vorrat an Elementtypen und zudem drohte der "Standard" durch verschiedene Konzerne (<a target="_blank" href="http://www.microsoft.com/" title="Microsoft">Microsoft </a>oder <a target="_blank" href="http://www.netscape.de/" title="Netscape">Netscape</a>) auseinander zu brechen. Genau an dieser Stelle tritt nun XML in den Vordergrund. Durch XML kann man beliebige Daten speichern, welche dann z.B. wieder durch <a target="_blank" href="http://de.wikipedia.org/wiki/Xhtml" title="XHtml Wiki">(X)HTML </a>dargestellt werden. Näheres dazu wird zu einem späteren Zeitpunkt erklärt. Der große Vorteil von XML ist, dass ich durch Stylesheets im Prinzip unendlich viele Web Dokumente generieren lassen kann.Heute gibt es kaum noch Anwendungen die ohne XML arbeiten. Ähnlich wie HTML lassen sich auch XML-Daten "on the fly" aus Datenbankbeständen erzeugen. Allerdings eignet sich XML besser für die Speicherung von Daten. Insbesondere in objektorientierten Systemen kann man durch den hierarchischen Aufbau wesentlich einfacher objektorientierte Datenbanksysteme abbilden.Der Traum von vielen die XML propagieren ist, dass mit XML ein einheitliches (universelles) Datenformat zu schaffen, was sowohl von Menschen als auch von Maschinen gelesen und verstanden werden kann.

3.2 Unterschie zwischen XML und HTML
XML ist im Gegensatz zu HTML <a target="_blank" href="http://de.wikipedia.org/wiki/Casesensitiv" title="Casesensitiv Wiki">casesensitiv</a>. Dies bedeutet, dass in XML <auto></auto>, &lt;auto&gt; <auto></auto>oder &lt;AUTO&gt; gar &lt;aUtO&gt;Â <auto></auto>3 völlig verschiedene Elemente sind.
In HTML spielt es keine große Rolle ob man nun und dies dann mit schließt.
Zudem hat, wie bereits weiter oben erwähnt, HTML einen begrenzten Satz an Elementen.

Der letzte relativ große Unterschied, vom Sinn eines XMLs mal abzusehen, ist, dass Attribute in XML in Anführungszeichen gesetzt werden müssen. In HTML ist dies nicht unbedingt nötig.

<strong>4. Zusammenhänge zwischen SGML, XML, HTML, CSS, XSL...</strong>

Es gibt zwei Arten von Sprachen, die <a target="_blank" href="http://de.wikipedia.org/wiki/Auszeichnungssprache" title="Auszeichnungssprache Wiki">Auszeichnungssprachen</a>, welche die Daten speichern und die Formatierungssprachen, welche die Formatierung dieser Übernehmen.
Hier sei noch mal der Unterschied zwischen XML und HTML zu beachten: HTML ist eine pure Auszeichnungssprache. XML ist eine Metasprache, was bedeutet dass es, genau wie SGML, eine Spezifikation ist, welche beliebig viele Auszeichnungssprachen, wie z.B. <a target="_blank" href="http://de.wikipedia.org/wiki/Xhtml" title="XHtml Wiki">XHTML</a>, schaffen kann.

Da wir insbesondere später mit DTDs und XSDs (was genau das ist, wird später erklärt) sowie einigen anderen Teilen arbeiten, muss man sich bei dem Arbeiten mit XML folgende 3 großen Teile vorstellen:

Der erste Teil ist die Gültigkeitsprüfung, welche die Regeln des XML Dokumentes enthält.
Der zweite Teil sind die Daten, welche in unserm XML Dokument zu finden sind.
Der dritte Teil befasst sich mit der Formatierung dessen.

Â Â Â Â Â Â Â Â Â Â Â Â  <a target="_blank" href="http://de.wikipedia.org/wiki/Dtd" title="DTD Wiki">DTD</a>Â Â Â Â Â Â Â Â Â Â Â Â Â Â <a target="_blank" href="http://de.wikipedia.org/wiki/XSD" title="XSD Wiki">XSD</a>Â Â Â Â Â Â Â Â  Gültigkeit

Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  <a target="_blank" href="http://de.wikipedia.org/wiki/Xml" title="XML">XML</a>Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  Daten

Â Â Â Â Â Â Â Â Â Â Â Â  <a target="_blank" href="http://de.wikipedia.org/wiki/Cascading_Style_Sheets" title="CSS Wiki">CSS</a>Â Â Â Â Â Â Â Â Â Â Â Â Â Â  <a target="_blank" href="http://de.wikipedia.org/wiki/XSL" title="XSL Wiki">XSL</a>Â Â Â Â Â Â Â Â Â  Formatierung

<strong>5. Geschichtliches über XML</strong>

Das Web drohte vor nicht allzu langer Zeit auseinander zu brechen, was zur Folge hatte, dass die SGML Anhänger und das W3C schnell eine Lösung kommen mussten.

HTML oder gar XML ist im Vergleich zum Browser noch relativ jung. Der erste graphische Browser kam 1990 zum Einsatz.
3 Jahre lang hat sich eine Arbeitsgruppe mit dem Problem der Erweiterbarkeit von HTML beschäftigt.
Der erste Vorschlag zur "Extensible Markup Language" kam 1996 im Rahmen einer SGML Veranstaltung. Auf der World Wide Web Conference 1997 war XML eines der Hauptthemen.
Das komplizierte SGML musste vereinfacht werden und heraus gekommen ist XML, als Teilmenge von SGML.
1998 wurde XML 1.0 zum Standard definiert. Nur ein Jahr später, wurde auch XHTML 1.0 zum Standard.

5.1 SGML
<a target="_blank" href="http://de.wikipedia.org/wiki/SGML" title="SGML Wiki">SGML</a> steht für "Standard Generalized Markup Language", was seit 1986 ein ISO Standard ist.
SGML ermöglicht die Definierung unterschiedlicher Auszeichnungssprachen, wie z.B. HTML. SGML ist der Nachfolger von <a target="_blank" href="http://de.wikipedia.org/wiki/Generalized_Markup_Language" title="GML Wiki">GML</a>, der "Generalized Markup Language".

Ziel der SGML war es, betriebssystemübergreifend Dokumente auszutauschen.

5.2 Unterschied zwischen XML und SGML
Da XML ein Ableger von SGML ist, ist XML natürlich zu SGML kompatibel. Es gibt allerdings einige Unterschiede.

SGML arbeitet mit dem <a target="_blank" href="http://de.wikipedia.org/wiki/Ascii" title="Ascii">ASCII Code</a>, sodass nur ein begrenzter Zeichensatz verfügbar ist. XML arbeitet mit dem <a target="_blank" href="http://de.wikipedia.org/wiki/Unicode" title="Unicode Wiki">UNICODE</a>, welcher ein wesentlich größeren Zeichensatz hat.
Zudem sind in XML so genannte Empty-Tag-Elemente erlaubt, allerdings müssen diese durch ein "/" beendet werden. Beispiel ist das img Tag aus HTML/XHTML:
HTML (was SGML repräsentiert)

&lt;img src="lala.jpg" mce_src="lala.jpg"&gt;

XHTML (was XML repräsentiert)

&lt;img src="lala.jpg" mce_src="lala.jpg" /&gt;

Desweiteren ist XML Casesensitiv, d.h. Groß- und Kleinschreibung wird beachtet.
<auto></auto>entspricht nicht <auto></auto>oder gar <auto></auto>. Aus XML Sicht sind das 3 verschiedene Elemente. In SGML spielt die Groß- und Kleinschreibung keine Rolle.

Ein letzter Punkt ist, dass der Doctype in SGML zwingend ist, hingegen bei der XML nur optional. Was das genau ist, erfahrt ihr auf den folgenden Seiten.

<strong>6. Die 10 Aussagen der Syntaxbeschreibung</strong>
Die Entwickler von XML haben 10 Aussagen entworfen um den Sinn von XML zu festigen:

XML soll sich im Internet auf einfache Weise nutzen lassen.
XML soll ein breites Spektrum von Anwendungen unterstützen.
XML soll zu SGML kompatibel sein.
Es soll einfach sein, Programme zu schreiben, die XML - Dokumente verarbeiten.
Die Anzahl optionaler Merkmale in XML soll minimal sein, idealer weise Null.
XML - Dokumente sollten für Menschen lesbar und angemessen verständlich sein.
Der XML - Entwurf sollte zügig abgefasst werden.
Der Entwurf von XML soll formal und präzise sein.
XML - Dokumente sollen leicht zu erstellen sein.
Knappheit von XML - Markup ist von minimaler Bedeutung.

<strong>7. 3 Gebote</strong>
In Anlehnung an die 10 Aussagen, sollte man bei der Generierung von XML Dokumenten 3 Gebote einhalten:

Du sollst Deine Elemente immer schließen.
Du sollst Attributwerte immer in doppelten Anführungszeichen setzen.
Schachtel Deine Elemente immer hierarchisch.

<strong>8. Auszeichnung</strong>
Da XML zu den Auszeichnungssprachen gehört, müssen wir natürlich diese Begrifflichkeit kurz erklären.
Eine Auszeichnung dient der Strukturierung eines Textes oder auch Dokumentes.

Auszeichnungen kann man in 3 große Teile aufspalten.

8.1 Physische Auszeichnung
Diese Auszeichnung bezieht sich auf die Layoutformatierung eines Textes.

Beispiel:
Wie ein Text dargestellt werden soll: kursiv, fett, unterstrichen?

8.2 Logische Auszeichnung
Diese Auszeichnung formatiert den Text auf logische Art und Weise.

Beispiel:
Der Text ist ein Zitat oder eine Überschrift.

8.3 Semantische Auszeichnung
Diese Auszeichnung wird am meisten in XML verwendet und gewinnt daher an Einfluss.

Die semantische Auszeichnung kann man sich wie eine Datenbank vorstellen und definiert nur die Struktur des Textes. Wie dieser formatiert und dargestellt wird, hat hier keine Bedeutung.
<p align="center"><strong><a href="http://code-inside.de/blog/artikel/guide-xml-basiswissen/">[Fortsetzung: XML Basiswissen]</a></strong></p>
