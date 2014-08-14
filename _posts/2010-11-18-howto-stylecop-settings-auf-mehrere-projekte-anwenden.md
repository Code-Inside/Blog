---
layout: post
title: "HowTo: StyleCop Settings auf mehrere Projekte anwenden"
date: 2010-11-18 00:56
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, StyleCop]
---
<p><a href="{{BASE_PATH}}/assets/wp-images/image1104.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb286.png" width="141" height="60" /></a>Ich hab bereits darüber gebloggt, wie man <a href="http://code-inside.de/blog/2010/11/12/howto-msbuild-stylecop/">StyleCop im MSBuild Script</a> verwenden kann. Allerdings möchte man eigentlich noch eine <a href="http://code.msdn.microsoft.com/sourceanalysis">StyleCop</a> Settings Datei haben und diese bei jedem Build im Visual Studio auch ausführen lassen. Dies geht mit relativ wenig aufwandt.</p> <!--more-->  <p></p>  <p><strong>Ausgangspunkt</strong></p>  <p>Als Ausgangspunkt nehmen wir die Solution <a href="http://code-inside.de/blog/2010/11/12/howto-msbuild-stylecop/">vom letzten Blogpost</a>. Das Stylecop File liegt bereits ausserhalb der Projekte.</p>  <p><em>Hinweis: Um ein "Default-Stylecop” File zu erzeugen einfach Stylecop installieren und Rechtsklick auf ein Projekt und "Run Stylecop” klicken. Dann wird im Projektverzeichnis ein Settings.Stylecop File erzeugt.</em></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1105.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb287.png" width="244" height="239" /></a> </p>  <p><strong>Die StyleCop Datei verlinken</strong></p>  <p>Über Rechtsklick auf das Projekt und StyleCop Settings kann man eine StyleCop Datei auch verlinken:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1106.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb288.png" width="493" height="177" /></a> </p>  <p>Dort im zweiten Reiter kann man unser Settings.Stylecop verlinken:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1107.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb289.png" width="385" height="348" /></a> </p>  <p>Wenn man das gemacht hat, wird ein File im Projektverzeichnis abgelegt, allerdings wird es nicht im Projekt referenziert, also über <strong>"Show All Files”</strong> gehen und das File ins Projekt mit reinholen:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1108.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb290.png" width="229" height="136" /></a> </p>  <p>Inhaltlich steht das in dem File:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5de7babc-df91-4585-b353-ae8fa0aad8be" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;StyleCopSettings Version="4.3"&gt;
  &lt;GlobalSettings&gt;
    &lt;StringProperty Name="LinkedSettingsFile"&gt;..\Settings.StyleCop&lt;/StringProperty&gt;
    &lt;StringProperty Name="MergeSettingsFiles"&gt;Linked&lt;/StringProperty&gt;
  &lt;/GlobalSettings&gt;
&lt;/StyleCopSettings&gt;</pre></div>

<p>Recht einleuchtend.</p>

<p><strong>Das ganze in allen Projekten wiederholen...</strong></p>

<p><strong>Und nun, damit beim Bauen auch der StyleCop anspringt: Projekt Dateien bearbeiten</strong></p>

<p>Damit bei jedem Bauvorgang auch der Code gecheckt wird, muss das Projektfile bearbeitet werden. Das Stylecop Target muss noch eingefügt werden.</p>

<p>Wenn man, wie in meiner Beispielanwendung, alle Stylecop Daten aus dem Installationsverzeichnis mit in die Solution holt, funktioniert es bei allen Projektmitgliedern, egal ob sie <strong>Stylecop installiert haben oder nicht.</strong></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p>Die StyleCop Targets Datei finden sie (wenn Sie bei der Installation die MSBuild Files nicht abgewählt habe) hier:</p>

<p>C:\Program Files (x86)\MSBuild\Microsoft\StyleCop\v4.4</p>

<p>Den gesamten Ordner hab ich mit in das Solution Verzeichnis kopiert.</p>

<p>Nun das csproj File anpassen:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ec36ac25-0c39-416a-9c47-69bcda0803f6" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;Project ToolsVersion="4.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003"&gt;
  ...
  &lt;Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets" /&gt;
  &lt;Import Project="..\Lib\Microsoft.StyleCop.targets"/&gt;
  ...
&lt;/Project&gt;</pre></div>

<p>Die zweite Import Anweisung ist für das aktivieren von Stylecop zuständig. Die Position ist auch nicht ganz unwichtig. Als ich die Importanweisung in die erste Zeile geschrieben hatte, war kein Ergebnis zusehen. </p>

<p>Nach dem Import des Target Files in allen Projekten ist man fertig.</p>

<p>Diese Vorgehensweise stammt aus dem StyleCop Teamblog:</p>

<ul>
  <li><a href="http://blogs.msdn.com/b/sourceanalysis/archive/2008/05/24/source-analysis-msbuild-integration.aspx">Setting Up StyleCop MSBuild Integration</a></li>

  <li><a href="http://blogs.msdn.com/b/sourceanalysis/archive/2008/05/25/sharing-source-analysis-settings-across-projects.aspx">Sharing StyleCop Settings Across Projects</a></li>
</ul>

<p>Wenn man die Stylecop Verletzungen als Error anstatt als Warning ausgeben möchte, dann kann man dies ebenfalls im csproj File einstellen. Dazu muss bei der jeweiligen Build Konfiguration dieser Parameter mit angegeben werden:</p>

<p>&lt;StyleCopTreatErrorsAsWarnings&gt;false&lt;/StyleCopTreatErrorsAsWarnings&gt;</p>

<p><strong>Fazit</strong></p>

<p>Die EInbindung von Stylecop kann durchaus Sinn machen. Je nach Anforderung und Projekt muss man aber schauen welche Regeln wirklich sinnvoll sind oder nicht. Die Regeln kann man durch ein zentrales StyleCop File einfacher verwalten und nach dem initialen aufsetzen der Projekte/Solution macht es sich auch bezahlt, weil man bei jedem Build daran erinnert wird - egal <a href="http://code-inside.de/blog/2010/11/12/howto-msbuild-stylecop/">ob von MSBuild</a> oder über Visual Studio.</p>

<p><a href="http://{{BASE_PATH}}/assets/files/democode/msbuildsharedcodequality/msbuildsharedcodequality.zip"><strong>[Download Democode]</strong></a></p>
