---
layout: post
title: "Metadaten im DOM mit HTML5 data-* Attributen & jQuery"
date: 2011-09-11 00:14
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, HTML5, Javascript, jQuery]
---
{% include JB/setup %}
<p>Metadaten im Markup, welches man für Javascripts brauchte, hatte man meist in CSS Klassen, rel Attribut oder Hidden-Inputfeldern gesteckt. Mit den HTML5 data-* (gesprochen “Data dash”) Attributen gibt es jetzt einen saubereren Weg für dieses Szenario.</p> <p><strong>Was kann man mit diesen Attributen machen und wie sieht das Markup aus?</strong></p> <p>Wer im Javascript bestimmte Daten braucht, welche sich bislang in versteckten Input-Feldern oder CSS Klassen fanden (siehe oben ;) ) befanden, kann man diese nun direkt an das jeweilige DOM Element schreiben. Man legt dazu einen Schlüssel fest, welcher einen Wert besitzt – ziemlich einfach.</p> <p>Dazu gibt es das “<strong>data-*</strong>” Attribut. Dahinter kann man beliebig seine eigenen Keys festlegen, wie z.B. in meinem Beispiel data-<strong>message</strong> (das Beispiel soll nur die Funktionsweise erklären, daher ist das Beispiel “aus der Luft gegriffen”)</p> <p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:db21401a-b1e5-4ff1-810d-2e54aa28adea" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;h2 id="headline" data-message="ImportantMessage"&gt;Welcome to ASP.NET MVC!&lt;/h2&gt;</pre></div></p>
<p><strong>Via jQuery den data-* Wert auslesen</strong></p>
<p>Beim Auslesen holen wir uns das Element und rufen dann unseren Key auf:</p>
<p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:cb55daae-c051-4ccc-bf7f-1e5f66278b6d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">alert($("#headline").data("message"));</pre></div></p>
<p><strong>Via jQuery den data-* Wert setzen</strong></p>
<p>Beim Setzen geben wir noch einen zweiten Parameter mit:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f4b9c632-bdea-41a6-83c9-771bd1775dcc" class="wlWriterEditableSmartContent"><pre name="code" class="c#">$("#headline").data("message","Neue Daten!");</pre></div>
<p>&nbsp;</p>
<p><a href="http://api.jquery.com/jQuery.data/">jQuery Data Doku</a></p>
<p><strong>data-* und ASP.NET MVC</strong></p>
<p>Die data-* Sachen sind nur auf dem Client bekannt und werden auch bei einer HTML Form nicht mit übertragen. Natürlich kann man die data-* Sachen über einen View “vorbefüllen”</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:44c81cdf-ebd1-4a40-8e88-c7a56ec3d48f" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;h2 id="headline" data-Message="@ViewBag.Data"&gt;@ViewBag.Message&lt;/h2&gt;</pre></div>
<p>Der Rest geschieht dann nur noch auf dem Client.</p>
<p><strong>Browser Kompatibilität</strong></p>
<p>Das Feature funktioniert auch in älteren Browser (IE6) und sollte auch im mobilen Bereich keine Schwierigkeiten bereiten. Happy Coding!</p>
<p><strong>Wofür sollte man es nicht einsetzen</strong></p>
<p>Die data-* Attribute sind laut W3C nicht für 3rd Party Anwendungen gedacht – dafür gibt es z.B. die <a href="http://microformats.org/">Microformate</a>. Auch Style-Informationen oder bereits bestehende Mechanismen soll dieses Attribut nicht ersetzen.</p>
<p><strong>Daran sollte man denken</strong></p>
<p>Da jeder sein Key selbst festlegen kann, kann es natürlich beim Einsatz von diversen Javascript Plugins zu Überschneidungen kommen. jQuery Validation z.B. nutzt ebenfalls die data-* Attribute. Man sollte daher in der Benamung des Schlüssels kurz 5 Sekunden drüber nachdenken ob das Wort nicht evtl. von anderen Plugins verwendet wird (welche man selbst verwendet).</p>
<p><strong>Welche Javascript Plugins machen davon schon gebrauch?</strong></p>
<p>Aus dem Kopf heraus würde ich sagen, dass diverse Validierungsplugins (darunter jQuery Validation) davon gebrauch machen. Allerdings nutzt auch <a href="http://knockoutjs.com/">Knockout.js</a> dieses Feature für das Data-Binding.</p>
<p><strong>Ein paar interessante Links noch</strong></p>
<p>- <a href="http://ejohn.org/blog/html-5-data-attributes/">John Resig über die data Attribute</a></p>
<p>- <a href="http://html5doctor.com/html5-custom-data-attributes/">HTML5 Custom Data Attributes (data-*)</a></p>



<p><strong><a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2FjQueryDataDash">[ Demo Source Code on Google Code ]</a></strong></p>
