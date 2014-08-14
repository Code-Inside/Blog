---
layout: post
title: "Zusätzliche Dateien in WebDeploy Packages aufnehmen"
date: 2013-08-31 16:27
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, WebDeploy]
---
<p><a href="http://code-inside.de/blog/?s=webdeploy">WebDeploy</a> ist für mich das erste Mittel der Wahl wenn es darum geht Web-Applikationen zu verpacken und auszurollen. Ein einmal gebautes Package lässt sich leicht auf verschiedene Webserver pushen und auch Richtung Azure ist dies kein Problem. </p> <h3>Kleines Problem: Wie kann man zusätzliche Dateien in das WebDeploy Package mit aufnehmen?</h3> <p>Im Standard-Fall nimmt der WebDeploy Prozess alle Dateien die im Projekt verwendet werden – andere Dateien, <strong>welche vielleicht sogar im Ordner selbst liegen, lässt er also aus</strong>. Dies ist natürlich problematisch wenn man irgendwelche “zusätzlichen Dateien”, welche eigentlich nur indirekt mit dem Projekt zutun haben, mit in das Package aufnehmen möchte. Ein Szenario dafür wären Dateien welche man zum Download bereitstellen möchte, aber sonst nichts mit der eigentlichen Anwendung zutun haben.</p> <h3>Lösung: MSBuild Einstiegspunkte für WebDeploy</h3> <p>Dies muss in die .csproj Datei hinzugefügt werden:</p><pre class="brush: csharp; auto-links: true; collapse: false; first-line: 1; gutter: true; html-script: false; light: false; ruler: false; smart-tabs: true; tab-size: 4; toolbar: true;">   &lt;Target Name="CustomCollectFiles"&gt;
    &lt;ItemGroup&gt;
      &lt;_IncludingFiles Include="..\*.txt" /&gt;
      &lt;FilesForPackagingFromProject Include="%(_IncludingFiles.Identity)"&gt;
        &lt;DestinationRelativePath&gt;SampleFolder\%(RecursiveDir)%(Filename)%(Extension)&lt;/DestinationRelativePath&gt;
      &lt;/FilesForPackagingFromProject&gt;
      &lt;!-- You can use this multiple times... 
      &lt;_AdditionalFiles Include="PATH\**\*" /&gt;
      &lt;FilesForPackagingFromProject Include="%(_AdditionalFiles.Identity)"&gt;
        &lt;DestinationRelativePath&gt;WHEREEVER_YOU_WANT\%(RecursiveDir)%(Filename)%(Extension)&lt;/DestinationRelativePath&gt;
      &lt;/FilesForPackagingFromProject&gt;
      --&gt;
    &lt;/ItemGroup&gt;
  &lt;/Target&gt;
  &lt;PropertyGroup&gt;
    &lt;CopyAllFilesToSingleFolderForPackageDependsOn&gt;
      CustomCollectFiles;
      $(CopyAllFilesToSingleFolderForPackageDependsOn);
    &lt;/CopyAllFilesToSingleFolderForPackageDependsOn&gt;

    &lt;CopyAllFilesToSingleFolderForMsdeployDependsOn&gt;
      CustomCollectFiles;
      $(CopyAllFilesToSingleFolderForPackageDependsOn);
    &lt;/CopyAllFilesToSingleFolderForMsdeployDependsOn&gt;
  &lt;/PropertyGroup&gt;</pre>
<p>Die untere PropertyGroup muss nicht angepasst werden. Im Target “CustomCollectFiles” kann in der ItemGroup ein oder mehrere Dateien angegeben werden. Das DestinationRelativePath Element bestimmt wohin die vorher gesammelten Dateien kopiert werden sollen. Der Syntax ist etwas “kryptisch”, wenn man aber mal dahinter gekommen ist, dann passt es.</p>
<p>Ergebnis:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1913.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; margin: 0px 5px 0px 0px; border-left: 0px; display: inline" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb1054.png" width="240" height="163"></a> </p>
<p>Das Projekt enthält nur eine “Index.html” Datei – mehr nicht. In meinem Beispiel wollte ich die drei oberen Text-Dateien, welche parallel zur .sln-Datei liegen, in das Package mit aufnehmen. </p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>Durch die .csproj Anpassungen kommt dies in das Package:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image1914.png"><img title="image" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb1055.png" width="206" height="132"></a> </p>
<p><strong>Das Projekt gibts natürlich auch auf <a href="https://github.com/Code-Inside/Samples/tree/master/2013/WebDeployWithAdditions">GitHub</a>.</strong></p>
<p><strong>Weitere Informationen:</strong></p>
<p><a href="http://www.asp.net/mvc/tutorials/deployment/visual-studio-web-deployment/deploying-extra-files">ASP.NET: ASP.NET Web Deployment using Visual Studio: Deploying Extra Files</a><br><a href="http://sedodream.com/2010/05/01/WebDeploymentToolMSDeployBuildPackageIncludingExtraFilesOrExcludingSpecificFiles.aspx">Web Deployment Tool (MSDeploy) : Build Package including extra files or excluding specific files</a></p>
