---
layout: post
title: "HowTo: Silverlight mit dem &quot;object&quot; Tag als embedded HTML anbieten"
date: 2007-12-13 07:53
author: Robert Muehsig
comments: true
categories: [HowTo]
tags: [Embedded, HowTo, Silverlight]
language: de
---
{% include JB/setup %}
<p><strong>Erstmal eine Warnung zum Anfang:</strong> Ich bin mir nicht sicher, ob diese Variante welche ich gleich vorstelle überhaupt von Microsoft so vorgesehen war und ob dies in der Praxis so umsetzbar ist - in meinem Test ging es mehr oder weniger gut - im IE7 (mit&nbsp;Einschränkungen)&nbsp;und FF2. <p><strong>Folgende Situation: </strong>YouTube und co. welche auf Flash setzen haben meistens am Ende des Videos noch eine Option, dass Flash-Filmchen als embedded HTML in seinen eigenen Blog etc. einzubauen. Das ist natürlich eine feine Sache, da somit eine leichte Verbreitung möglich ist. <p>Bei Silverlight sieht die Sache etwas anders aus - eine Embedded-Option, welches direkt das Silverlight mit "object" anbietet, gibt es erstmal nicht und im Silverlight Forum findet man auch nur spärliche Informationen darüber, dass es eigentlich nicht so geht. <p>Als Alternative gibt es noch die Möglichkeit das über ein IFrame einzubinden - zwar nicht so ideal, aber es geht noch. Leider verbieten einige Plattformen (MySpace und co.) den Einsatz von IFrames. <p><strong>Grund für die Problematik:</strong> <p>Silverlight agiert zusammen mit Javascript - egal ob in 1.0 oder 1.1/2.0 - die Hostseite muss erstmal das Silverlight Plugin erstellen. Am schönsten wäre es daher, wenn man Silverlight Sachen direkt über den "object" Tag wie bei Flash einfügen könnte - das ist schicker und auch XHTML Valide :) <p><strong>Die Lösung:</strong> <p>Wir binden einfach unsere komplette Silverlight Applikation (z.B. den Videoplayer) als Object ein:
<div class="CodeFormatContainer">
<pre class="csharpcode">&lt;object data="<a href="http://silverlight.net/fox/">http://silverlight.net/fox/</a>" type="text/html" id="SilverlightControl" height="200px" width="250px"&gt; 
&nbsp;&nbsp;&nbsp;&nbsp;&lt;/object&gt;</pre>
</div>
<p>Über <strong>data</strong> verweisen wir auf unsere komplette Applikation und geben als <strong>type</strong> "text/html" an, somit haben wir quasi die IFrame Funktionalität mit einem object.
<br/><br/>
<p><strong>Ergebnis im Firefox:</strong>
<p><img height="295" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/clip-image001.gif" width="611" border="0">
<p><strong>Ergebnis im IE 7:</strong>
<p>Im IE7 ist das so allerdings nicht ganz so möglich. Durch die Sicherheitseinstellung holt sich der IE nicht die Daten von unserer Quelle.
<p>Um zu sehen das es trotzdem geht, muss die Seite in den "Vertrauenswürdigen Seiten" aufgenommen werden und dort die Sicherheitseinstellung auf "Sehr niedrig" gesetzt werden.
<p>Das ist hat aber <u>nichts mit Silverlight zu tun</u>, sondern ist ein <u>generelles "Sicherheitsproblem" im IE7</u> - ich denke aber, dass es bestimmt dafür eine Lösung gibt - wer kennt eine?
<p>Unter anderem Browsern hab ich es noch nicht direkt ausprobieren können, Opera zeigt mir aber den "Bitte Silverlight installieren" Button an - also scheint es zu funktionieren.
<p><strong>Fazit:</strong>
<p>Wenn man nun noch den IE so überlisten könnte, dass er über das Object Tag die Seite lädt ohne in den Sicherheitseinstellungen was zu verändern, braucht man keine hässliche IFrame Lösung mehr und es ist ähnlich wie bei Flash.
<p><strong>[ <a href="http://code-developer.de/democode/embeddedsilverlight/">Demopage + Source Code</a> ]</strong></p>
