---
layout: post
title: "HowTo: Cross Domain Ajax mit JSONP und ASP.NET"
date: 2009-12-11 08:40
author: oliver.guhr
comments: true
categories: [HowTo]
tags: [HowTo; AJAX; ASP.NET; JSON; JSONP]
language: de
---
{% include JB/setup %}
<p align="center"><a href="{{BASE_PATH}}/assets/wp-images-de/image881.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb66.png" width="141" height="129" /></a> Eigentlich kann man Ajax Requests nur an Adressen senden die unter der gleichen Domain erreichbar sind wie die Seite auf der das Script ausgeführt wird. Der Grund dafür ist die <a href="http://de.wikipedia.org/wiki/Same_Origin_Policy" target="_blank">Same Origin Policy</a> in Javascript, diese besagt das der Port, das Protokoll und die Domain gleich sein müssen um Anfragen starten zu dürfen. Das ist zwar sicher, aber leider nicht immer praktisch.</p>  <h3>Aber da gibt”™s doch bestimmt einen Trick?</h3>  <p>Ja. Es gibt sogar eine ganze Menge verschiedener Möglichkeiten das Problem zu umgehen. Wenn man nach "Cross Domain Ajax” such bekommt man einen bunten Strauß an Lösungen, ich hab bestimmt einen halben Tag gebraucht um mir die verschieden Lösungen anzuschauen. Man könnte einen zum Beispiel einen Proxy einsetzen oder Flash/Silverlight nutzen usw... Für mich war die beste Lösung JSONP zu nutzen.</p>  <h4>&#160;</h4>  <h3>Was ist JSONP?</h3>  <p align="left"><a href="http://en.wikipedia.org/wiki/JSON#JSONP" target="_blank">JSONP steht für "JSON with padding".</a> Die Idee ist so simpel wie Clever, man macht sich eine Sicherheitslücke in der Implementation der Same Origin Policy der Browser zu nutze. Man kann zwar keine Requests zu anderen Domains starten aber man kann dynamisch Javascript Dateien von anderen Domains einbinden. Und in diese packt man einfach seine Daten. Das Ganze hat den Nachteil das man Daten nur per GET übergeben kann und kein POST möglich ist. Wer mehr Daten übertragen möchte kann allerdings auf andere Tricks zurückgreifen oder muss sich etwas einschränken.     <br />jQuery macht die Implementation an dieser Stelle wieder sehr einfach und gibt uns die entsprechenden Methoden an die Hand.</p>  <h3>Und so sieht”™s aus</h3>  <h6>&#160;</h6>  <h6><em>Auf dem Client:</em></h6>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:59f252ab-d965-4523-b008-18714dd96e67" class="wlWriterEditableSmartContent"><pre name="code" class="c#">
      $.ajax({
                dataType: 'jsonp',
                jsonp: 'jsonp_callback',
                url: 'http://localhost:56761/TestService.ashx',
                success: function (j) {
                    alert(j.response);
                },
            });     

</pre></div>

<p>Der Unterschied zum "normalen" jQuery Request ist eigentlich nur die Zeile "jsonp: 'jsonp_callback'" diese gibt den GET Parameternamen an in dem jQuery den Namen der Calback Funktion an den Server übermittelt. </p>

<p>Bei jQuery funktioniert das ganze so:</p>

<ol>
  <li>Es wird ein &lt;script&gt; Tag erzeugt das auf die angegebene Adresse verweist, dabei wird als Parameter wird eine Zufallszahl übergeben(das ist dann der Name der Callbackfunktion). </li>

  <li>Der Server baut als Antwort eine Javascript-Datei zusammen die eine Funktion mit dem Namen der Zufallszahl aufruft und die Daten im JSON Format übergibt. </li>

  <li>Der Browser bindet das Script ein und führt das ganze aus. jQuery übergibt uns jetzt die Daten an das "success" Event. </li>
</ol>

<h6><em>Und auf dem Server:</em></h6>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:35344d39-ea21-4560-8561-838b22133041" class="wlWriterEditableSmartContent"><pre name="code" class="c#">string response = context.Request.Params["jsonp_callback"];
       response += "({\"response\":\"" + context.Session["RequestCounter"]  + " requests startet\"});";
context.Response.Write(response);
</pre></div>

<p></p>

<p><a href="{{BASE_PATH}}/assets/wp-images-de/image882.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb67.png" width="224" height="320" /></a> </p>

<p>Für dieses Beispiel habe ich einen Generic Handler (.ashx) benutzt. Man könnte sicherlich auch einen WCF benutzen. 
  <br />Die Beispielanwendung besteht aus zwei Projekten, einen Client das "CrossDomainAjax" Projekt und einen Service dem "SourceDomain" Projekt. Um die Demo zu starten müsst ihr mit: 

  <br /><b><i>Rechtsklick auf den Projektnamen -&gt; Debug -&gt; Start New Instance</i></b></p>

<p>Beide Projekte starten. Danach solltest du dann ein alert mit einer 1 im Browser sehen. Mit diesen Beispiel habe ich noch ausprobiert ob ich auf dem Server dann auch Zugriff auf die Sessesion habe. Und es geht. Bei jeden neu laden der Seite erhöht sich dann der Wert um eins. Gut, das ist jetzt kein spannendes Beispiel aber ich hoffe ihr verzeiht mit das :)</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/crossdomainajax/CrossDomainAjax.zip" target="_blank">Den Demo Code gibt”™s hier.</a> Viel Spaß. </p>
