---
layout: post
title: "HowTo: Mit MSBuild Solutions bauen"
date: 2010-09-30 23:44
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [MSBuild HowTo]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1059.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb241.png" width="212" height="108" /></a> </p>  <p>Wer Experte in MSBuild ist, der wird über mein Blogpost jetzt nur lächeln können, allerdings für jemanden der bis vor kurzem MSBuild nur von weiten gesehen hat, empfand ich meine Erkenntnisse doch als erleuchtend ;)</p>  <p><strong>Einstieg in MSBuild</strong></p>  <p>Ich werde an dieser Stelle kein großen Einstieg in MSBuild geben. MSBuild ist die Grundlage für den Erstellprozess von .NET Projekten. Thorsten Hans hat eine sehr geniales Tutorial rund um MSBuild gemacht - lesen lohnt sich: <a href="http://dotnet-forum.de/blogs/thorstenhans/pages/das-msbuild-universum.aspx">Das MSBuild Universum</a>.</p>  <p><strong>Meine Problemstellung</strong></p>  <p>Ich hatte bei mir eine konkrete Problemstelle: In der Firma nutzen wir den TFS 2010 samt den Teambuilds. Hier ein <a href="{{BASE_PATH}}/2010/03/19/howtocode-builddeploymentwtf-oder-auch-automatisierung-mit-msbuild/">etwas älterer Blogpost</a>, wie wir das <em>damals</em> machten ;)    <br />Nun wollte ich auch auf den Client ein Buildscript haben, mit dem ich alle Solutions (wir haben mehrere - großes Projekt) lokal baut und das Ergebnis in ein Ordner verschiebt. Der TFS macht es ähnlich und verschiebt nach dem erfolgreichen Build alles in die Droplocation. So wollte ich den Teil nachbauen.</p>  <p><strong>Demoprojekte</strong></p>  <p>Meine Demo.sln ist natürlich recht schmall und beinhaltet nur ein ASP.NET MVC Projekt samt Unit Tests - völliger Standard und unverändert:   <br /><a href="{{BASE_PATH}}/assets/wp-images/image1060.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb242.png" width="233" height="50" /></a> </p>  <p><strong>MSBuild</strong></p>  <p>Jetzt kommen wir zu dem sehr simplen, aber effektiven MSBuild:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:76a7479b-32eb-4da3-9e3c-15394eef0a43" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Build"&gt;
   &lt;PropertyGroup&gt;
		&lt;OutDir&gt;$(MSBuildStartupDirectory)\OutDir\&lt;/OutDir&gt;
		&lt;SolutionProperties&gt;
					OutDir=$(OutDir);
					Platform=Any CPU;
					Configuration=Release
		&lt;/SolutionProperties&gt;
   &lt;/PropertyGroup&gt;
	&lt;ItemGroup&gt;
		&lt;Solution Include="..\MsBuildSample.sln"&gt;
			&lt;Properties&gt;
							$(SolutionProperties)
			&lt;/Properties&gt;
		&lt;/Solution&gt;
	&lt;/ItemGroup&gt;
	&lt;Target Name="Build"&gt;
		&lt;MSBuild Projects="@(Solution)"/&gt;
	&lt;/Target&gt;
&lt;/Project&gt;
 </pre></div>

<p>Ganz oben gibt es eine PropertyGroup in dem ich beschreibe, wohin das Ergebnis kopiert wird. Anstatt in den einzelnen Projekten das Ergebnis des Buildvorgangs mir die Sachen in den jeweiligen bin\release Ordnern zu suchen, möchte ich es in mein "<strong>OutDir</strong>” haben. Ich nutze die <a href="http://msdn.microsoft.com/en-us/library/ms164309.aspx">MSBuild Property MSBuildStartupDirectory</a> um mir den Ordner des Buildfiles zu ermitteln. </p>

<p>Die "SolutionProperties” beschreiben nur, wie die Solution gebaut werden soll. Also welche Konfiguration (Release/Debug) und überschreibe zudem das OutDir mit meiner eigenen Property.</p>

<p>Danach folgt eine <strong>Itemgroup</strong>. Ich könnte hier auch mehrere <strong>Solutions</strong> mit angeben. </p>

<p>Am Ende folgt mein Target "Build”, was auch mein "Default Target” ist (siehe 1. Zeile) - damit weiß ich letztendlich MSBuild an alle Projekte in den angegeben Solutions zu bauen. </p>

<p>Das ganze habe ich unter dem Namen "BuildSolution.build” genannt. Ich nehm an, wenn man es ".target” nennt, dann würde auch die Visual Studio IntelliSense funktionieren, aber man kann es nennen wie man möchte - jedenfalls hab ich keine Einschränkung gemerkt.</p>

<p><strong>Aufruf des Buildscripts</strong></p>

<p></p>

<p>Der Aufruf wäre recht simple z.B. von der Visual Studio 2010 Command Prompt: "msbuild BuildSolution.build” </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1061.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb243.png" width="520" height="34" /></a> </p>

<p>Nach dem Bauen, wird alles in mein OutDir geschoben.</p>

<p><strong>Alles in ein Verzeichnis?</strong></p>

<p>Das stimmt so nicht ganz. Wenn ich Class Libraries baue, dann werden die .dlls in das Verzeichnis verschoben. Was ich aber natürlich nicht will ist, dass wenn ich verschiedene Windows Dienste oder andere Anwendung baue, dass dann alles vermatscht ist. Das gute: Für Webseiten ist das gar kein Problem:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1062.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb244.png" width="244" height="131" /></a> </p>

<p>Unter _PublishedWebSites findet sich pro Website alle Daten wie man sie benötigt:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1063.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb245.png" width="244" height="127" /></a> </p>

<p>Für andere Applikationen geht dies mit einem Trick auch. Darüber habe ich hier gebloggt: <a href="{{BASE_PATH}}/2010/06/10/howto-publishedapplications-mit-msbuild-dem-tfs-fr-windows-services-dlls/">HowTo: "PublishedApplications” mit MSBuild &amp; dem TFS für Windows Services / DLLs</a></p>

<p><strong>Feinschliff: Eine Batch Datei</strong></p>

<p>Als kleinen Feinschliff hab ich mir eine Batch Datei gemacht um nicht immer in den Visual Studio Command Prompt zu gehen: </p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a9e20806-5d8c-4181-b594-df1e7677a48e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Buildsolution.build</pre></div>

<p>Das ganze würde entsprechend auch mit einer anderen .NET Versionsnummer gehen.</p>

<p><strong>Was haben wir nun?</strong></p>

<p>Wir haben einen Script, mit dem wir die 1 + n Solutions bauen können und das Ergebnis in einen Ordner speichern. Durch das batch File könnten man natürlich noch andere Sachen aufrufen, z.B. MSDeploy etc. Auch wenn ich mir da noch nicht ganz sicher bin, wie MSDeploy mit MSBuild zusammenspielt. Ein Ansatz wäre aber <a href="http://raquila.com/software/using-ms-deploy-instead-of-copy-command-in-msbuild/">das hier</a>.</p>

<p><strong>Wofür mach ich das?</strong></p>

<p>Der Grundgedanke ist folgender: Ich wollte den Prozess, den der TFS mit den TeamBuild auf dem Buildserver macht auch lokal nachstellen. Wenn die kompilierten Dateien in dem Ordner (DropLocation/OutDir) sind, beginn ich meine Deployment-Pakete zusammenzubauen. Wenn ich die Gelegenheit finde und mein Plan richtig in die Tat umgesetzt habe, kann ich darüber ja mal bloggen ;)</p>

<p><strong>Feinschliff die zweite: Die Batch Datei in Visual Studio aufrufen</strong></p>

<p>Ich hab das Buildscript samt der Batch Datei mit in die Solution aufgenommen. Ganz ideal wäre es jetzt noch über ein "Rechtsklick” die Batch auch im Solution Explorer auszuführen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1064.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb246.png" width="244" height="133" /></a> </p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1065.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb247.png" width="244" height="98" /></a> </p>

<p>Hier ist ein <a href="http://www.rickglos.com/post/How-to-run-windows-batch-files-from-Visual-Studio-2010-Solution-Explorer.aspx">Trick beschrieben mit dem das auch geht</a>:</p>

<p>Ich empfehle an dieser Stelle noch mal Thorsten Hans sein <a href="http://dotnet-forum.de/blogs/thorstenhans/pages/das-msbuild-universum.aspx">MSBuild Tutorial</a> :)</p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p><strong><a href="{{BASE_PATH}}/assets/files/democode/msbuildsample/msbuildsample.zip">[ Download Democode ]</a></strong></p>
