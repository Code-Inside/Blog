---
layout: post
title: "Damit sich der TFS TeamBuild so verhält wie ein lokales Visual Studio - das “OutDir” Property"
date: 2013-03-16 11:16
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [TeamBuild, TFS]
language: de
---
{% include JB/setup %}
<p>Wer die Teambuilds des TFS einsetzt kennt vermutlich das <a href="http://social.msdn.microsoft.com/Forums/en-US/tfsbuild/thread/7126f1a3-9437-416a-88ed-2f63f84b2937">Problem</a>, dass beim Bauen der Solution der TFS automatisch sämtlichen Projekt-“Output” in ein “Binaries” Verzeichnis umlenkt. Die Standard Templates gehen wohl davon aus, dass eine Solution nur einen Output hat, allerdings hab ich dies bislang nur selten so vorgefunden und selbst da find ich die Idee nicht besonders clever.</p> <p><strong>Build-Process Templates bearbeiten</strong></p> <p>Damit der TFS die Solution genau so baut wie der normale Visual Studio Client muss man das Build-Process Template bearbeiten. Das Template ist eine .xaml Datei und ist ziemlich gross und auch nicht wirklich übersichtlich.</p> <p><strong>Lösung</strong></p> <p>Am einfachsten öffnet ihr die .xaml Datei mit einem Texteditor eurer Wahl und such die Zeile mit <strong>“&lt;mtbwa:MSBuild”</strong>. An dieser Stelle ruft der Prozess MSBuild auf. In den Standard-Templates ist das genau 2 mal der Fall (Build &amp; Clean).</p> <p><strong>Löscht</strong> im mtbwa:MSBuild Tag <strong>das Attribute “OutDir” </strong>und der TFS lenkt den Output nicht mehr um.</p> <p>Alternativ kann man sich im Prozess-Editor auch bis an die Stelle klicken:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image1790.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb944.png" width="240" height="216"></a> </p> <p>Gefunden hab ich diese einfache Variante <a href="http://bartwullems.blogspot.ch/2012/07/tfs-build-output-build-results-to.html">hier</a>.</p>
