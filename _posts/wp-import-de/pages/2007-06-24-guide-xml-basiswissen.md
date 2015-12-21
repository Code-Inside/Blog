---
layout: page
title: "Guide: XML (Basiswissen)"
date: 2007-06-24 21:51
author: Robert Muehsig
comments: true
categories: []
tags: []
permalink: /artikel/guide-xml-basiswissen
---
{% include JB/setup %}
<strong>XML - Thema: Basiswissen</strong>

Was bedeutet Basiswissen bei XML? Gute Frage. Daher ist meine Schulung sowieso nur in 2 große Hauptteile gegliedert (Einführung und Basiswissen). Mag etwas sinnlos sein, aber egal.

Heute geht es darum: Was ist eigentlich XML? Wie definiert man es und was gibt es für Fachtermini zu dem Thema?

Da dieser Teil "Basiswissen" enorm groß ist - vor uns liegen noch Themen wie XML <a target="_blank" href="http://de.wikipedia.org/wiki/Dtd" title="DTD Wiki">DTD</a>s, <a target="_blank" href="http://de.wikipedia.org/wiki/XSD" title="Wiki XSD">XSD</a>, <a target="_blank" href="http://de.wikipedia.org/wiki/XPATH" title="XPath Wiki">XPath</a> &amp; <a target="_blank" href="http://de.wikipedia.org/wiki/Xslt" title="XSLT WIki">XSLT</a>. Vielleicht - aber die Chancen sind äußerst gering. Mach ich einen 3 großen Teil: XML in <a target="_blank" href="http://de.wikipedia.org/wiki/.NET" title=".NET Wiki">.NET</a>. Ist ein sehr spannendes Thema, welches sich auch lohnen würde aufzuschreiben. Lassen wir uns überraschen.
<p align="center"><strong>II Basiswissen</strong></p>
<strong>1. Interpretation von XML</strong>
<strong>1.1 Clientseitige Interpretation</strong>
Beim <a target="_blank" href="http://de.wikipedia.org/wiki/Client" title="Client Wiki">Clientseitigen</a> XML Interpretieren, bekommt der Client das XML Dokument direkt vom Server geschickt. Nun hat der Client verschiedene Möglichkeiten das Dokument zu formatieren um es in die gewünschte vorm zu bringen, z.B. HTML.

Allerdings ist es heute, im Jahre 2006, noch nicht ganz unproblematisch, ein XML Dokument durch den Browser parsen zu lassen um am Ende die gewünschte Website zu sehen.

Später werden noch einige Beispiele dazu folgen.

<strong>1.2 Serverseitige Interpretation</strong>
Durch "Content Negotiaten" spricht sich der Server mit dem Client ab, ob dieser XML akzeptiert oder nicht. Wenn dies der Fall ist, wird das XML Dokument Clientseitig durch den Browser geparst. Falls der Client dies aber nicht unterstützt, liefert der Server in den meisten Fällen ein HTML Dokument direkt an den Client, da dies alle Browser beherrschen.

Diese Variante ist in der heutigen Zeit, wohl die am meisten verwendete, da man noch nicht genau sagen kann, wie ein Browser XML parst.

Beispiele dazu werden ebenso später folgen.

<strong>2. Grundlegendes für das Verständnis
2.1 XML Deklaration</strong>

Beispiel:
<pre>&lt;?xml version="1.0" encoding= "EUC-JP" standalone = "yes"?&gt;</pre>
Hinter dem ?xml werden so genannte Pseudo-Attribute erwartet. Die XML Spezifikation enthält momentan 3 solcher Pseudo-Attribute:

- Version:
    - Sollte immer Angegeben sein.
    - Enthält XML-Spezifikationsversion
    - 1.0 oder 1.1 sind momentan sinnvolle Werte
- Encoding:
    - Bestimmt Kodierung des XML
    - UTF 8 ist Standard
    - Auch muss das Attribut vom Parser angenommen werden.
- Standalone:
    - Selten verwendet
    - Yes oder No sind die einzig gültigen Werte
    - Yes wird verwendet, wenn Parser externe DTD (oder XSD) ignoriert werden soll

<strong>2.2 Fachtermini</strong>
Da in den folgenden Kapiteln immer wieder bestimmte "Fachwörter" auftauchen, hier mal eine kurze Erklärung.

<em>Wohlgeformtheit:</em> Ein XML Dokument, welche alle Regeln der Spezifikation einhält ist wohlgeformt ("well formed").

<em>Gültigkeit:</em> Für den Datenaustausch über XML ist es wichtig, Regeln für das Erstellen von XML Dokumenten zu erstellen. Regeln stehen entweder in der DTD oder in einer XSD. Wenn das XML Dokument diese Regeln einhält, ist es gültig ("valid").

<strong>2.2.1 Parser</strong>
<a target="_blank" href="http://de.wikipedia.org/wiki/Parser" title="Parser Wiki">Parser</a> sind Programme oder Programmteile, welche das XML Dokument auslesen, interpretieren. Kontrolliert der Parser auch die Gültigkeit, nennt man ihn "validierender Parser".

Momentan gibt es 2 große "Parserarten".

Die erste Parserart hat sich zum quasi Standard durchgesetzt. Genannt wird diese Art "SAX", was voll ausgesprochen <a target="_blank" href="http://de.wikipedia.org/wiki/Simple_API_for_XML" title="SAX Wiki">Simple API for XML</a> heisst.
SAX ließt XML Dokument über sequentiellen Datenstrom und ruft im Standard definierte Ereignisse vorgegebene Rückruffunktionen auf. Dadurch ist SAX zustandslos und erlaubt keinen freien Zugriff auf alle Inhalte. Das ist insbesondere für große XML Dateien praktisch.

Die zweite Art nennt sich <a target="_blank" href="http://de.wikipedia.org/wiki/Document_Object_Model" title="DOM Wiki">DOM</a>, was auch schon aus z.B. <a target="_blank" href="http://de.wikipedia.org/wiki/Javascript" title="Javascript Wiki">Javascript </a>bekannt sein dürfte. DOM ist ein <a target="_blank" href="http://de.wikipedia.org/wiki/W3c" title="W3C Wiki">W3C Standard</a>, welcher voll ausgesprochen Document Object Model heisst. DOM liesst zuerst das komplette XML Dokument ein und bildet den Strukturbaum intern ab. Vorteil davon ist, dass ich auf jedes Element Einfluss nehmen kann und dadurch freien Zugriff auf alle Teile meines XMLs habe und jederzeit verändern kann.

Beide Parserarten haben freie Schnittstellen, sodass bereits für beide Arten in fast allen gängigen Programmiersprachen Zugriffsmöglichkeiten bestehen.

<strong>2.2.2 Delimitierung</strong>
In einigen Quellen ist von Delimitierung die Rede, was eigentlich recht schnell erklärt ist. Die Delimitierung ist die Abgrenzung zwischen den Tags und den Inhalten dessen, sprich die "&lt;" und "&gt;" Klammer.

<strong>2.2.3 Tags und Elemente</strong>
Tags repräsentieren meistens Elemente, allerdings muss man bei der Wahl eines Tags bestimmte Regeln einhalten.

Der Tag muss mit Buchstaben (a-z, A-Z) oder mit Unterstrich (_) anfangen. Zahlen sind nicht erlaubt.
Nach der Regel darf nach dem ersten Zeichen wieder Buchstaben (a-z, A-Z), Unterstrich (_), Zahlen (0-9) oder bestimmte Interpunktionen (.,,;) verwenden.
Nicht erlaubt sind Leerzeichen.
Wie bereits erwähnt, sind Elemente und Tags casesensitive.

Jedes Element beginnt mit &lt;tagName&gt; <tag-name></tag-name>und endet mit &lt;/tagName&gt; .

<em>Beispiel aus XHTML:</em>

&lt;p&gt;Das ist toll.&lt;/p&gt;

Ausnahmen werden als Empty-Element-Tag bezeichnet und sehen so aus: <tag-name></tag-name>

<em>Beispiel aus XHTML:</em>

&lt;img src="bild.jpg" alt="Bild" /&gt;

<strong>Reservierte Zeichen:</strong>

In XML sind 4 Zeichen reserviert. Diese vier Zeichen sind:
"&lt;", "&gt;", das Apostroph und die Anführungszeichen. Für diese Zeichen gibt es, ähnlich wie in HTML die Umlaute, vordefinierte Entities:

&lt; = &lt;
&gt; = &gt;
Apostroph = &amp;apos;
Anführungszeichen = "

<strong>2.2.4 Tags und Elemente</strong>
Wie in fast jeder Sprache, gibt es auch in XML die Möglichkeit Kommentare zu setzen:

&lt;!-- Das ist ein gar lustiger Kommentar. --&gt;

<strong>2.2.5 Attribute</strong>

XML - Attribute werden direkt in den Elementtag geschrieben, welche Metainformationen beinhalten.

Attributwerte werden in "" geschrieben.

Nun muss man allerdings drauf achte, wann man ein Attribute einem Tag zuordnet oder ob man direkt ein neues Element unterm dem Element zuordnet.

Um zu verdeutlichen was ich meine, hier kurze Beispiele:

<em>Beispiel mit Informationen in den Attributen:</em>
<pre>&lt;person id="01231233328654" lastlogin="05.04.06"&gt; 
     &lt;vorname&gt;Ben&lt;/vorname&gt; 
     &lt;nachname&gt;James&lt;/nachname&gt; 
     &lt;wohnort&gt;New York&lt;/wohnort&gt; 
&lt;/person&gt;</pre>
<em>Beispiel mit Informationen als neue Elemente:</em>
<pre>&lt;?xml version="1.0" encoding="UTF-8" standalone="yes"?&gt;</pre>
<pre>&lt;person&gt; 
    &lt;lastlogin&gt;05.04.06&lt;/lastlogin&gt; 
    &lt;id&gt;01231233328654&lt;/id&gt; 
    &lt;vorname&gt;Ben&lt;/vorname&gt; 
    &lt;nachname&gt;James&lt;/nachname&gt; 
    &lt;wohnort&gt;New York&lt;/wohnort&gt; 
&lt;/person&gt;</pre>
Es gibt dazu keine allgemeingültige Regel, wann man was einsetzt, da es ganz vom Verwendungszweck abhängt. Man sollte allerdings den Sinn des XMLs auch ohne die Attribute verstehen, da dies nur extra Informationen darstellen sollen.Im kommenden Kapitel werden uns die Attribute auch in der DTD und in der XSD begegnen.

<strong>2.2.6 URI &amp; URL</strong>
In XML reden wir meistens von der <a target="_blank" href="http://de.wikipedia.org/wiki/Uniform_Resource_Identifier" title="URI Wiki">URI</a> ("Uniform Ressource Identifier") gesprochen, hingegen ist den meisten nur die <a target="_blank" href="http://de.wikipedia.org/wiki/Uniform_Resource_Locator" title="URL Wiki">URL</a> ("Uniform Ressource Locator").

Die URL ist eine Teilmenge von der URI, allerdings kann man beide nicht einfach auseinanderhalten.

"http://www.test.de" könnte eine URL oder URI sein.

Unterschied besteht in dem Sinn. Die URL bezieht sich mehr auf den Speicherort des Dokumentes ("... Locator") und ist in der Regel eine Internetadresse.

Die URI identifiziert die Ressource und ist eine allgemeine Architektur zur Lokalisierung von Dokumenten. Die URI ist nicht auf Ressourcen im Internet beschränkt.

Wenn wir heute in XML von der URI sprechen, ist es meistens die URL.

<strong>3. Namensräume</strong>

Insbesondere in größeren Projekten, wird es früher oder später Namensdopplungen geben, wo sie den Sinn entstellen. Als Beispiel haben verwenden wir in einer XML Datei folgendes:

Beispiel:
<pre>&lt;!--Adresse 1 --&gt;</pre>
<pre>&lt;adresse&gt; 
    &lt;strasse&gt;Blabla&lt;/strasse&gt; 
    &lt;hausnummer&gt;42&lt;/hausnummer&gt; 
    &lt;plz&gt;15023&lt;/plz&gt; 
    &lt;ort&gt;Hinterblubdorf&lt;/ort&gt; 
&lt;/adresse&gt; </pre>
<pre>&lt;!--Adresse 2 --&gt;</pre>
<pre>&lt;rechner&gt; 
    &lt;domain&gt;bla.de&lt;/domain&gt; 
    &lt;name&gt;namensblabla&lt;/name&gt; 
    &lt;adresse&gt;127.0.0.1&lt;/adresse&gt; 
&lt;/rechner&gt;</pre>
Wie sie hier sehen, wir das Element "adresse” 2 mal gebraucht und beides mal in einem anderen Zusammenhang. Will man unterschiedlich gemeinte Elemente in einem Dokument benutzen, was ja bei großen Projekten durchaus vorstellbar ist, braucht man <a target="_blank" href="http://de.wikipedia.org/wiki/Namensr%C3%A4ume" title="Namensräume Wiki">Namensräume</a>.In der XML sind Namensräume an URIs gebunden. Um einen Namespace zu definieren wird "xmlns", der Präfix und die zugehörige URI angegeben. Der Präfix "xml" ist reserviert und kann daher nicht neu definiert werden.

Beispiel:
<pre>&lt;x xmlns:test='http://test.org/schema'&gt; 
    &lt;!-- Das "test"-Präfix wird für das Element "x" und Inhalt an http://test.org/schema gebunden. --&gt; 
&lt;/x&gt; </pre>
Der QName ist eine Zusammensetzung aus dem Präfix und dem lokalen Namen. 

"Default Namespaces" können verwendet werden, wenn ein Namensraum häufiger als andere verwendet wird. Allerdings kommen damit einige Parser und Browser nicht vollständig zurecht.

Beispiel:
<pre>&lt;x xmlns:test='http://test.org/schema'&gt; 
    &lt;test:y&gt;Dies hier ist mit Namespacepräfix.&lt;/test:y&gt; 
&lt;/x&gt;</pre>
<pre>&lt;default xmlns='http://test.org/schema'&gt; 
    &lt;test&gt;Hier wird der default Namespace verwendet, welcher festgelegt wurde.&lt;/test&gt; 
&lt;/default&gt;</pre>
Damit unser oberes Beispiel funktionieren kann, müssen wir nun ein paar kleine Veränderungen durchführen. 

Beispiel:
<pre>&lt;!--Adresse 1 --&gt;</pre>
<pre>&lt;adresse xmlns:adresse="http://www.test.de/schema"&gt; 
    &lt;adresse:strasse&gt;Blabla&lt;/adresse:strasse&gt; 
    &lt;adresse:hausnummer&gt;42&lt;/adresse:hausnummer&gt; 
    &lt;adresse:plz&gt;15023&lt;/adresse:plz&gt; 
    &lt;adresse:ort&gt;Hinterblubdorf&lt;/adresse:ort&gt; 
&lt;/adresse&gt;</pre>
<pre>&lt;!--Adresse 2 --&gt;</pre>
<pre>&lt;rechner xmlns:rechner="http://www.test.de/schema"&gt; 
    &lt;rechner:domain&gt;bla.de&lt;/rechner:domain&gt; 
    &lt;rechner:name&gt;namensblabla&lt;/rechner:name&gt; 
    &lt;rechner:adresse&gt;127.0.0.1&lt;/rechner:adresse&gt; 
&lt;/rechner&gt;</pre>
<pre> </pre>
Der Präfix ist im Prinzip nichts anderes als eine Erweiterung der URI.

Statt rechner="http://www.test.de/schema" könnte man auch "http://www.test.de/schema/rechner" sagen.
<p align="center"><a href="{{BASE_PATH}}/artikel/guide-xml-documenttype-definitions-dtds/" title="Code-Inside: Guide XML DTDs"><strong>[Fortsetzung: XML (DocumentType Definitions DTDs)]</strong></a></p>
