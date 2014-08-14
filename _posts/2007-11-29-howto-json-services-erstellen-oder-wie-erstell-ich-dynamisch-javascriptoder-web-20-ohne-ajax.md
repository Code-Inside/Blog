---
layout: post
title: "HowTo: Json-Services erstellen (...oder wie erstell ich dynamisch Javascript?...oder Web 2.0 ohne AJAX?)"
date: 2007-11-29 21:26
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [.NET 3.5, AJAX, ASP.NET 3.5, HowTo, Json, Source, Web 2.0, Webservices]
---
{% include JB/setup %}
<p><a href="http://de.wikipedia.org/wiki/JSON" target="_blank">JSON (oder Javascript Objekt Notation)</a> ist besonders für Webanwendung eine sehr gute Alternative zu XML. Auf Javascript mit Xml zugreifen geht (<a href="http://code-inside.de/blog/2007/11/13/howto-xml-mit-javascript-parsen-zugriff-auf-nodes-attribute/" target="_blank">siehe HowTo</a>), ist aber nicht unbedingt schön.<br>In Zeiten von (XML) Webservices und AJAX steht man dabei aber vor einem Problem: Wie bekomm ich etwas in einem Json Format? Gibts ein Serialisierer?</p> <p>Ja, gibts - sogar direkt von Microsoft - die ASP.NET 2.0 AJAX Extensions oder ASP.NET 3.5.</p> <p><strong><u>Was wollen wir eigentlich erreichen?</u></strong></p> <p>Wie man einen ASP.NET Webservice dazu bringt Json zu generieren, wurde <a href="http://code-inside.de/blog/artikel/howto-microsoft-aspnet-ajax-clientseitiger-aufruf-von-webmethoden/" target="_blank">hier</a> bereits beschrieben (einfach über die Webmethod das ResponseFormat angeben), was wir aber wollen ist ein direkter "<strong>Json Service</strong>" welchen man direkt als Javascript Datei mit ins Projekt einbinden über den üblichen Syntax: <strong>&lt;script src="..." ...&gt;...&lt;/script&gt;<br></strong>Ein anderer Punkt ist folgender: AJAX ist schön und gut - aber mal ehrlich: Jedes mal einen Request losschicken nur weil man ein paar Daten mehr haben möchte? Warum das nicht direkt in einem Rutsch laden? Mit Json ist eine wesentlich schnellere Datenübertragung möglich als mit AJAX:</p> <p>In einem Projekt mit einer Datenbank wo über 1000 Produkte samt Beschreibungstexte drin stehen, sowie Preise, Bewertungen etc. wurden alle Daten direkt auf den Client übertragen und diese Datei war nur 300kb groß (<strong>mit Kompression sogar nur 150kb!</strong>)- jedes Bild ist heutzutage größer.</p> <p><strong><u>Was bringt das nun?</u></strong></p> <p>Web 2.0 ohne AJAX - warum kleine Datenmengen immer über einen umständlichen XmlHttpRequest nachladen, wenn es reichen würde die Daten einmal komplett als Json zu ziehen - das ist wesentlich trafficsparender und ermöglicht es alle Daten ohne nervige AJAX Ladebalken oder ähnliches anzuzeigen.</p> <p>Da Json nur Javascript ist...</p> <p><strong><u>Zur eigentlichen Frage: Wie kann ich Javascript dynamisch erstellen?</u></strong></p> <p><strong>Schritt 1: ASP.NET AJAX Projekt anlegen</strong></p> <p>Wir legen uns ein einfaches ASP.NET AJAX Projekt an und haben dann diese Struktur:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image173.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="121" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb152.png" width="244" border="0"></a> </p> <p>In unserer Default.aspx wollen wir unsere generierte Json Datei später einbinden.</p> <p><strong>Schritt 2: Demodaten vorbereiten</strong></p> <p>Zur Demonstration wollen wir einfach ein paar Kontaktdaten ("Contacts" &amp; "Address") nehmen. Da wir keine Datenbank haben, simulieren wir einfach 500 Kontakte über den "ContactManager", welcher 500 Contacts erstellt und als "List&lt;Contact&gt;" zurück gibt.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image174.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="177" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb153.png" width="244" border="0"></a> </p> <p><em>Klassenstruktur (Verschachtelte Struktur beachten) : </em></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image175.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="214" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb154.png" width="422" border="0"></a> </p> <p><strong>Schritt 3: Generischer Handler implementieren - dyamischer Javascript Generator</strong></p> <p>Oft übersehen aber in diesem Fall äußerst praktisch:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image176.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="288" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb155.png" width="478" border="0"></a> </p> <p>Da wir eine Javascript Datei dynamisch erstellen wollen, brauchen wir kein Markup (aspx/html) oder ein Webdienst (asmx). <strong>Die Lösung: Eine ASHX</strong>.</p> <p><em>Source Code "ContactJsonService"</em></p> <div class="CodeFormatContainer"><pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">class</span> ContactJsonService : IHttpHandler
    {

        <span class="kwrd">public</span> <span class="kwrd">void</span> ProcessRequest(HttpContext context)
        {      
            ContactListManager manager = <span class="kwrd">new</span> ContactListManager();
            
            JavaScriptSerializer serializer = <span class="kwrd">new</span> JavaScriptSerializer();
            <span class="kwrd">string</span> output = <span class="str">"var ContactList = "</span> + serializer.Serialize(manager.GetAllContacts());

            context.Response.ContentType = <span class="str">"application/json"</span>;
            context.Response.Write(output);
        }

        <span class="kwrd">public</span> <span class="kwrd">bool</span> IsReusable
        {
            get
            {
                <span class="kwrd">return</span> <span class="kwrd">false</span>;
            }
        }
    }</pre></div>
<p>Die HTTP Anfrage kommt rein und alles was wir machen ist den Content uns selber zusammenstellen - daher wird auch nur das ausgegeben was wir wollen und kein unnötiges Markup. Als ContentType geben wir hier nun noch "application/json" an - aber eigentlich ist das egal.</p>
<p><strong>Wichtig:</strong> "var ContactList = " muss angegeben werden, damit man später auf das Json zugreifen kann. Ein verschateltes Json, so wie wir es wollen findet man auch auf <a href="http://json.org/js.html" target="_blank">json.org</a> gut erklärt.<br>Der <a href="http://asp.net/ajax/documentation/live/mref/N_System_Web_Script_Serialization.aspx" target="_blank">JavaScriptSerializer</a> ist im Namespace "<strong>System.Web.Script.Serialization</strong>" welche sich in der Assembly "<strong>System.Web.Extensions</strong>" (also ASP.NET AJAX / ASP.NET 3.5) befindet.</p>
<p><strong>Schritt 4: Unsere dynamische JS Datei einbinden</strong></p>
<p>Auf unserer Default.aspx können wir nun einfach die ASHX einbinden:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    &lt;script src=<span class="str">"ContactJsonService.ashx"</span> type=<span class="str">"text/javascript"</span> language=<span class="str">"javascript"</span>&gt;&lt;/script&gt;</pre></div>
<p>Und schon haben wir Zugriff auf das JS Objekt:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image177.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="200" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb156.png" width="557" border="0"></a> </p>
<p>Und erstellen daraus unsere dynamische Liste welche direkt im onload aufgerufen wird:</p>
<div class="CodeFormatContainer"><pre class="csharpcode">    function create()
    {
        <span class="kwrd">for</span>(i=0; i&lt;ContactList.length; i++)
        {
        var newLi = document.createElement(<span class="str">"li"</span>);
        newLi.innerHTML = ContactList[i].Name;
        $get(<span class="str">"list"</span>).appendChild(newLi);
        }
    }</pre></div>
<p><strong>Was sagt die Ladezeit?</strong></p>
<p>Mit<strong> 54kb und 1 Sekunde Ladezeit</strong> auf einem Development Server (ein richtiger IIS ist schneller und mit Kompression kann man es nochmal verbessern) hat man 500 Datensätze da und kann die über Javascript anschauen wie man möchte - <strong>ohne weitere Ladezeiten!</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image178.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="162" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb157.png" width="597" border="0"></a> </p>
<p><strong>Fazit:</strong></p>
<p>Das Implementieren eines Json Services ist nicht schwer - man muss aber beachten, dass es nur dort Sinn macht, wo der Datenbestand sich nicht jede Sekunde / Minute verändert, weil man den Browser nicht dazu veranlassen kann die Daten neu zu ziehen,jedenfalls nicht direkt über diese Einbindung.</p>
<p>Bei den meisten Sachen ist dies aber auch gar nicht nötig. Bei einem Shop zum Beispiel könnte man den Produktkatalog einmal direkt auf den Client über dieses Technik schieben und könnte diese dann anschauen und in der Darstellung verändern <strong>ohne weitere Ladezeit, was bei AJAX so nicht möglich ist</strong>. <br>Der Produktkatalog wird sich immerhin nicht ständig ändern und sobald der Nutzer wieder auf die Seite geht, wird eine aktuelle Datei gezogen.</p>
<p>Wenn man nur "readonly" die Daten anders Darstellen will (Eine Listenansicht, eine Detailansicht etc.) kann man dies ohne AJAX machen und dadurch, dass man keine Requests los schickt, auch wesentlich performanter dies realisieren. </p>
<p>Das sowas auch in der Praxis geht, zeigt <a href="http://www.dotnetkicks.com/" target="_blank">dotnetkicks.com</a> mit seinem <a href="http://www.dotnetkicks.com/services/json/jsonservices.ashx" target="_blank">JsonService</a>.</p>
<p>&nbsp;</p>
<p><strong>[ <a href="http://{{BASE_PATH}}/assets/files/democode/jsonservice/jsonservice.zip" target="_blank">Download Source Code</a> | <a href="http://code-developer.de/democode/jsonservice/default.aspx" target="_blank">Demoanwendung</a> ]</strong></p>
