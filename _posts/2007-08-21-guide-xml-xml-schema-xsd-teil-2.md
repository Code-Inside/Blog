---
layout: page
title: "Guide: XML (XML Schema XSD - Teil 2)"
date: 2007-08-21 22:10
author: robert.muehsig
comments: true
categories: []
tags: []
---
{% include JB/setup %}
<h4><u>4.2.2.3 Definition von Typen</u></h4>
<p>Jedem Element und Attribut werden Typen zugeordnet. In der XSD gibt es einfache ("simpleType") und komplexe("complexType") Typen. 
<p><strong><u>Einfache Typen "simpleType":</u></strong> 
<p>Der "simpleType" definiert einen einfachen Typ, welcher bereits vordefinierte Typen, wie z.B. xsd:string, xsd:int etc. enthält. 
<p>Es ist auch möglich, eigene einfache Typen zu schaffen, allerdings müssen diese auf einfachen, schon vordefinierten Typen bestehen und diese einschränken. 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel <span class="kwrd">in</span> XSD:</u>
&lt;?xml version=”1.0” encoding=”UTF-8”?&gt;
&lt;xsd:schema xmlns:xsd=<span class="str">"http://www.w3.org/2001/XMLSchema"</span>&gt;
...
&lt;xsd:simpleType name="waehrung"&gt;
   &lt;xsd:restriction <span class="kwrd">base</span>=”xsd:<span class="kwrd">string</span>”&gt;
            &lt;!--Facette --&gt;
   &lt;/xsd:restriction&gt;
   &lt;/xsd:simpleType&gt;
&lt;/xsd:schema&gt;
</pre></div>
<p>&nbsp;</p>
<p>In dem Falle haben wir einen einfachen Typ namens "waehrung" geschaffen, welcher über xsd:restriction Beschränkungen enthält, allerdings basiert ("base") dieser Typ "waehrung" auf den vordefinierten Typ "xsd:string", wobei dann durch so genannte Facetten die Beschränkung erfolgt. 
<p>&nbsp;</p>
<p><strong><u>Komplexe&nbsp;Typen "complexType":</u></strong></p>
<p>Komplexe Datentypen erlauben in XML die Kindelemente eines Elementes zu beschreiben. 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;xsd:element name=<span class="str">"Name"</span> type=”name”&gt;
   &lt;xsd:complexType&gt;
      &lt;xsd:sequence&gt;
         &lt;xsd:element name=<span class="str">"Vorname"</span> type=<span class="str">"xsd:string"</span>/&gt;
         &lt;xsd:element name=<span class="str">"Nachname"</span> type=<span class="str">"xsd:string"</span>/&gt;
        &lt;/xsd:sequence&gt;
   &lt;/xsd:complexType&gt;
&lt;/xsd:element&gt;
</pre></div>
<p>Hiermit weise ich dem Element "Name" den Typ "Name" zu. Da es diesen Datentyp noch nicht gibt, muss er erst beschrieben werden, welche Elemente er enthält. 
<p>Das hier angegebene Beispiel bedeutet, dass das Element "Name", 2 Kindelemente hat. 
<p><strong><u>Einfacher Inhalt "simpleContent":</u></strong></p>
<p>Der "simpleContent" definiert einen einfachen Inhalt, was bedeutet, dass er nur Text enthalten darf. 
<p><strong><u>Komplexer Inhalt "complexContent":</u></strong></p>
<p>Der "complexContent" definiert einen komplexen Inhalt, was bedeutet, dass er Text, Attribute und andere Elemente enthalten darf. 
<p>&nbsp;</p>
<h4><u>4.2.2.4 Definition des Inhaltes</u></h4>
<p>&nbsp;</p>
<h5><strong>4.2.2.4.1 Sequenz</strong></h5>
<p>Merkmale:</p>
<ul>
<li>Elemente müssen der Reihe nach vorkommen. 
<li>Falls keine anderen Werte über minOccurs oder maxOccurs angegeben wird, muss das Element einmal vorkommen.</li></ul>
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;xsd:element name=<span class="str">"Anschrift"</span> type=”anschrift”&gt;
   &lt;xsd:complexType name=”anschrift”&gt;
      &lt;xsd:sequence&gt;
         &lt;xsd:element name=<span class="str">"wohnort"</span> type=<span class="str">"xsd:string"</span>/&gt;
         &lt;xsd:element name=<span class="str">"plz"</span> type=<span class="str">"xsd:int"</span>/&gt;
         &lt;xsd:element name=<span class="str">"strasse"</span> type=<span class="str">"xsd:string"</span>/&gt;
         &lt;xsd:element name=<span class="str">"nr"</span> type=<span class="str">"xsd:int"</span>/&gt;
         &lt;xsd:element name=<span class="str">"name"</span> type=<span class="str">"xsd:string"</span>/&gt;
        &lt;/xsd:sequence&gt;
   &lt;/xsd:complexType&gt;
&lt;/xsd:element&gt;
</pre></div>
<p>&nbsp;</p>
<h5><strong>4.2.2.4.2 Choice</strong></h5>
<p>Merkmale:</p>
<ul>
<li>Aus einer Anzahl von Elementen darf, falls kein anderer Wert über Max/MinOccurs gesetzt, ein Element vorkommen. Ansonsten auch mehrere möglich. 
<li>Reihenfolge beliebig. 
<li>Durch das MaxOccurs ist es möglich zu sagen, dass Elemente mehrfach und die Reihenfolge beliebig ist</li></ul>
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;xsd:element name=<span class="str">"Tier"</span> type=”tier”&gt;
   &lt;xsd:complexType name=”tier”&gt;
      &lt;xsd:choice&gt;
         &lt;xsd:element name=<span class="str">"Affe"</span> type=<span class="str">"xsd:string"</span>/&gt;
         &lt;xsd:element name=<span class="str">"Tiger"</span> type=<span class="str">"xsd:string "</span>/&gt;
         &lt;xsd:element name=<span class="str">"Leopard"</span> type=<span class="str">"xsd:string"</span>/&gt;
         &lt;xsd:element name=<span class="str">"Maus"</span> type=<span class="str">"xsd:string "</span>/&gt;
        &lt;/xsd:choice&gt;
   &lt;/xsd:complexType&gt;
&lt;/xsd:element&gt;
</pre></div>
<h5><strong>4.2.2.4.3 All</strong></h5>
<p>Merkmale:</p>
<ul>
<li>Jedes Element darf einmal vorkommen. 
<li>Reihenfolge spielt keine Rolle.</li></ul>
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;xsd:element name=<span class="str">"Einkaufsliste"</span> type=”einkaufsliste”&gt;
   &lt;xsd:complexType name=”einkaufsliste”&gt;
      &lt;xsd:all&gt;
         &lt;xsd:element name=<span class="str">"Kaese"</span> type=<span class="str">"xsd:string"</span>/&gt;
         &lt;xsd:element name=<span class="str">"Milch"</span> type=<span class="str">"xsd:string "</span>/&gt;
         &lt;xsd:element name=<span class="str">"Butter"</span> type=<span class="str">"xsd:string"</span>/&gt;
         &lt;xsd:element name=<span class="str">"Wurst"</span> type=<span class="str">"xsd:string "</span>/&gt;
        &lt;/xsd:all&gt;
   &lt;/xsd:complexType&gt;
&lt;/xsd:element&gt;
</pre></div>
<p>&nbsp;</p>
<h5><strong>4.2.2.4.4 Group</strong></h5>
<p>Merkmale:</p>
<ul>
<li>Gruppiert eine Reihe von Elementen oder Anweisungen.</li></ul>
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;xsd:complexType name=<span class="str">"BestellungTyp"</span>&gt;
  &lt;xsd:sequence&gt;
    &lt;xsd:choice&gt;
      &lt;xsd:group <span class="kwrd">ref</span>=<span class="str">"verschiedeneAdr"</span>/&gt;
      &lt;xsd:element name=<span class="str">"eineAdresse"</span> type=<span class="str">"DeAdresse"</span>/&gt;
    &lt;/xsd:choice&gt;
    &lt;xsd:element <span class="kwrd">ref</span>=<span class="str">"Kommentar"</span> minOccurs=<span class="str">"0"</span>/&gt;
    &lt;xsd:element name=<span class="str">"Waren"</span> type=<span class="str">"WarenTyp"</span>/&gt;
  &lt;/xsd:sequence&gt;
  &lt;xsd:attribute name=<span class="str">"bestelldatum"</span> type=<span class="str">"xsd:date"</span>/&gt;
&lt;/xsd:complexType&gt;
         
&lt;xsd:group name=<span class="str">"verschiedeneAdr"</span>&gt;
  &lt;xsd:sequence&gt;
    &lt;xsd:element name=<span class="str">"Lieferadresse"</span> type=<span class="str">"DeAdresse"</span>/&gt;
    &lt;xsd:element name=<span class="str">"Rechnungsadresse"</span> type=<span class="str">"DeAdresse"</span>/&gt;
  &lt;/xsd:sequence&gt;
&lt;/xsd:group&gt;   
</pre></div>
<p>&nbsp;</p>
<h5><strong>4.2.2.4.5 Any</strong></h5>
<p>Merkmale:</p>
<ul>
<li>Erlaubt beliebigen Datentyp</li></ul>
<h5><strong>4.2.2.4.6 Extensions</strong></h5>
<p>Extension bedeutet auf Deutsch Ableitung. Das Prinzip was dahinter steckt, ist bereits aus der Programmierung bekannt - Stichwort lautet Vererbung. 
<p>Ableitungen von Elementtypen sind dann interessant, wenn man manche Elemente spezialisieren möchte. Man spart sich dadurch eine Menge Tipparbeit und man kann einfach andere Kindelemente an das Elternelement dranhängen. Als Beispiel möchte ich hier die Einkaufsliste erweitern. 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;xsd:complexType name=”myEinkaufsliste”&gt;
   &lt;xsd:complexContent&gt;
      &lt;xsd:extension <span class="kwrd">base</span>=”einkaufsliste”&gt;
         &lt;xsd:all&gt;
         &lt;xsd:element name=<span class="str">"Fertigesssen"</span> type=<span class="str">"xsd:string"</span>/&gt;
           &lt;/xsd:all&gt;
      &lt;/xsd:extension&gt;
   &lt;/xsd:complexContent&gt;
&lt;/xsd:complexType&gt;
</pre></div>
<p>&nbsp;</p>
<h5><strong>4.2.2.4.7 Restrictions</strong></h5>
<p>Man kann auch einen neuen Elementtypen erzeugen, indem man einen bereits vorhandenen Elementtyp beschränkt. Dafür müssen alle Elemente aufgezählt werden und dabei kann man beliebig die Beschränkungen verteilen. 
<p>Als Beispiel möchte ich mein Anschriftsschema von oben verwenden. 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;xsd:complexType name=”singelAnschrift”&gt;
   &lt;xsd:restriction <span class="kwrd">base</span>="anschrift"&gt;
      &lt;xsd:sequence&gt;
         &lt;xsd:element name=<span class="str">"wohnort"</span> type=<span class="str">"xsd:string"</span>/&gt;
         &lt;xsd:element name=<span class="str">"plz"</span> type=<span class="str">"xsd:int"</span>/&gt;
         &lt;xsd:element name=<span class="str">"strasse"</span> type=<span class="str">"xsd:string"</span>/&gt;
         &lt;xsd:element name=<span class="str">"nr"</span> type=<span class="str">"xsd:int"</span>/&gt;
         &lt;xsd:element name=<span class="str">"name"</span> type=<span class="str">"xsd:string"</span> minOccurs=”1” maxOccurs=”1”/&gt;
        &lt;/xsd:sequence&gt;
   &lt;/xsd:restriction&gt;
&lt;/xsd:complexType&gt;
</pre></div>
<p>Bei dem Beispiel muss immer ein Element "name” vorkommen. 
<p>Liste der <b>Einschränkungen</b>, auch <i>Facetten</i> genannten, durch welche man einfache Beschränkungen realisieren kann: 
<ul>
<li>length, maxLength, minLength - Länge eines Strings 
<li>enumeration - Auswahl 
<li>pattern - Reguläre Ausdrücke 
<li>minExclusiv, maxExclusiv, minInclusiv, maxInclusiv - Wertebereicheinschränkung 
<li>totalDigits, fractionDigits - Einschränkung der Dezimalstelle (Gesamtzahl, Nachkommastelle) 
<li>whiteSpace - Behandlung von Tabs und Leerzeichen</li></ul>
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;xsd:simpleType name=”IQ”&gt;
   &lt;xsd:restriction <span class="kwrd">base</span>="xsd:<span class="kwrd">decimal</span>"&gt;
      &lt;xsd:minInclusiv <span class="kwrd">value</span>=”80”/&gt;
      &lt;xsd:maxInclusiv <span class="kwrd">value</span>=<span class="str">"180"</span>/&gt;
      &lt;xsd:fractionDigits <span class="kwrd">value</span>=”3”/&gt;
   &lt;/xsd:restriction&gt;
&lt;/xsd:simpleType&gt;
</pre></div>
<p>&nbsp;</p>
<h5><strong>4.2.2.4.8 List</strong></h5>
<p>In einem XML Element können durch den Typ Liste mehrere "pseudo”-Elemente drin stehen. Die Elemente müssen allerdings alle vom selben Typ sein. 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;xsd:simpleType name=<span class="str">"BundeslandListe"</span>&gt;
    &lt;xsd:list itemType=<span class="str">"Bundesland"</span>/&gt;
&lt;/xsd:simpleType&gt;

&lt;xsd:simpleType name=<span class="str">"SechsBundesländer"</span>&gt;
    &lt;xsd:restriction <span class="kwrd">base</span>=<span class="str">"BundeslandListe"</span>&gt;
    &lt;xsd:length <span class="kwrd">value</span>=<span class="str">"6"</span>/&gt;
    &lt;/xsd:restriction&gt;
&lt;/xsd:simpleType&gt;
   

<u>Beispiel:</u>
&lt;sechsLänder&gt;Sachsen       Baden-Württemberg   Rheinland-Pfalz
             Brandenburg   Niedersachsen       Hessen&lt;/sechsLänder&gt; 
</pre></div>
<p>&nbsp;</p>
<h5><strong>4.2.2.4.9 Union</strong></h5>
<p>Die Union bietet in der XSD die Möglichkeit einem Element mehrere Typen zu geben, sodass man ähnlich zur Liste, mehrere "pseudo" Elemente in einem Tag hat. 
<p><b>Syntax</b>: &lt;xsd:union memberTypes="<i>Typen</i>" /&gt; 
<div class="CodeFormatContainer"><pre class="csharpcode"><u>Beispiel:</u>
&lt;xsd:simpleType name=<span class="str">"Irgendwas"</span>&gt;
   &lt;xsd:union memberTypes="xsd:<span class="kwrd">int</span> xsd:<span class="kwrd">string</span>"/&gt;
&lt;/xsd:simpleType&gt;

<u>Beispiel:</u>
&lt;Irgendwas&gt;12 Bla&lt;/Irgendwas&gt; 
&lt;Irgendwas&gt;12&lt;/Irgendwas&gt; 
&lt;Irgendwas&gt;12 Bla 12&lt;/Irgendwas&gt; 
&lt;Irgendwas&gt;Bla Bla&lt;/Irgendwas&gt; 
</pre></div>
<p>&nbsp;</p>
<h5><strong>4.2.2.4.10 AnyAttribute</strong></h5>
<p>Erlaubt beliebige Attribute innerhalb von Elementen. 
<h5><strong>4.2.2.4.11 AttributeGroup</strong></h5>
<p>Gruppiert Attribute, sodass ein einfacher Zugriff auf diese möglich ist.</p>
<p>&nbsp;</p>
