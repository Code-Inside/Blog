---
layout: post
title: "Die Retina/HiRes Displays kommen! HD-Web ahoi!"
date: 2012-04-30 13:30
author: robert.muehsig
comments: true
categories: [Allgemein]
tags: [HD, Retina]
---
{% include JB/setup %}
<p>Das coolste am iPad 3? Das Display. Nach <a href="http://www.codinghorror.com/blog/2007/06/where-are-the-high-resolution-displays.html">jahrelangem Warten auf High Resolution Displays</a> kommt wieder Bewegung in den Markt rein. Das Ganze hat natürlich auch Auswirkungen auf die Web-Entwicklung, denn niemand möchte verwaschene Bilder sehen oder noch Schlimmeres: Ein gänzlich kaputtes Design. Wie kann man High-Resolution Displays erkennen? Und auf was muss man evtl. sonst noch achten? </p> <p><em>Ich bin kein Full-Time Web Designer, daher hat der Artikel eine gewisse unschärfe ;) Korrekturen können gerne über die Kommentare angestoßen werden. </em></p> <p><strong>Was ist das besondere von Retina / High Resolution Displays?</strong></p> <p>Bei diesen Displays ist die Pixeldichte wesentlich höher, d.h. dass man z.B. wesentlich detailreichere Bilder unterbringen kann. Als Beispiel dient hier ein Bild-Vergleich zwischen iPad 2 und iPad 3 von <a href="http://www.theverge.com/">TheVerge.com</a></p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1521.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb688.png" width="409" height="264"></a>&nbsp;</p> <p>Ziemlich beeindruckend, oder?</p> <p><strong>High Resolution Bilder an Hi-Res / Retina Displays ausliefern</strong></p> <p>Momentan tauchen immer mehr Javascript-Bibliotheken auf, welche sich an der Grundstruktur von Apple orientieren. Apple hatte bei der Einführung des <a href="http://developer.apple.com/library/ios/#documentation/2DDrawing/Conceptual/DrawingPrintingiOS/SupportingHiResScreens/SupportingHiResScreens.html">iPhone 4 ein Benamungsschema</a> festgelegt:</p> <p><strong>Non-Retina-Displays:</strong> Mein-Bild.png</p> <p><strong>Retina-Displays:</strong> <a href="mailto:Mein-Bild@2x.png">Mein-Bild@2x.png</a></p> <p>Idee ist, dass ein Framework automatisch die höher aufgelösten Fotos nimmt, wenn welche vorhanden sind. So kommen sowohl Non-Retina Displays als auch Retina-Displays zum Zug und zeigen ihr möglichstes an.</p> <p><strong>Wie Apple auf Apple.com Bilder fürs iPad 3 ausliefert</strong></p> <p><a href="http://www.apple.com/"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image1522.png" width="540" height="326"></a></p> <p><em>(Bild von </em><a href="http://apple.com"><em>Apple.com</em></a><em>)</em></p> <p>Natürlich hat Apple als erster eine Unterstützung für das iPad 3 Display auf Apple.com eingebaut. <a href="http://blog.cloudfour.com/how-apple-com-will-serve-retina-images-to-new-ipads/">Hier</a> gibt es eine vollständige Analyse, was Apple genau macht. Im Grunde funktioniert es so:</p> <p>- normale Apple.com Seite samt Bilder werden runtergeladen</p> <p>- Script prüft ob es ein iPad mit Retina Display ist</p> <p>- Wenn es ein Retina Display ist:</p> <p>&nbsp; - für einige Bilder Bilder (z.B. das Hauptbild auf Apple.com) wird ein HEAD Request nach dem _2x.png Bild gemacht (warum auch immer Apple hier kein “@” rein gemacht hat)</p> <p>- wenn gefunden wird dies runtergeladen und mit dem normalen ersetzt.</p> <p>Wer es selber testen möchte, der kann im Chome diese Codes in die Konsole hacken:</p> <p> <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:10bebb4d-9afa-4111-a5b6-841a47b168c2" class="wlWriterEditableSmartContent"><pre name="code" class="c#">AC.Retina._devicePixelRatio = 2
new AC.Retina</pre></div></p>
<p>&nbsp;</p>
<p>Hervorzuheben ist, dass hier natürlich die Datenleitung recht stark beansprucht wird, da die Bilder quasi “doppelt” runtergeladen werden und die Retina Images wesentlich größer sind.</p>
<p>Non-Retina:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1523.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb689.png" width="599" height="54"></a></p>
<p>Retina-Display:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1524.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb690.png" width="609" height="59"></a></p>


<p>Die Retina Version ist also <strong>3 mal</strong> größer als das normale Bild! </p>
<p><strong>Retina-JavaScripts für die eigenen WebApp</strong></p>
<p><strong><a href="http://retinajs.com/">Retina.js</a></strong> geht einen ähnlichen Weg und hält sich an das Benamungsschema von den iOS Devices (d.h. mit @2x) </p>
<p><a href="http://retinajs.com/"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image1525.png" width="524" height="336"></a></p>


<p>Grundsätzlich bindet man nur das Script ein und das Script sucht nach allen img-Tags auf der Seite und prüft ob es eine Retina Version gibt.</p>
<p>Für Background-Bilder in der CSS gibt es ein <a href="https://github.com/imulus/retinajs/blob/master/src/retina.less">.LESS Mixin</a>, welches ein Media-Query erzeugt und das Bild wird entsprechend ausgeliefert. D.h. Retina Displays bekommen eine HighRes Version, nicht HighRes Geräte bekommen ein normales Image. </p>
<p>Den Code gibt es bei <a href="https://github.com/imulus/retinajs">GitHub</a>. Negativ bei der Variante: Ähnlich wie bei Apple werden Bilder doppelt heruntergeladen.</p>
<p><strong><a href="https://github.com/adamdbradley/foresight.js">Foresight.js</a></strong> will dieses Problem angehen. Das Script soll vor dem eigentlich abrufen der Bilder bereits prüfen ob das Dislay HighRes fähig ist, wenn es das ist und die Bandbreite auch “passt” (was auch immer das heisst), dann wird gleich das HighRes Bild runtergeladen. Es gibt <a href="http://foresightjs.appspot.com/demos/">einige Demos</a>, welche allerdings ein HighRes Display erfordern (welches ich leider nicht besitze). Rein von den Features her scheint es etwas cleverer als Retina.js zu sein:</p>
<ul>
<ul>
<ul>
<ul>
<li><em>Request hi-res images according to device pixel ratio </em>
<li><em>Estimates network connection speed prior to requesting an image </em>
<li><em>Allows existing CSS techniques to control an image's dimensions within the browser </em>
<li><em>Implements image-set() CSS to control image resolution variants </em>
<li><em>Does not make multiple requests for the same image </em>
<li><em>Javascript library and framework independent (ie: jQuery not required) </em>
<li><em>Image dimensions set by percents will scale to the parent element's available width </em>
<li><em>Default images will load without javascript enabled </em>
<li><em>Does not use device detection through user-agents </em>
<li><em>Minifies to 7K</em></li></ul></ul></ul></ul>
<p><strong></strong>&nbsp;</p>
<p><strong>Bald wieder Ladebildschirme für Webseiten? Wo High-Res kein Spaß mehr macht…</strong></p>
<p>Wenn wirklich jede Seite demnächst mit High-Resolution Bildern glänzen möchte, ist das auf der einen Seite sehr schön: Klare und Detailierte Bilder machen immer Spaß auf mehr. Wer allerdings mobil Unterwegs ist oder kein schnelles Internet daheim hat, der wird vermutlich schnell genervt sein. UMTS wird einem ja inzwischen hinterher geworfen, allerdings auch mit einem bestimmten Datenlimit und die <a href="http://www.zdnet.de/magazin/41515603/internet-per-umts-so-faelschen-deutsche-provider-webinhalte.htm">Provider selbst manipulieren auch das Web um Bytes zu sparen</a>. Ob man am Ende wieder Ladebalken sieht bevor man den Inhalt einer Seite aufruft (so gesehen früher bei einigen Flash-Seiten)? </p>
<p><strong>SVGs, Icons-Fonts &amp; Responsive Designs</strong></p>
<p>Bislang hatte ich nur von Bildern gesprochen, natürlich gibt es noch weit mehr Themenfelder. Ein Punkt wären z.B. wie man mit Icons umgeht – hier sind <a href="{{BASE_PATH}}/2012/04/09/iconfont-font-awesome-in-asp-net-nutzen/">Icon-Fonts</a> eine interessante Idee. Das Thema Responsive Design und SVGs spielen natürlich auch eine Rolle – zu diesem Thema hatte ich <a href="http://medialoot.com/blog/high-resolution-web/">diesen Blogpost gefunden</a>.</p>
<p><strong>Gibt es HighRes Displays für Windows und Erfahrung in der Web-Entwicklung mit HighRes Images?</strong></p>
<p>Auch wenn ich hier immer von High-Res Displays geschrieben habe, ist das einzig mir wirklich bekannte das iPad 3 Display. Kennt jemand alternativen? Oder wird es erst mit <a href="http://blogs.msdn.com/b/b8/archive/2012/03/21/scaling-to-different-screens.aspx">Windows 8 ein neuen Schwung in diesem Bereich</a> geben? Wer einen Mac besitzt (und ein iPad 3), der kann diesen als High-Res Display nutzen. Wer Alternativen in der Windows Welt kennt – immer her damit :) Kennt ihr jemanden, welche bereits extra Bilder nur für das iPad 3 ausliefert? Würde mich interessieren!</p>
<p><em>PS: Wer überlegt sich ein iPad 3 zu holen, der kann dies auch gern über </em><a href="http://astore.amazon.de/codeinside-21/detail/B007IV5PI6"><em><strong>unseren Amazon Shop</strong></em></a><em> machen und so unsere Arbeit unterstützen :)</em></p>
