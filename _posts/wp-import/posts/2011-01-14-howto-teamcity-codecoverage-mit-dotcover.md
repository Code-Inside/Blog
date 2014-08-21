---
layout: post
title: "HowTo: TeamCity & CodeCoverage mit dotCover"
date: 2011-01-14 01:01
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [BizzBingo, CI, dotCover, NUnit, TeamCity]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1156.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb338.png" width="132" height="119" /></a> </p>  <p>Vor etwas längerer Zeit habe ich bereits über <a href="{{BASE_PATH}}/2009/07/14/howto-continuous-integration-mit-teamcity/">"TeamCity” als CI Tool</a> geschrieben und wie man <a href="{{BASE_PATH}}/2009/07/14/howto-teamcity-mstests/">MSTest einbinden</a> kann. Im <a href="{{BASE_PATH}}/2011/01/06/bullshit-bingo-online-mit-bizzbingo-rtw/">BizzBingo</a> Projekte nutzen wir NUnit und seit <a href="http://www.jetbrains.com/teamcity/">TeamCity 6.0</a> ist Jetbrains dotCover auch direkt mit integriert. Wie das genau aussieht, erfahrt ihr in dem Post.</p> <!--more-->  <p><strong>1. Schritt: Build Configuration anlegen</strong></p>  <p>Der ScreenShot stammt vom Nightly Build und hat eigentlich nix besonders.</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1157.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb339.png" width="508" height="140" /></a> </p>  <p><strong>2. Version Control Settings</strong></p>  <p>Das müsst ihr je nach Projekt entsprechend einstellen, aber auch hier sind keine Besonderheiten zu beachten. Wir ziehen den Source über die SVN Schnittstelle von Codeplex.</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1158.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb340.png" width="509" height="88" /></a> </p>  <p><strong>3. Jetzts wird es interessant...</strong></p>  <p>Mein "Nightly” hat 3 Build-Steps, wobei nur zwei hier in diesem Blogpost relevant sind:</p>  <p>- Bau die ganze SLN mit "Rebuild” / "Debug”&#160; (hier könnte aber auch ein MSBuild etc. angegeben werden)   <br />- Nimm den NUnit Test Runner und checke die Code Coverage über dotCover</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1159.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb341.png" width="536" height="144" /></a> </p>  <p></p>  <p>Wir schauen uns genauer den zweiten Schritt genauer an:</p>  <p><strong>NUnit Testrunner Configuration:</strong></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1160.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb342.png" width="533" height="246" /></a> </p>  <p>Wir haben die NUnit Version 2.5.8 installiert und in der Textbox "Run tests from” ist folgendes drin:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:bad824ab-c25c-457c-b3c0-ff0a099b70ec" class="wlWriterEditableSmartContent"><pre name="code" class="c#">%system.teamcity.build.checkoutDir%\Main\Source\BusinessBingo\Tests\*\bin\Debug\*Tests.dll</pre></div>

<p><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb333.png" />Da wir die gesamte SLN bauen mit "Debug” wird entsprechend unserem Source Tree die Ergebnisse in den jeweiligen bin Ordnern abgelegt.</p>

<p>Durch Wildcards findet der Runner unsere Tests wie z.B. BusinessBingo.Commandhandler.Tests.dll und führt diese aus.</p>

<p>Wenn wir nun doch noch neue Test Projekte hinzufügen, erscheinen diese automatisch mit im Build - "<a href="http://en.wikipedia.org/wiki/Convention_over_configuration">Convention over Configuration</a>”.</p>

<p>&#160;</p>

<p>&#160;</p>

<p>&#160;</p>

<p>&#160;</p>

<p><strong>Nun laufen die Unit Tests... nun zu dotCover.</strong></p>

<p>Im neusten TeamCity 6.0 ist dotCover direkt mit eingebaut, d.h. man braucht keine dotCover Installation auf dem Buildserver vornehmen. Die Konfiguration ist sehr simpel gestaltet:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1161.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb343.png" width="500" height="250" /></a> </p>

<p>Durch die Filter, weißt man dotCover an welcher Code beim UnitTesting für die CodeCoverage auch beachtet werden soll.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d3a8385b-92a0-4e72-98a7-2e8590a29575" class="wlWriterEditableSmartContent"><pre name="code" class="c#">+:BusinessBingo.*
-:BusinessBingo.*Test*</pre></div>

<p>Wichtig hier: <strong>Kein</strong> ".dll” angeben, sondern nur den Namen. Mit "+” sagt man: Untersuche Assemblies mit diesem Namensschema (auch hier gehen Wildcards) und mit "-" sage ich, dass dort keine CodeCoverage beachtet werden soll. </p>

<p><em>Kleiner Tipp noch: Falls alles richtig gemacht wurde, aber kein Report geniert wird - schaut ins BuildLog. Am Anfang gab es bei mir solch einen Fehler:</em></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:18edcb04-4513-4d79-80e9-8411f18c91d7" class="wlWriterEditableSmartContent"><pre name="code" class="c#">Failed to read source file 'C:\TeamCity\buildAgent\temp\buildTmp\dotcover8583844779204955574.xml'. Could not find a part of the path 'C:\Windows\system32\config\systemprofile\AppData\Local\Temp\4q-kqg6z.tmp'.</pre></div>

<p><em>Lösung davon: </em></p>

<p><em>Unter "C:\Windows\system32\config\systemprofile\AppData\Local\” den gesuchten "Temp” Ordner anlegen - der existiert im Standardfall nicht und scheinbar gibt es da Probleme. Danach geht es aber und läuft stabil.</em></p>

<p><strong>Was hat man nun?</strong></p>

<p>Schicke Unit-Tests, welche nun auch vom Buildserver ausgeführt werden:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1162.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb344.png" width="471" height="189" /></a> </p>

<p>Code Coverage für die angegebenen Assemblies:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1163.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb345.png" width="488" height="183" /></a> </p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p>Hier kann man bis auf die .cs Datei reinschauen, was genau durchlaufen wird oder nicht:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1164.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb346.png" width="510" height="185" /></a> </p>

<p>Sowie eine nette, kleine Übersicht:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1165.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb347.png" width="510" height="135" /></a> </p>

<p>Fetzt und ist in kurzer Zeit eigentlich für die einfachsten Zwecke eingerichtet.</p>
