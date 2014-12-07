---
layout: post
title: "HowTo: Visual Studio immer als Admin starten"
date: 2010-05-16 23:11
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [UAC, Visual Studio]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image972.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb156.png" width="196" height="120" /></a> </p>  <p>Wer den <a href="{{BASE_PATH}}/2009/03/19/howto-iis7-als-development-server-im-visual-studio-2008-einrichten/">richtigen IIS als Development Server</a> nimmt, der wird das Problem unter Vista &amp; Win7 kennen:    <br /> Solange die Benutzerkontensteuerung/UAC nicht ausgeschalten ist, muss man erst mühsam über *Rechtsklick* *Als Admin ausführen* klicken. Mit einem kleinen Trick spart man sich das Geklicke im Kontextmenü.</p>  <p><strong>"Programm als Administrator ausführen”</strong></p>  <p>Diese Einstellung kann man im Kompatibilitätstab in den Eigenschaften machen:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image973.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb157.png" width="269" height="378" /></a> </p>  <p>Bei einem Doppelklick auf ein .SLN File wird diese Exe aufgerufen:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d124fd5f-85d6-4fe6-885c-902d301ac08b" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Program Files (x86)\Common Files\microsoft shared\MSEnv\VSLauncher.exe
</pre></div>

<p>Die normale Exe liegt dort:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d7069844-3cc5-40eb-946b-66ac71198f3d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\devenv.exe</pre></div>

<p></p>

<p></p>

<p>Diese Einstellung<strong> bei beiden Dateien</strong> machen. Ohne weitere Änderungen der UAC kommt weiter der "Warndialog” - allerdings vergisst man nun nicht mehr VS als Admin auszuführen und man muss nicht in Kontextmenüs nach dem "Als Admin ausführen” suchen. </p>

<p>Wer Desktop Programme entwickelt sollte sich allerdings im Hinterkopf behalten, dass sein Programm auch ohne Admin-Rechte laufen sollte - jedenfalls für den gewöhnlichen Nutzer.</p>
