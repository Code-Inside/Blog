---
layout: post
title: "HowTo: ASP.NET MVC View Syntax <%= oder <% ?"
date: 2010-01-12 01:03
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, HowTo]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image887.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="122" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb72.png" width="148" align="left" border="0"></a>"Inline" Code kommt bei <a href="http://asp.net/mvc">ASP.NET MVC</a> sehr häufig in den Views vor. Wer PHP, JSP oder eine andere "Web-Sprache/Framework" mal gesehen hat, findet das eigentlich auch recht vertraut. Um Serverseitigen Code einzuschleusen gibt es diesen Syntax: &lt;% ... %&gt;. Manchmal reicht für eine Ausgabe auch nur &lt;%=Model%&gt;. In dem Blogpost möchte ich kurz zusammenfassen, was da überhaupt passiert. Am Anfang hat mich das nämlich immer etwas verwirrt ;)</p><!--more--> <p><strong>&lt;%=Model.XXX%&gt;</strong></p> <p>Für eine kleine Ausgabe auf dem View reicht dieser Syntax:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c0a7b8c1-760e-4638-9859-1c0289ae0908" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%= Html.Encode(ViewData["Message"]) %&gt;</pre></div>
<p> Ohne das kleine "=" würde Visual Studio auch einen Fehler bringen. Im Grunde sagt die Zeile nichts anderes aus als: Schreibe an dieser Stelle den String XXX hin. Die meisten kleinen Html Extensions in ASP.NET MVC geben ein <strong>String</strong> zurück. <strong>Ist dies der Fall</strong>, dann kann man einfach den Wert über <strong>&lt;%=...%&gt;</strong> ausgeben lassen. Hier kann man sich auch das Semikolon sparen.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image888.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="59" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb73.png" width="341" border="0"></a></p>
<p>Eine andere Möglichkeit wäre aber auch dies:</p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5fbe357f-d4d6-48ab-a878-6685973da803" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;%this.Writer.Write(Html.Encode(ViewData["Message"])); %&gt;</pre></div>
<p>Im Prinzip passiert hier das gleiche, nur das man <strong>direkt den Writer</strong> anspricht, der den Html Output generiert. Da dies ein direkter Methodenaufruf ist, muss allerdings das Semikolon gesetzt werden.</p>
<p><strong>&lt;% Html.RenderPartial("Test"); %&gt;</strong></p>
<p>RenderPartial oder <a href="http://code-inside.de/blog/2009/09/14/howto-asp-net-mvc-renderaction-mit-parametern/">RenderAction</a> (welches sich in den MvcFutures versteckt) funktionieren allerdings nicht mit dem &lt;%= Syntax. Diese Methoden geben auch void zurück, anstelle eines Strings:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image889.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="48" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb74.png" width="505" border="0"></a> </p>
<p>Auch hier gilt wieder: Semikolon setzen.</p>
<p>Die Html-Extensions die <strong>void</strong> zurückgeben <strong>schreiben direkt</strong> in den <strong>Output-Stream</strong>!</p>
<p><strong>Warum ist das so?</strong></p>
<p>Der Grund liegt in der Performanceoptimierung. Würden RenderPartial oder RenderAction ein String zurückgeben, müsste wahrscheinlich viel hin und her kopiert werden, <a href="http://msdn.microsoft.com/de-de/library/aa302314.aspx">da Strings in .NET unveränderlich sind</a>. Zudem kann ein einzelnes Control, welches über RenderPartial eingebunden ist, auch eine beträchlichte Größe haben. Daher wären die Stringmanipulationen sehr Performance fressend, sodass diese direkt in den Output schreiben. </p>
<p>Praktisch gesehen sollten größere Controls keine Strings zurückliefern, sondern auch in den Output schreiben. </p>
<p>Vielleicht seht ihr nach der Erklärung etwas klarer, wann man welchen Syntax verwendet. Leider ist das Visual Studio 2008 in den Views manchmal enorm dusslig und bietet da auch keine Hilfe an.</p>
