---
layout: post
title: "Chrome Instant Page / Prerendering–was ist das und wie kann ich das nutzen?"
date: 2011-08-07 11:02
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [Chrome, Google, Prerendering]
language: de
---
{% include JB/setup %}
<p>Google hat mit der Version 13 von Chrome ein <a href="http://chrome.blogspot.com/2011/08/instant-pages-on-google-chrome.html">neues Feature namens “Instant Page” aktiviert</a>. Es ist ein weiterer Schritt in Richtung “das Web schneller machen". Was “Instant Page” eigentlich ist, zeigt dieses Video sehr schön:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:9ab28d32-765b-4ea9-a4ea-154550050c5f" class="wlWriterEditableSmartContent"><div><object width="448" height="252"><param name="movie" value="http://www.youtube.com/v/_Jn93FDx9oI?hl=en&amp;hd=1"></param><embed src="http://www.youtube.com/v/_Jn93FDx9oI?hl=en&amp;hd=1" type="application/x-shockwave-flash" width="448" height="252"></embed></object></div></div> <p>Google hat das Feature natürlich auf der Google Suchseite mit eingebaut. </p> <p><strong>Was macht Google Instant Page?</strong></p> <p>Das Grundprinzip ist recht simple: Während der Benutzer noch die Suchresultate nach passenden Antworten absucht werden bereits die ersten Treffer vom Browser im Hintergrund geladen. Dies hat zur Folge, dass die ersten Suchresultat quasi “sofort da sind”, sobald man auf den Link in der Google Suche klicke. Tolles Feature und recht clever.</p> <p>Es gibt einige Szenarien, wo dies durchaus praktisch ist. Darunter sind z.B. Suchseiten, aber auch Wizard-Seiten oder mehrseitige Artikel – bei allen Varianten ist es durchaus vorstellbar, dass der Benutzer die ersten Suchresultate anklickt bzw. zur nächsten Seite geht</p> <p><strong>Achtung – es sollte mit bedacht eingesetzt werden</strong></p> <p>Hier liegt allerdings auch die kleine Herausforderung: Das mit allen Links zu machen wäre der gänzlich falsche Weg, da dadurch nur unnötige Daten übertragen werden, was sowohl für den Benutzer, aber auch für den Seitenbetreiber negative folgen hätte – viel Traffic, aber keine Besucher. </p> <p><strong>Testseite</strong></p> <p>Google hat eine sehr einfache Testseite zur Verfügung gestellt, welche auch prüft ob Prerender aktiv ist oder nicht (die Seite ist nur im Chrome momentan von Interesse) : <a href="http://prerender-test.appspot.com/">http://prerender-test.appspot.com/</a></p> <p><strong>Ok, wie funktioniert das eigentlich technisch?</strong></p> <p>Auf der <a href="http://code.google.com/chrome/whitepapers/prerender.html"><strong>Chrome Developer Site</strong></a> kann man einige interessante Sachen noch nachlesen, jedoch ist die Grundsätzliche Implementation sehr einfach. Um zu sehen was an Traffic entsteht schau ich einmal in den Network Tab der Chrome Dev Tools und nutze zudem noch <a href="http://www.fiddler2.com/fiddler2/">Fiddler</a>.</p> <p>Folgender HTML Code<strong> ohne Prerendering</strong>:</p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a1cf2fee-f07e-4f66-84ad-560dfbcb5ce8" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;!DOCTYPE html&gt;

&lt;html&gt;

&lt;head&gt;

    &lt;meta charset="utf-8" /&gt;

    &lt;title&gt;Index&lt;/title&gt;

&lt;/head&gt;



&lt;body&gt;

    

&lt;a href="{{BASE_PATH}}"&gt;Link Code Inside&lt;/a&gt;

&lt;/body&gt;

&lt;/html&gt;


</pre></div>
<p>&nbsp;</p>
<p><u>Ohne Prerendering:</u></p>
<p>Es wird einfach nur ein Request / Response gegeben, wobei zusätzlich noch nach einem Favicon gesucht wird (was aber an dieser Stelle egal ist). Keine Überraschungen hier.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1326.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb508.png" width="244" height="207"></a></p>
<p>Navigiert man nun über den Link zu Code-Inside.de wird erst dann das Laden der Seite angestoßen = <strong>Langsam</strong>.</p>
<p><strong>Prerendering anschalten</strong></p>
<p>Wenn wir nun noch Prerendering aktivieren wollen, müssen wir nur im<strong> &lt;head&gt; noch die Zeile</strong> <strong>einfügen</strong>:</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:81a4ddc0-4d6f-4246-a3b0-fa6c16d84d9a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;link rel="prerender" href="{{BASE_PATH}}"&gt;




</pre></div>
<p>&nbsp;</p>
<p>Nun sieht man in den Chrome Dev Tools, dass die Adresse aufgerufen wird, allerdings werden noch keine weiteren Daten angezeigt – erst mit Chrome 14 wird man hier mehr Informationen angezeigt bekommen.</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1327.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb509.png" width="404" height="207"></a></p>
<p>Ein Blick in Fiddler liefert allerdings schon wesentlich mehr Informationen. Durch das Prerendering werden alle benötigten Daten bereits runtergeladen:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-de/image1328.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb510.png" width="499" height="454"></a></p>
<p>Dadurch ist die Seite "auf Klick” auch da. </p>
<p><strong>Zusammenfassung:</strong></p>
<p>Prerendering ist eine interessante Technologie, die hoffentlich auch von anderen Browserherstellern zum Einsatz kommt. Man muss jedoch genau überlegen, wann sich der Einsatz lohnt.</p>
<p>Technisch kann man es via ein &lt;link rel=”prerender” href=”…”&gt; aktivieren. Voraussetzung ist natürlich, dass der Browser das auch kennt – was momentan nur der Chrome in Version 13 kann.</p>
<p><strong>Ausblick</strong></p>
<p>Damit ein Seitenbetreiber auch weiß, was der Browser überhaupt beim Prerendering “sieht” hat Google auch eine <a href="http://code.google.com/chrome/whitepapers/pagevisibility.html">Page Visibility API</a> vorgeschlagen.</p>






<p>[ <a href="http://code.google.com/p/code-inside/source/browse/#git%2F2011%2FChromePrerender"><strong>Democode auf Google Code</strong></a><strong> |</strong> <a href="{{BASE_PATH}}/assets/files/democode/chromeprerender/chromeprerender.zip">Download als Zip</a> ]</p>
