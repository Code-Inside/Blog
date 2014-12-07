---
layout: post
title: "HowTo: Ein iPhone Homescreen Icon für die eigene Webseite anbieten"
date: 2009-12-12 22:23
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, Icon, iPhone]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image883.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="146" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb68.png" width="99" align="left" border="0"></a>Wer ein iPhone (oder ein iPod Touch) sein eigen nennt kann auch sehr bequem im Internet surfen. Dabei kann man auch Lesezeichen auf sein Homescreen setzen. Im Standardfall macht das iPhone dabei ein Screenshot der Webseite und nimmt dies als Icon. Das Favicon ist dem iPhone egal. Professioneller und mit nur wenig Aufwand kann man aber auch sein eigenes iPhone Favicon definieren.</p><p><strong>Ziel:</strong> </p> <p>Wir wollen unser eigenes, cooles iPhone Bookmark Icon haben.</p> <p><strong>Für das optimale Resultat:</strong></p> <ul> <li>Größe: 57 x 57 Pixel, wenn es größer ist, skaliert das iPhone das Bild</li> <li>Quadratisch</li> <li>Keine Glossy oder Spiegeleffekte, auch das macht das iPhone</li> <ul> <li>Man kann dem iPhone OS auch sagen, dass er dies nicht machen soll. Mehr dazu beim "Einbinden"</li></ul> <li>Keine Alpha Transparenzen</li> <li>Bildformat PNG </li> <li>Fazit: Nur das pure Logo nutzen. iPhone OS macht den Rest im iPhone Style</li> <li><a href="http://developer.apple.com/iphone/library/documentation/UserExperience/Conceptual/MobileHIG/IconsImages/IconsImages.html">Offizielle Apple Developer Seite</a></li></ul> <p><strong>Einbinden ins HTML</strong></p> <p><strong>1. Variante:</strong> Bilddatei ins Stammverzeichnis legen</p> <p>Das iPhone sucht im Root der WebApp nach folgenden zwei Files:</p> <ul> <li>"apple-touch-icon.png" </li> <li>oder "apple-touch-icon-precomposed.png" wenn man schon selber Glanzeffekte hinzugefügt hat.</li></ul> <p><strong>2. Variante:</strong> Bild verlinken</p> <p>Im Header folgende &lt;link&gt; Tags einfügen:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:51ff0bfe-082f-466d-98d8-01106d43cccd" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;link rel="apple-touch-icon" href="/icons/iphone_favicon.png" /&gt;</pre></div>
<p>Oder für die Variante, dass man das Icon schon mit Glanzeffekten ausgestattet hat:</p>
<p>
<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6e47a33b-7efd-4368-9cf3-aefaaa455c54" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;link rel="apple-touch-icon-precomposed" href="/icons/iphone_favicon.png" /&gt;  </pre></div></p>
<p>So eingebaut habe ich die ganze Sache mal bei "<a href="http://www.diesachsen.de">DieSachsen.de</a>" :)</p>
<p>Easy, oder? Eine nette Spielerei und sieht auf dem iPhone einfach schicker aus ;)<br>Die Inspiration von dem HowTo kam von diesem <a href="http://buildinternet.com/2009/12/give-your-website-a-custom-iphone-bookmark-icon/">Blogpost</a>, also nicht wundern dass diese ähnlich sind. </p>
