---
layout: post
title: "HowTo: PDF's erstellen unter .NET mit NFop"
date: 2007-12-06 07:14
author: oliver.guhr
comments: true
categories: [Allgemein, HowTo]
tags: [.NET, FOP, HowTo, NFop, Source, Xml, XML Formatting Objects, XML-Fo]
language: de
---
{% include JB/setup %}
Wenn man ein PDF erstellen möchte, hat man die Auswahl zwischen vielen kommerziellen Produkten für .NET - mit NFop möchte ich mal eine kostenlose Möglichkeit vorstellen.
NFop ist eine Portierung der Open Source Java Anwendung <a href="http://de.wikipedia.org/wiki/Apache_Formatting_Objects_Processor">FOP</a> auf .NET und dank J# kann der Quellcode auch direkt unter dem .NET Framework kompiliert werden. NFop wandelt XML Formatting Objects (XML-FO) Dokumente in PDF Dateien um. In der Regel erzeugt man die XML-FO Dokumente mit Hilfe von XSLT aus einem XML.

<strong>.NET Anwendung -&gt; XML + XSLT -&gt; XML-FO -&gt; PDF </strong>

Durch Austauschen des XSLT's kann man so einfach die Formatierung ändern, ähnlich wie bei HTML und CSS. Wie man aus seinem Datenbestand ein XML generieren kann finden sie <a href="{{BASE_PATH}}/2007/12/03/howto-xml-erstellen-mit-xmlattributes/">hier</a>.

Weil ich den NFop Code nicht ändern wollte habe ich die DLL einmal erstellt und dann in mein Projekt eingebunden. Für dieses Beispiel muss man zusätzlich noch die <strong>vjslib </strong>einbinden. Wenn man raus gefunden hat welche Namespaces man einbinden muss geht das Erstellen des PDF's mit wenigen Zeilen Code. Weil ich das Beispiel übersichtlich halten wollte habe ich auf XSLT verzichtet und nur das <a href="http://de.wikipedia.org/wiki/Extensible_Stylesheet_Language_%E2%80%93_Formatting_Objects">XML-FO Beispiel von Wikipedia</a> benutzt.

<div class="CodeFormatContainer">
<pre class="csharpcode">
using java.io; 
using org.xml.sax; 
using org.apache.fop.apps; 

namespace XmlToPdf 
{ 
    class Program 
    { 

        static void Main(string[] args) 
        { 
            //erstellen eines einfachen PDFs 
            ConvertFoDocument("helloworld.fo", "helloworld.pdf", Driver.RENDER_PDF); 
        } 

static void ConvertFoDocument(string foFile, string pdfFile,int outputType) 
        { 
            FileInputStream input = new FileInputStream(foFile); 
            InputSource source = new InputSource(input); 
            FileOutputStream output = new FileOutputStream(pdfFile); 

            Driver driver = new Driver(source, output); 
            driver.setRenderer(outputType); 
            driver.run(); 

            output.close(); 
        } 

    } 

}</pre></div>
die helloworld.fo

<div class="CodeFormatContainer">
<pre>&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;fo:root xmlns:fo="<a href="http://www.w3.org/1999/XSL/Format%22"><font color="#669966">http://www.w3.org/1999/XSL/Format"</font></a>&gt;
  &lt;fo:layout-master-set&gt;
    &lt;fo:simple-page-master  master-name="A4"
                            page-width="210mm" page-height="297mm"&gt;
      &lt;fo:region-body region-name="xsl-region-body"  margin="2cm"/&gt;
    &lt;/fo:simple-page-master&gt;
  &lt;/fo:layout-master-set&gt;

  &lt;fo:page-sequence  master-reference="A4"&gt;
    &lt;!-- (in Versionen &lt;2.0 "master-name") --&gt;
    &lt;fo:flow flow-name="xsl-region-body"&gt;
      &lt;fo:block&gt;Hallo Welt!&lt;/fo:block&gt;    
    &lt;/fo:flow&gt;
  &lt;/fo:page-sequence&gt;

&lt;/fo:root&gt;</pre></div>

<strong>Resultat:</strong>
Als Ergebniss bekommt man ein PDF mit "Hello World!".

Den kompletten Beispielcode kann man hier herunterladen:
<a href="{{BASE_PATH}}/assets/wp-images-de/xmltopdf.zip" title="XmlToPdf">XmlToPdf Projekt</a>
