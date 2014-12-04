---
layout: post
title: "HowTo: Codeabhängigkeiten mit NDepend & TeamCity messen"
date: 2011-02-14 23:59
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [BizzBingo, Code, HowTo, NDepend, TeamCity]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1182.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb362.png" width="244" height="67" /></a> </p>  <p><a href="http://www.ndepend.com/">NDepend</a> ist ein Tool, welches Abhängigkeiten zwischen .NET Komponenten misst. Das ganze gibt es als Fatclient, welches sich hervorragend in Visual Studio integriert und es gibt eine Konsolenanwendung, welche man in seinem Buildprozess integrieren kann - <a href="http://www.ndepend.com/SampleReports.aspx">zum Erzeugen von Reports</a>. Wie das ganze geht zeig ich euch...</p>  <p><strong>Was benötigt man? </strong></p>  <p>Für das erste Erstellen der NDepend Datei und eine bessere Auswertung ist natürlich der Fatclient ein Must-Have. Allerdings denke ich nicht, dass jeder das Tool installiert haben muss. Ich fokusiere mich hier vor allem auf den Einsatz von NDepend im Buildprozess, daher:</p>  <p>Am wichtigsten ist die Installation auf dem Buildserver :)</p>  <p>Kurz zur allgemeinen Erklärung von NDepend: Das Tool muss man für jeden Entwickler bzw. jede Buildmaschine lizensieren. Die genauen Lizenzdetails findet man auf der <a href="http://www.ndepend.com/Purchase.aspx">NDepend Seite</a>.</p>  <p><strong>NDepend Quickstart</strong></p>  <p>Wie man mit NDepend startet ist in diesem Video recht gut erklärt: <a href="http://www.ndepend.com/GettingStarted.aspx">Getting started</a>. Einen guten Überblick und eigene Eindrücke gibt es auch hier nachzulesen:</p>  <p><a href="http://dotnet-forum.de/KnowledgeBase/articles/2009/01/21/326-codeanalyse-mit-ndepend.aspx">Codeanalyse mit NDepend</a></p>  <p>Was wir für das weitere Vorgehen brauchen ist die .ndproj Datei. Diese sollte am Ende rauskommen. Bei dem <a href="http://www.bizzbingo.de">BizzBingo.de</a> Projekt (<a href="http://businessbingo.codeplex.com/">Codeplex</a>) haben wir die Datei mit in der SLN:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1183.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb363.png" width="244" height="243" /></a> </p>  <p>Die ndproj beschreibt alle Einstellungen von NDepend für das Projekt. Das ganze ist eine XML Datei.</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p><strong>.ndproj</strong></p>  <p>Um ein Gefühl für die Datei zu bekommen hier ein stark verkürzter Einblick:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ca49b947-3819-4231-b80a-31772f2e3045" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8" standalone="yes"?&gt;
&lt;NDepend AppName="BusinessBingo" Platform="DotNet"&gt;
  &lt;OutputDir KeepHistoric="True" KeepXmlFiles="True"&gt;C:\TFS\bb\Main\Source\NDependOut&lt;/OutputDir&gt;
  &lt;Assemblies&gt;
    &lt;Name&gt;BusinessBingo.Data&lt;/Name&gt;
    &lt;Name&gt;BusinessBingo.Model&lt;/Name&gt;
	&lt;Name&gt;ASSEMBLIES...&lt;/Name&gt;
	...
  &lt;/Assemblies&gt;
  &lt;FrameworkAssemblies /&gt;
  &lt;Dirs&gt;
	&lt;Dir&gt;INPUT DIRs&lt;/Dir&gt;
    &lt;Dir&gt;C:\Windows\Microsoft.NET\Framework\v4.0.30319&lt;/Dir&gt;
  &lt;/Dirs&gt;
  ...
  &lt;CQLQueries...&gt;
&lt;/NDepend&gt;</pre></div>

<ul>
  <li>Assemblies: Alle .NET Assemblies, welche NDepend für die Abhängigkeiten mit beachtet</li>

  <li>Dirs: Hier werden die Ordner beschrieben in denen die Assemblies liegen - diese Property kann man über die Konsole auch mit reingeben. Dazu später mehr</li>

  <li>Dann folgen noch weitere Einstellungen, welche hier erst mal keine weitere Bedeutung haben.</li>

  <li>Die CQLQueries definieren die Codemetriken und ob dies als "Warning” oder "Error” gewertet werden soll. Spielt aber erst einmal auch keine Rolle :)</li>
</ul>

<p><strong>TeamCity</strong></p>

<p>NDepend wird bei BizzBingo im Night Build mit ausgeführt. Der Nightly Build hat momentan vier Schritte:</p>

<ul>
  <li>SLN Bauen</li>

  <li>NUnit (ist hier auch egal)</li>

  <li>NDepend</li>

  <li>Duplicate Finder (ist hier egal)</li>
</ul>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1184.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb364.png" width="485" height="285" /></a> </p>

<p>Für NDepend ist a) das bauen wichtig und b) das Ausführen des Konsolenprogramms für NDepend. Für das analysieren benötige ich die Assemblies und ich <strong>baue einfach die SLN</strong>. Das ist nicht der beste Weg, aber passt schon:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1185.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb365.png" width="491" height="375" /></a> </p>

<p>Nun kommt NDepend. Wenn man die Version für die Buildmaschine installiert, gibt es das Konsolenprogramm mit. Dem Konsolenprogramm kann man bestimmte Eigenschaften, wie z.B. das "Quellverzeichnis” für die Assemblies und das "Zielverzeichnis” für den generierten Report als Parameter mitgeben. Im TeamCity sieht das so aus:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1186.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb366.png" width="507" height="287" /></a> </p>

<p>Command: (je nachdem wo man es installiert)</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7e67dd14-5d3c-4b2e-ae4f-a336e96ffda9" class="wlWriterEditableSmartContent"><pre name="code" class="c#">"C:\NDepend\NDepend.Console.exe"</pre></div>

<p>Parameters:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:159c1385-4bcf-445f-9dd8-355c3a553def" class="wlWriterEditableSmartContent"><pre name="code" class="c#">"%system.teamcity.build.checkoutDir%\Main\Docs\CodeQuality\BusinessBingo.ndproj" /OutDir "%system.teamcity.build.checkoutDir%\NDependOut" /InDirs "%system.teamcity.build.checkoutDir%\Main\Source\BusinessBingo\Source\BusinessBingo.Web\bin\"</pre></div>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<ul>
  <li>Erster Parameter gibt den Ort der .ndproj Datei an. %system.teamcity.build.checkoutDir% ist ein Platzhalter, welcher von TeamCity während des Buildvorgangs entsprechend ersetzt wird</li>

  <li>Als OutDir gebe ich "NDependOut” im checkoutDir an. </li>

  <li>Als InDir gebe ich das bin Verzeichnis der Webapplikation an -hier könnte man auch auf andere Ordner etc. verweisen.</li>
</ul>

<p><strong>TeamCity Artefakte und den NDepend Report integrieren</strong></p>

<p>Nachdem nun das eingerichtet ist, kommen wir zum Konzept der Artefakte in TeamCity. Ein Artefakt kann alles sein: Eine Assembly, ein Bild, ein HTML Template etc. - </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1187.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb367.png" width="421" height="275" /></a> </p>

<p>Bei BizzBingo.de haben wir im TeamCity für den Nightlybuild momentan folgende Artefakte eingestellt:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:113687df-cd2d-41b6-962f-86f28f0b6777" class="wlWriterEditableSmartContent"><pre name="code" class="c#">%system.teamcity.build.checkoutDir%\Main\Source\BusinessBingo\Source\BusinessBingo.Web\bin\BusinessBingo.*.dll =&gt; Assemblies
%system.teamcity.build.checkoutDir%\Main\Source\BusinessBingo\Source\BusinessBingo.Web\bin\BusinessBingo.*.pdb =&gt; Assemblies
%system.teamcity.build.checkoutDir%\NDependOut\**\* =&gt; Reports\NDepend
%system.teamcity.build.checkoutDir%\Main\Docs\HtmlTemplate\**\* =&gt; HtmlTemplate.zip</pre></div>

<p>Die ersten beiden sind die Dlls/Pdbs - der "=&gt;” gibt an, in welchen Artefaktordner es kopiert werden soll. Dabei können Wildcards eingesetzt werden oder wie in Zeile 4 kann man auch Datein automatisch zippen lassen. </p>

<p>Ergebnis:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1188.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb368.png" width="458" height="560" /></a></p>

<p>Wichtig ist hier Zeile 3. Dort nehmen wir die generierten Report Daten aus dem Buildschritt vom "NDependOut” Dir und verschieben diese zum Artefaktpfad Reports\NDepend.</p>

<p> NDepend Reports Tab integrieren</p>

<p>Um nun noch den HTML Report im TeamCity anzuzeigen muss man in der Serverkonfiguration folgendes noch einstellen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1189.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb369.png" width="485" height="152" /></a> </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1190.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb370.png" width="463" height="195" /></a> </p>

<p>Für jeden Build wird der Report gesucht. Wenn die Datei bei den Artefakten im Build gefunden wird, wird auch der Report Tab angezeigt:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1191.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb371.png" width="534" height="300" /></a> </p>

<p>Fertig.</p>

<p><strong>TL;DR</strong></p>

<p><u>Wichtigste Schritte:</u></p>

<ul>
  <li>.ndproj Datei anlegen</li>

  <li>NDepend auf Buildserver installieren</li>

  <li>Die Assemblies, welche in der .ndproj Datei drin stehen müssen irgendwie gebaut werden oder als Artefakt vorliegen</li>

  <li>Den erzeugten Report als Artefakt im TeamCity ablegen</li>

  <li>TeamCity den "NDepend Report” in der Serververwaltung bekannt machen</li>

  <li>Anschauen :)</li>
</ul>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p><a href="http://www.troyhunt.com/2010/12/continuous-code-quality-measurement.html">Troy Hunts Blogpost</a> hat mir dabei auch sehr geholfen. Die NDepend Analyse basierte bei ihm allerdings auf den Artefakten eines anderen Builds - das würde die TeamCity Funktionen noch etwas mehr ausreizen - es funktioniert aber auch so prima :)</p>
