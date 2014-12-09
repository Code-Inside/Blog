---
layout: post
title: "Windows Phone Fonts – wenn Visual Studio “lügt”"
date: 2013-04-22 22:45
author: robert.muehsig
comments: true
categories: [HowTo, Windows Phone]
tags: [Fonts, Windows Phone]
language: de
---
{% include JB/setup %}
<p>Heute bin ich auf ein kleines Problem gestossen: Meine Windows Phone App wollte meinen ausgefählten Font nicht anzeigen – auch einige andere gingen nicht. </p> <p>Obwohl der Visual Studio Designer die Fonts durchaus anzeigt:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1828.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb981.png" width="299" height="502"></a> </p> <p>Im Emulator ist davon allerdings nichts mehr zu sehen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images-de/image1829.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb982.png" width="295" height="496"></a> </p> <p><strong>Grund hierfür:</strong></p> <h3>Windows Phone enthält nicht alle Schriftarten wie Windows</h3> <p>D.h. bei der Wahl der Schriftarten sollte man darauf achten, dass sie mit Windows Phone kompatibel sind. </p> <p>Ich hab zwei Seiten gefunden welche verfügbare Fonts auflisten:</p> <p><a href="http://msdn.microsoft.com/en-us/library/ff806365%28v=vs.95%29.aspx">Fonts in Silverlight for Windows Phone</a></p> <p><a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/cc189010(v=vs.105).aspx">Text and fonts for Windows Phone</a></p> <p>PS: Comic Sans ist natürlich verfügbar ;)</p>
