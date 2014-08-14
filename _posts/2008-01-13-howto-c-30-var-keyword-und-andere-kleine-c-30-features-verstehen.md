---
layout: post
title: "HowTo: C# 3.0 - &quot;var&quot; Keyword und andere kleine C# 3.0 Features verstehen"
date: 2008-01-13 18:41
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET, .NET 3.5, C# 3.0, HowTo, LINQ]
---
<p>Mit .NET 3.5 kam auch C# 3.0 (und die entsprechende VB Variante, die hier aber nicht behandelt wird) ans Licht der Welt. Für die Entwicklung von .NET 3.5 Applikationen ist Visual Studio 2008 Pflicht - die Express Variante kann man sich kostenlos bei <a href="http://www.microsoft.com/express/" target="_blank">Microsoft</a> runterladen.</p> <p>In diesem HowTo geht es um das neue Keyword "<a href="http://msdn2.microsoft.com/en-us/library/bb383973.aspx" target="_blank">var</a>", andere Featues wie Lamda Expressions, LINQ, Partielle Methoden werden später bestimmt ebenfalls noch Themen werden.</p> <p>Für einen gute Komplettübersicht empfehle ich das <a href="http://download.microsoft.com/download/0/e/2/0e255cf3-b11f-44cb-b42c-7d55ed7b556c/CSharp_3.0_Language_Enhancements_Hands_on_Lab.doc" target="_blank">C# 3.0 Language Enhancements Hands on Lab</a>.</p> <p><strong>Was ist "var"?</strong></p> <p>Mittels "var" ist es möglich einem Object einen anonymen Typ zuzuweisen. Dabei weist der Compiler dann eine entsprechende Klasse oder eine anonyme Klasse zu. Trotz dessen, ist das Object immernoch typisiert. Am besten sieht man dies an einem kleinen Beispiel:</p> <div class="CodeFormatContainer"><pre class="csharpcode"> var IntVar = 15;
 var StringVar = <span class="str">"Hello"</span>;
 var ComplexVar = <span class="kwrd">new</span> DateTime();</pre></div>
<p>"IntVar" wird automatisch zum Typ "int", "StringVar" zu "string" und "ComplexVar" zu "DateTime". Beweis:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image216.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="73" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb195.png" width="273" border="0"></a> </p>
<p>Ein einmal zugewiesener Typ, kann nur durch Casting oder Ähnliches in einen anderen Typ konvertiert werden - also wie früher:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">var IntVar = 15;
IntVar = 13.5;</pre></div>
<p>Dies bringt folgenden Fehler beim Kompilieren:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image217.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="45" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb196.png" width="465" border="0"></a> </p>
<p><strong>Wofür braucht man "var" dann?</strong></p>
<p>Wenn man am Ende trotzdem nur einmal den Typ festlegen kann, wozu sollte ich dann überhaupt "var" schreiben, wenn ich gleich "string" etc. hinschreiben könnte?<br>Folgender Sachen sind mit "var" möglich und daher in diesen Fällen auch interessant:</p>
<ul>
<li>1. In Zusammenhang mit LINQ kann man sich sein "Result" Typ so zusammenbauen, wie man ihn braucht, ohne das er vorher existierte. 
<li>2. Man kann einen komplexes Objekt "on-the-fly" erstellen.</li></ul>
<p><u>Eine Sache sollte natürlich klar sein:</u> "var" sollte nur dort Verwendung finden, wo es sinnvoll ist - wenn der Typ ohnehin bekannt und da ist, braucht man es schonmal nicht.</p>
<p><strong>Das Demoprojekt - ein Konsolenprogramm zum Testen der neuen Features</strong></p>
<p>Nachfolgend müssen wir einige Sachen vorbereiten, um am Ende das "var" Keyword sinnvoll zu gebrauchen.</p>
<p>Als erstes brauchen wir mal eine kleine Klasse, damit wir etwas experimentieren können:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">class</span> Product
    {
        <span class="kwrd">public</span> <span class="kwrd">string</span> Name { get; set; }
        <span class="kwrd">public</span> <span class="kwrd">int</span> Id { get; set; }
    }</pre></div>
<p><u>C# 3.0 Neuerung hierbei:</u> Das Feature mit "get; set;" ist ebenfalls neu in C# 3.0. Damit entfällt das etwas lästige "private string blub; public string Blub {...}" - </p>
<p>Danach legen wir in "Main" ein neues Produkt an:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">Product MyProduct = <span class="kwrd">new</span> Product { Name = <span class="str">"Auto"</span>, Id = 123 };</pre></div>
<p><u>C# 3.0 Neuerung hierbei:</u> Ebenfalls neues Feature und wird in Visual Studio 2008 auch über die IntelliSense angezeigt:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image218.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="45" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb197.png" width="304" border="0"></a>&nbsp; </p>
<p>Und auch eine Liste an Produkten wird angelegt:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">List&lt;Product&gt; MyProductList = <span class="kwrd">new</span> List&lt;Product&gt;
            {
                <span class="kwrd">new</span> Product { Name = <span class="str">"Brett"</span>, Id = 1 },
                <span class="kwrd">new</span> Product { Name = <span class="str">"Bett"</span>, Id = 2 },
                <span class="kwrd">new</span> Product { Name = <span class="str">"Pfanne"</span>, Id = 3 }
            };</pre></div>
<p><u>C# 3.0 Neuerung hierbei:</u> Auch Listen oder Arrays können so angelegt werden. Alles natürlich mit IntelliSense.</p>
<p>Dann legen wir noch 2 andere Objekte an:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">var MyVarString = <span class="str">"Something..."</span>;
var MyVarInt = 13;</pre></div>
<p><u>C# 3.0 Neuerung hierbei:</u> Wie bereits oben geschrieben - das "var" Keyword.</p>
<p><strong>Das "var" Keyword benutzen, um einen komplexen anonymen Typ zu erstellen</strong></p>
<div class="CodeFormatContainer"><pre class="csharpcode">            var MyVarComplex = <span class="kwrd">new</span> { 
                                    Product = <span class="kwrd">new</span> Product { Name = <span class="str">"Kette"</span>, Id = 33},
                                    AnotherProduct = MyProduct,
                                    SimilarProducts = MyProductList,
                                    Information = <span class="str">"This is an additional information."</span>,
                                    SpecialId = MyVarInt,
                                    SpecialString = MyVarString
                                };</pre></div>
<p>&nbsp;</p>
<p>"MyVarComplex" ist nun unser komplexer, anonymer Typ, welchen wir on-the-fly über das "var" Keyword erstellen:</p>
<p>Über "new { ... }" legt man einen solchen anonymen Typ an. "AnotherProduct" ist z.B. eines unserer Attribute des anonymen Typs und wird mit "MyProduct" befüllt. </p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image219.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="277" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb198.png" width="477" border="0"></a> </p>
<p>Besonders interessant: "MyVarComplex" wird als "Anonymous Type" angegeben.</p>
<p>Natürlich bietet Visual Studio volle IntelliSense Unterstützung:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image220.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="160" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb199.png" width="323" border="0"></a>&nbsp;</p>
<p><strong>Was haben wir jetzt davon?</strong></p>
<p>Manchmal benötigt man Daten in einer speziellen Form, von verschiedenen Objekten - bis jetzt musst man entweder über unschönen Notlösungen mit "object" oder halt das erstellen einer entsprechenden Klasse sowas lösen. Mit "var" ist es jedoch sehr einfach, einen entsprechenden Objektbaum schnell zu erstellen. <br>Zusammen mit den anderen C# 3.0 Features die hier vorgestellt wurden, aber auch LINQ und co., ist das ein großer Schritt nach vorn. </p>
<p>Hier der gesamte Source Code:</p>
<div class="CodeFormatContainer"><pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.Collections.Generic;
<span class="kwrd">using</span> System.Linq;
<span class="kwrd">using</span> System.Text;

<span class="kwrd">namespace</span> CSharp3
{
    <span class="kwrd">class</span> Program
    {
        <span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
        {
            Product MyProduct = <span class="kwrd">new</span> Product { Name = <span class="str">"Auto"</span>, Id = 123  };
            
            List&lt;Product&gt; MyProductList = <span class="kwrd">new</span> List&lt;Product&gt;
            {
                <span class="kwrd">new</span> Product { Name = <span class="str">"Brett"</span>, Id = 1 },
                <span class="kwrd">new</span> Product { Name = <span class="str">"Bett"</span>, Id = 2 },
                <span class="kwrd">new</span> Product { Name = <span class="str">"Pfanne"</span>, Id = 3 }
            };

            var MyVarString = <span class="str">"Something..."</span>;
            var MyVarInt = 13;

            var MyVarComplex = <span class="kwrd">new</span> { 
                                    Product = <span class="kwrd">new</span> Product { Name = <span class="str">"Kette"</span>, Id = 33},
                                    AnotherProduct = MyProduct,
                                    SimilarProducts = MyProductList,
                                    Information = <span class="str">"This is an additional information."</span>,
                                    SpecialId = MyVarInt,
                                    SpecialString = MyVarString
                                };

            Console.ReadLine();
        }
    }

    <span class="kwrd">public</span> <span class="kwrd">class</span> Product
    {
        <span class="kwrd">public</span> <span class="kwrd">string</span> Name { get; set; }
        <span class="kwrd">public</span> <span class="kwrd">int</span> Id { get; set; }
    }
}
</pre></div>
<p>Als Download:</p>
<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/csharp3/csharp3.zip" target="_blank">[ Download Democode ]</a></strong></p>
<p><strong>Links:</strong> </p>
<ul>
<li><a href="http://msdn2.microsoft.com/en-us/library/bb383973.aspx" target="_blank">MSDN var Keyword</a> 
<li><a href="http://msdn2.microsoft.com/en-us/library/bb308966.aspx" target="_blank">MSDN Overview C# 3.0</a>
<li><a href="http://www.microsoft.com/express/" target="_blank">Microsoft Visual Studio 2008 Express</a> 
<li><a href="http://download.microsoft.com/download/0/e/2/0e255cf3-b11f-44cb-b42c-7d55ed7b556c/CSharp_3.0_Language_Enhancements_Hands_on_Lab.doc" target="_blank">C# 3.0 Language Enhancements Hands on Lab</a>
<li>Blogeintrag: <a href="http://www.strangelights.com/blog/archive/2005/10/10/1264.aspx">C# 3.0 - The var "keyword” and anonymous classes</a></li></ul>
