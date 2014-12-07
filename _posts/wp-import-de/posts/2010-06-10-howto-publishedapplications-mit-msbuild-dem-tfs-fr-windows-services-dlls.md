---
layout: post
title: "HowTo: “PublishedApplications” mit MSBuild & dem TFS für Windows Services / DLLs"
date: 2010-06-10 13:01
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Build, MSBuild, TFS]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image978.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb162.png" width="162" height="92" /></a> </p>  <p>Wir benutzen bei uns für den Build Prozess MSBuild und nutzen den Team Foundation Server. Wer eine ASP.NET Applikation baut bekommt diese in einem "PublishedWebsites” Ordner serviert. Jegliche andere Sachen werden aber einfach ins Bin/Release Verzeichnis kopiert. Da das nicht gerade besonders hilfreich ist, kann man das natürlich auch ändern - allerdings mit etwas basteln.</p>  <p><strong>Was muss man tun um die Ordnerstruktur beizubehalten?</strong></p>  <p>Eigentlich möchte man ja pro Applikation einen eigenen Output Folder haben. Leider baut der TFS alles und kopiert das Ergebnis einfach ins Release Verzeichnis.   <br />In unserem Beispiel haben wir eine TFSBuild.proj Datei, welche momentan 3 Solutions baut.    <br />Die Solutionnames sind bei uns natürlich etwas anders ;)</p>  <ul>   <li>"Websolution1” enthält im Großen und Ganzen eine ASP.NET MVC Webseite.</li>    <li>"Websolution2” enthält einen Webservice </li>    <li>"WindowsSolution1” enthält einen Windows Dienst und einige andere Klassenbibliotheken.</li> </ul>  <p>Der TFS legt automatisch für ASP.NET Projekte einen "PublishedWebsites” Ordner an. </p>  <p>Hier mal direkt einen Ausschnitt aus dem TFSBuild.proj File:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4a126f43-c582-4539-a9c5-fc6b3ddae947" class="wlWriterEditableSmartContent"><pre name="code" class="c#">    &lt;SolutionToBuild Include="$(BuildProjectFolderPath)/../../Main/Source/Websolution1.sln"&gt;
        &lt;Targets&gt;&lt;/Targets&gt;
        &lt;Properties&gt;OutDir=$(OutDir)&lt;/Properties&gt;
    &lt;/SolutionToBuild&gt;
    &lt;SolutionToBuild Include="$(BuildProjectFolderPath)/../../Main/Source/Websolution2.sln"&gt;
        &lt;Targets&gt;&lt;/Targets&gt;
        &lt;Properties&gt;OutDir=$(OutDir)&lt;/Properties&gt;
    &lt;/SolutionToBuild&gt;
    &lt;SolutionToBuild Include="$(BuildProjectFolderPath)/../../Main/Source/WindowsSolution1.sln"&gt;
      &lt;Targets&gt;&lt;/Targets&gt;
      &lt;Properties&gt;&lt;/Properties&gt;
    &lt;/SolutionToBuild&gt;
  &lt;/ItemGroup&gt;
  
  &lt;PropertyGroup&gt;
    &lt;CustomizableOutDir&gt;true&lt;/CustomizableOutDir&gt;
  &lt;/PropertyGroup&gt;</pre></div>

<p>Wichtig ist die untere PropertyGroup und das der Wert "<a href="http://msdn.microsoft.com/en-us/library/aa337598.aspx">CustomizableOutDir</a>” auf "true” gesetzt ist. Damit wird im Grunde der Default-Mechanismus des TFS ausgeschalten. Daher muss man in den Properties das OutDir mitgeben. Da es bei den Webseiten keine Problem gab setzt ich es wieder zum Standard.</p>

<p>Nun geht man in die Projektdatei von dem Windowsservice (welche in der WindowsSolution1) ist. Dort hab ich es wie folgt angepasst:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d1682145-79aa-432d-88cb-52d8ae28d30b" class="wlWriterEditableSmartContent"><pre name="code" class="c#">  &lt;PropertyGroup&gt;
    &lt;PublishedApplicationOutputDir Condition=" '$(TeamBuildOutDir)'!='' "&gt;$(TeamBuildOutDir)_PublishedApplications\$(MSBuildProjectName)&lt;/PublishedApplicationOutputDir&gt;
    &lt;PublishedApplicationOutputDir Condition=" '$(TeamBuildOutDir)'=='' "&gt;$(MSBuildProjectDirectory)&lt;/PublishedApplicationOutputDir&gt;
  &lt;/PropertyGroup&gt;

  &lt;PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' "&gt;
    &lt;DebugType&gt;pdbonly&lt;/DebugType&gt;
    &lt;Optimize&gt;true&lt;/Optimize&gt;
    &lt;OutputPath&gt;$(PublishedApplicationOutputDir)&lt;/OutputPath&gt;
    &lt;DefineConstants&gt;TRACE&lt;/DefineConstants&gt;
    &lt;ErrorReport&gt;prompt&lt;/ErrorReport&gt;
    &lt;WarningLevel&gt;4&lt;/WarningLevel&gt;
  &lt;/PropertyGroup&gt;</pre></div>

<p>Wenn es vom TeamBuild gebaut wird gibt der TFS die Property TeamBuildOutDir mit rein und setzt entsprechend meinen gewünschten "PublishedApplication” Pfad. </p>

<p>Das ganze wird am Ende als OutputPath bestimmt und schon haben wir pro Windowsdienst / Klassenbibliothek etc. einen eigenen Output-Folder.</p>

<p>Meine Lösung stammt ursprünglich von <a href="http://mikehadlow.blogspot.com/2009/10/tfs-build-publishedwebsites-for-exe-and.html">diesem Blogpost</a>. Hintergrund für das CustomizableOutDir Verhalten kann man in diesem <a href="http://mikehadlow.blogspot.com/2009/10/tfs-build-publishedwebsites-for-exe-and.html">Blogpost nachlesen</a>. 

  <br />Wenn man auf das Datum der Blogposts schaut, sieht man, dass das Problem schon etwas älter ist, aber ich bin jetzt erst drauf gestoßen ;)</p>

<p><strong>MSBuild</strong></p>

<p>Wer einen Einstieg in MSBuild sucht, der findet eine klasse Serie auf Thorsten Hans seinem Blog: <a href="http://dotnet-forum.de/blogs/thorstenhans/pages/das-msbuild-universum.aspx">Das MSBuild Universum</a></p>

<p><strong>PS:</strong> Natürlich geb ich keine Garantie ab, dass dies die ideale Lösung ist. Aber es baut erstmal ;)</p>
