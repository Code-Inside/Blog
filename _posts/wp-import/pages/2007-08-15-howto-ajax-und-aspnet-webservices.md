---
layout: page
title: "HowTo: AJAX und ASP.NET Webservice (die Sache mit dem GET) "
date: 2007-08-15 19:48
author: robert.muehsig
comments: true
categories: []
tags: []
---
{% include JB/setup %}
Da ich momentan in einem Projekt nicht das AJAX Framework von Microsoft nutzen soll, sondern mich komplett ohne solch ein Framework auf das AJAX Gebiet stürtzen soll, stieß ich auf ein kleines Problem:

Mit ASP.NET ist es recht einfach Webservices (.asmx) zu erstellen. Mit dem AJAX Framework könnte man jetzt noch das "ScriptService”-Attribut drüber setzen und man könnte es bequem per Javascript abrufen. Da ich das allerdings nicht machen kann und somit alles nativ mit den Komponenten des XmlHttpRequest Objekt mache, ist es etwas anders.

In der ersten Variante werd ich mich auf das Daten schicken per POST beziehen. Die zweite Variante dann per GET.

<strong>Schritt 1: Webservice erzeugen</strong>

Neuen Webservice (z.B. Welcome.asmx - Datei) anlegen und eine beliebige Methode schreiben. Die Methode kann später per POST, GET, SOAP etc. angesprochen werden. ASP.NET übernimmt sozusagen die Drecksarbeit.

[WebMethod]
public string GetHelloMessage(string name)
{
return "Hallo "+name;
}

<strong>2. Schritt: WebserviceÂ testen (einfach im Visual Studio z.B. den Debugger starten):</strong>

Sobald man dies macht, kommt man zu einer Seite, welche alle Methoden des Webservices aufzeigt - mit einem Klick auf die entsprechende Methode kann man den Webservice so testen (oder die URL Welcome.asmx?op=GetHelloMessage aufrufen)
Jetzt steht da standardmäßig neben der Testmöglichkeit wo man den Parameter eingeben kannÂ noch folgendes:

SOAP 1.1
SOAP 1.2
HTTP POST

Mhhh... Get wird erstmal nicht AngebotenÂ - naja - wird bestimmt auch so gehen (da die meisten Beispiele mit POST funktionieren, werden nur wenige es versucht haben <img src="http://code-inside.de/blog/wp-includes/images/smilies/icon_wink.gif" alt=";)" class="wp-smiley" /> )
Was noch wichtig ist: Die URL zum Aufrufen ist immer <em>ServiceName.asmx/Method</em> oder bei uns "Welcome.asmx/GetHelloMessage”.

<strong>Variante 1: Daten per POST</strong>
<strong>3. Schritt: Erstellung des Javascript (main.js) (Standard XmlHttpRequest Objekt erzeugen etc. - zur Einfachheit, jetzt nur für den IE7 sowie allen anderen modernen Browsern):</strong>

var httpRequest;

function makeRequest(url, message)
{
httpRequest = new XMLHttpRequest();
httpRequest.onreadystatechange = getResponse;
httpRequest.open(”™POST”™, url, true);
httpRequest.setRequestHeader(”™Content-Type”™, ”˜application/x-www-form-urlencoded”™);
httpRequest.send(message);
}

function getResponse()
{
if (httpRequest.readyState == 4 &amp;&amp; httpRequest.status == 200)
Â  {
Â  var responseXml = httpRequest.responseXml;
Â  alert(httpRequest.responseText);
Â  }
}

<strong>Schritt 4: JS aufrufen (einfache HTML Seite mit einem Button)</strong>

&lt;button onclick=”makeRequest(”™Welcome.asmx/GetHelloMessage”™, ”˜name=Robert”™)”&gt;Klick mich!&lt;/button&gt;

Der zweite Parameter entspricht den Parametern, welche wir dem Webservice übergeben - "name” steht dabei für den Parameter der Webservice-Methode.

So... so können wir Daten per POST an den Webservice schicken und wieder empfangen, allerdings klappt es mit GET nicht so einfach.

<strong>Variante 2: Daten per GET</strong>
<strong>3. Schritt: Anpassen der Web.config</strong>
Egal wie man sich verbiegt - solange man die Web.Config nicht anpasst, nimmt der Webservice keine GET Parameter an.
Dazu muss manÂ diese ZeilenÂ hier in den Abschnitt system.web einfügen:

<font color="#0000ff"><font size="2">&lt;<font color="#a31515">webServices</font></font><font size="2"><font color="#0000ff">&gt;
Â  &lt;</font><font color="#a31515">protocols</font></font><font size="2"><font color="#0000ff">&gt;
Â Â Â  &lt;</font><font color="#a31515">add</font><font color="#0000ff"> </font><font color="#ff0000">name</font><font color="#0000ff">=</font>"<font color="#0000ff">HttpGet</font>"</font><font size="2"><font color="#0000ff">/&gt;
Â Â Â  &lt;</font><font color="#a31515">add</font><font color="#0000ff"> </font><font color="#ff0000">name</font><font color="#0000ff">=</font>"<font color="#0000ff">HttpPost</font>"</font><font size="2"><font color="#0000ff">/&gt;
Â Â Â  &lt;</font><font color="#a31515">add</font><font color="#0000ff"> </font><font color="#ff0000">name</font><font color="#0000ff">=</font>"<font color="#0000ff">HttpSoap</font>"</font><font size="2"><font color="#0000ff">/&gt;
Â  &lt;/</font><font color="#a31515">protocols</font></font><font size="2"><font color="#0000ff">&gt;
&lt;/</font><font color="#a31515">webServices</font><font color="#0000ff">&gt;</font></font></font>

<font color="#0000ff"><strong><font size="2" color="#050d24">4. Schritt: Erstellung des Javascript (main.js)</font></strong></font><font color="#0000ff"> </font><font color="#0000ff">var httpRequest;

</font>function makeRequest(url, message)
{
var endurl = url + "?” + message;
httpRequest = new XMLHttpRequest();
httpRequest.onreadystatechange = getResponse;

httpRequest.open(”™GET”™, endurl, true);
httpRequest.send(null);
}

function getResponse..// wie oben

Hier wurde jetzt bei "open” GET angeben und die Parameter wurden nicht im "send” mitgeschickt, sondern an die URL dran gehangen.

Das wär es - jetzt kann man entweder per GET oder per POST (oder man baut sich per JS das SOAP XML zusammen) Daten schicken und empfangen. Auch ohne Framework.

Back to the Root halt.
