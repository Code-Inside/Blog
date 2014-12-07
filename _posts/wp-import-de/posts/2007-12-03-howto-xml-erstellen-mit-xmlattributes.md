---
layout: post
title: "HowTo: XML erstellen mit XmlAttributes"
date: 2007-12-03 20:38
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET, .NET 2.0, HowTo, Serializer, Xml, XmlAttributes]
language: de
---
{% include JB/setup %}
<p>Es gibt viele Möglichkeiten ein XML mit .NET zu erstellen. Eine sehr praktische und schnelle Möglichkeit ist die <a href="http://msdn2.microsoft.com/en-us/library/system.xml.serialization.xmlattributes.aspx" target="_blank">XmlAttributes</a>-Variante zu verwenden. <br>Oft hat man schon ein Objektmodell das man als XML ausgeben oder eine XML Datei die man in sein Objektmodell einlesen möchte. Für diese Aufgaben ist der <a href="http://msdn2.microsoft.com/en-us/library/system.xml.serialization.xmlserializer.aspx" target="_blank">XmlSerializer</a> ideal.</p> <p><u>Ein einfaches Schreiben:</u></p> <div class="CodeFormatContainer"><pre class="csharpcode"> XmlSerializer _xmlGen = <span class="kwrd">new</span> XmlSerializer(<span class="kwrd">typeof</span>(<span class="kwrd">string</span>));
            _xmlGen.Serialize(Console.Out,"<span class="str">www.code-inside.de"</span>);</pre></div>
<p>&nbsp;</p>
<p><em>Erklärung: </em>Wir serializieren hier einfach den String <a href="http://www.code-inside.de">www.code-inside.de</a> auf der Console und schauen uns an was passiert:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image179.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="30" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb158.png" width="316" border="0"></a> </p>
<p>So wird es auf der Kommandozeile ausgegeben.</p>
<p><u>Ein einfaches Lesen:</u></p>
<div class="CodeFormatContainer"><pre class="csharpcode">XmlSerializer _xmlGen = <span class="kwrd">new</span> XmlSerializer(<span class="kwrd">typeof</span>(<span class="kwrd">string</span>));
            Console.WriteLine(
                _xmlGen.Deserialize(
                       <span class="kwrd">new</span> StringReader(<span class="str">"&lt;string&gt;www.Code-Inside.de&lt;/string&gt;"</span>)));</pre></div>
<p><em>Erklärung:</em> Diesmal wollen wir einfach unser XmlTag (mit dem Code-Inside.de), was rein theoretisch z.B. in einer Datei stehen könnte) wieder lesen.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image180.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="21" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb159.png" width="156" border="0"></a> </p>
<p>Da ist wieder unser ursprünglicher String ;)</p>
<p>&nbsp;</p>
<p>Man kann natürlich nicht nur Strings serialisieren, sondern auch komplexere Objekte. <br><u>Wichtig:</u> Diese Klassen müssen dann "public" sein und einen leeren Konstruktor haben. <br><br>Wenn man Objekte serialisiert dann werden die Elemente im XML nach dem Variablennamen oder dem Datentypen des serialisierten Objektes benannt, weil dies aber nur selten sinnvoll ist, gibt es die Möglichkeit die Ausgabe über Attribute zu steuern. <br>Eine Liste der XmlAttribute findet sich natürlich <a href="Man kann nat&uuml;rlich nicht nur strings sondern auch komplexere Objekte serialisieren, diese Klassen m&uuml;ssen dann &quot;public&quot; sein und einen leeren Konstruktor haben. " target="_blank">auf der MSDN</a>.</p>
<p><u>Klassenstruktur für unser Beispielprojekt:</u></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image181.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="248" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb160.png" width="281" border="0"></a> </p>
<p><em>(auch wenn Oliver, welcher den Artikel vorbereitet &amp; zum großen Teil geschrieben hat, das alles in die Program.cs mit reinschreiben wollte ;) )</em></p>
<p>Der Code ist einfach gehalten. Über den einzelnen Eigenschaften wurde, wie z.B. beim Title des BlogEntry, das XmlAttribute gesetzt:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">        [XmlElement(<span class="str">"title"</span>)]
        <span class="kwrd">public</span> <span class="kwrd">string</span> Title
        {
            get { <span class="kwrd">return</span> _title; }
            set { _title = <span class="kwrd">value</span>; }
        }</pre></div>
<p>Sowie über den Klassennamen des BlogEntrys das XmlRootAttribute:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">[XmlRootAttribute(<span class="str">"BlogEntry"</span>)]
    <span class="kwrd">public</span> <span class="kwrd">class</span> BlogEntry</pre></div>
<p><u>Das Schreiben wurde ähnlich Implementiert wie bei dem simplen Beispiel:</u></p>
<div class="CodeFormatContainer"><pre class="csharpcode"> BlogEntry _myBlogEntry = <span class="kwrd">new</span> BlogEntry();
      _myBlogEntry._title = <span class="str">"XML erstellen mit XmlAttributes"</span>;
      _myBlogEntry._content = <span class="str">"Es gibt viele Möglichkeiten..."</span>;
      <span class="kwrd">for</span> (<span class="kwrd">int</span> i = 0; i &lt; 2; i++)
      {
         _myBlogEntry._comments.Add(<span class="kwrd">new</span> BlogComment(<span class="str">"Paul"</span>,<span class="str">"Cooole Sache"</span>));
         _myBlogEntry._comments[i]._comments.Add(<span class="kwrd">new</span> BlogComment(<span class="str">"Tim"</span>, <span class="str">"Finde ich auch Paul"</span>)); 
      }      
      _xmlGen.Serialize(Console.Out, _myBlogEntry);</pre></div>
<p>Wir erstellen ein Blogeintrag und hängen noch ein paar Blogkommentare dran und schreiben das auf die Konsole. In unserer Demoanwendung später, werden wir dies allerdings in eine Datei speichern, welche im bin Verzeichnis zu finden ist..</p>
<p>Das resultierende Xml daraus:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">&lt;?xml version=<span class="str">"1.0"</span> encoding=<span class="str">"UTF-8"</span>?&gt;
&lt;BlogEntry xmlns:xsi=<span class="str">"http://www.w3.org/2001/XMLSchema-instance"</span> xmlns:xsd=<span class="str">"http ://www.w3.org/2001/XMLSchema"</span>&gt;
  &lt;Title&gt;XML erstellen mit XmlAttributes&lt;/Title&gt;
  &lt;content&gt;Es gibt viele Möglichkeiten...&lt;/content&gt;
  &lt;comments name=<span class="str">"Paul"</span>&gt;
    &lt;content&gt;Cooole Sache&lt;/content&gt;
    &lt;comments name=<span class="str">"Tim"</span>&gt;
      &lt;content&gt;Finde ich auch Paul&lt;/content&gt;
    &lt;/comments&gt;
  &lt;/comments&gt;
  &lt;comments name=<span class="str">"Paul"</span>&gt;
    &lt;content&gt;Cooole Sache&lt;/content&gt;
    &lt;comments name=<span class="str">"Tim"</span>&gt;
      &lt;content&gt;Finde ich auch Paul&lt;/content&gt;
    &lt;/comments&gt;
  &lt;/comments&gt;
&lt;/BlogEntry&gt;</pre></div>
<p>Das Lesen erfolgt ähnlich wie bereits oben erwähnt. In der Demoanwendung sieht das Ergebniss beim Ausführen so aus:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image182.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="345" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb161.png" width="447" border="0"></a> </p>
<p>&nbsp;</p>
<p>Fazit: MIt dem XmlSerializer und XmlAttributes lassen sich auch komplexe XML Dateien sehr schnell, einfach und übersichtlich lesen und schreiben, besonders bei rekursiven Strukturen zeigen sich deutliche Vorteile gegenüber dem XmlTextWriter.</p>
<p><strong><a href="{{BASE_PATH}}/assets/files/democode/xmlattributes/xmlattributes.zip" target="_blank">[ Download Democode ]</a></strong></p>
