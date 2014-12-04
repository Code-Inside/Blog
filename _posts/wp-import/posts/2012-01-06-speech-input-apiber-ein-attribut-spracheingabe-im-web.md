---
layout: post
title: "Speech Input API–über ein Attribut Spracheingabe im Web?"
date: 2012-01-06 23:22
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [Chrome, HTML5, Speech]
language: de
---
{% include JB/setup %}
<p>Durch Zufall bin ich heute auf die Seite von <a href="http://code.nasa.gov/">code.nasa.org</a> gelandet. Ein kleines Mikrofon Icon hat meine Aufmerksamkeit geweckt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1435.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb613.png" width="535" height="109"></a></p> <p><a href="http://www.thechromesource.com/how-to-demo-chrome-11s-speech-recognition-feature/">Seit Chrome 11</a> gibt es “Unterstützung” für die <a href="http://lists.w3.org/Archives/Public/public-xg-htmlspeech/2011Feb/att-0020/api-draft.html">Speech Input API</a>. Gelesen hatte ich davon, allerdings hatte ich mir die Integration komplex vorgestellt. Sehr zur Überraschung ist die Implementierung allerdings sehr einfach – über das Attribut “<strong>x-webkit-speech</strong>” (später soll es einfach nur “speech” sein). Das ganze soll für Input und Textarea Elemente funktionieren:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e9f3395b-697b-468e-b7a0-9cedbf101fd8" class="wlWriterEditableSmartContent"><pre name="code" class="xml">//Supported elements

&lt;input type="text" x-webkit-speech /&gt;
&lt;textarea x-webkit-speech /&gt;</pre></div>
<p><strong>Eine Flasche Wermut</strong></p>
<p>Es funktioniert nur im Chrome und man sollte sehr klar und deutlich sprechen. Deutsch versteht er kaum bis garnicht und englisch. Naja - ist noch weit von Siri entfernt. Die Speech Input API selbst ist momentan in einem sehr frühen Stadium und so richtige Fortschritte gab es seit Release Chrome 11 und heute kaum. </p>
<p><strong>Ausprobieren</strong></p>
<p>Ausprobieren kann man es z.B. <a href="http://slides.html5rocks.com/#speech-input">hier</a>. Das Video zeigt es allerdings auch gut (für die Leute, welche keinen Chrome nutzen ;))</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:e6012883-765f-4897-8a29-4597cdd03de0" class="wlWriterEditableSmartContent"><div><object width="448" height="252"><param name="movie" value="http://www.youtube.com/v/i225WaqV8tM?hl=en&amp;hd=1"></param><embed src="http://www.youtube.com/v/i225WaqV8tM?hl=en&amp;hd=1" type="application/x-shockwave-flash" width="448" height="252"></embed></object></div></div>
