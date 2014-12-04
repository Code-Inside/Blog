---
layout: post
title: "Custom-URI-Handler: Aus dem Web mit dem Desktop reden – so wie Spotify & GitHub for Windows"
date: 2013-08-04 23:01
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Protocol, URI]
language: de
---
{% include JB/setup %}
<p>Aus einer Desktop Anwendung ein Link aufrufen ist eine recht triviale Angelegenheit – andersherum allerdings nicht ganz so offensichtlich. </p> <p>Möchte man eine lokale (Windows-) Anwendung über eine Web-Applikationen “fernsteuern” gibt es einen recht eleganten Weg: <a href="http://msdn.microsoft.com/en-us/library/aa767914(v=vs.85).aspx"><strong>Custom URI Handler</strong></a><strong>.</strong></p> <h3>Wie sieht das in der Realität aus?</h3> <p>Nehmen wir als Beispiel GitHub. Hat man den GitHub for Windows Client installiert funktioniert das “Clonen” (jedenfalls im Chrome bei mir) mit einem klick.</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1877.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1018.png" width="574" height="322"></a> </p> <p>Interessant ist hier natürlich die URI die verwendet wird “<strong>github-windows</strong>://…”</p> <p>Anderes Beispiel wäre Spotify:</p> <p>Bevor es bei Spotify den Web-Player gab musste man zwangsläufig auch immer die Applikation haben. Auch hier gibt es ein besonderes URI-Schema, z.B. wenn ich dies aufrufe <strong>“spotify</strong>:track:4bz7uB4edifWKJXSDxwHcs” möchte das System auch den Spotify-Player öffnen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1878.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1019.png" width="429" height="319"></a> </p> <p>Letztes Beispiel: Auch über die TFS WebApp kann ich Visual Studio öffnen lassen:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1879.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1020.png" width="507" height="360"></a> </p> <h3>Ok… cool – wie funktioniert das genau?</h3> <p>Die genauste Beschreibung davon findet man in der <a href="http://msdn.microsoft.com/en-us/library/aa767914(v=vs.85).aspx">MSDN</a>. Aber das ganze basiert im Grunde nur auf Registry-Einträgen.</p> <p>Unter “HKEY_CURRENT_USER\Software\Classes” (bzw. HKEY_LOCAL_MACHINE) müsste z.B. solch ein Eintrag gemacht werden:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1880.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1021.png" width="192" height="92"></a> </p> <p>Das “DefaultIcon” enthält nur das Icon. Unter “command” ist am Ende der wirkliche Aufruf wobei “%1” mit dem Teil der nach “spotify:…” ersetzt wird.</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">[HKEY_CURRENT_USER\Software\Classes\spotify]
"URL Protocol"=""

[HKEY_CURRENT_USER\Software\Classes\spotify\DefaultIcon]
@="\"C:\\Users\\Robert\\AppData\\Roaming\\Spotify\\Spotify.exe\",0"

[HKEY_CURRENT_USER\Software\Classes\spotify\shell]

[HKEY_CURRENT_USER\Software\Classes\spotify\shell\open]

[HKEY_CURRENT_USER\Software\Classes\spotify\shell\open\command]
@="\"C:\\Users\\Robert\\AppData\\Roaming\\Spotify\\Spotify.exe\" /uri %1"

</pre>
<h3>Default Programs – Set Associations</h3>
<p>In Windows kann man über die System-Steuerung die Standard-Programme für einen bestimmten Datei-Typ oder Protokoll wählen, allerdings taucht <strong>keines</strong> unserer 3 Beispiele da auf. Evtl. könnte man dies beheben wenn man diesen <a href="http://msdn.microsoft.com/en-us/library/cc144109%28VS.85%29.aspx#client_typespecific_information">MSDN Artikel vollständig versteht</a> (und mal ausprobieren würde) – für die Funktionsweise des eigenen URI-Handlers ist das aber kein Problem. Wer das rausbekommt kann mir aber gern die Lösung in den Kommentaren schreiben :)</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1881.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1022.png" width="482" height="550"></a> </p>
<h3>Windows 8 &amp; Metro-Apps</h3>
<p>Seit Windows 8 gibt es eine ganze Reihe an neuen URI-Handlers, so z.B. die verschiedenen Bing-Apps. Auch die eigene Windows 8 App kann Dateitypen bzw. Protokolle <a href="http://code.msdn.microsoft.com/windowsapps/Association-Launching-535d2cec#content">adressieren</a>. Ähnliches geht auch für <a href="http://msdn.microsoft.com/en-us/library/windowsphone/develop/jj206987(v=vs.105).aspx">Windows Phone 8</a>. Die Registry-Einträge für die Metro-Apps sind im Grunde nur Einzeiler und wie genau das da funktioniert weiss ich leider auch noch nicht.</p>
<h3>Fazit</h3>
<p>Man kann sehr einfach eigene Protokoll-Handler in Windows integrieren und das solch eine Verbindung zwischen Web- und Desktop Sinn macht sieht man z.B. an GitHub sehr gut.</p>
