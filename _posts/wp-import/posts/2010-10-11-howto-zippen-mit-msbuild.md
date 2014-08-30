---
layout: post
title: "HowTo: Zippen mit MSBuild"
date: 2010-10-11 22:56
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, MSBuild, Zippen]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1069.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb251.png" width="113" height="150" /></a> </p>  <p>Nachdem im <a href="{{BASE_PATH}}/2010/10/05/howto-mstest-mit-msbuild-aufrufen/">letzten HowTo</a> behandelt wurde, wie man Tests mit in das Buildscript integriert, kommen wir nun zu einer einfachen Methode, wie man das Build automatisch zippen kann.</p>  <p>Die Magie beruht auf dem <a href="http://msbuildtasks.tigris.org/">MSBuildCommunity Tasks</a> Projekt.</p> <!--more-->  <p><strong>Ausgangsszenario</strong></p>  <p>Die Solution vom letzten Blogpost habe ich einfach weitergestrickt und zudem habe ich mir die neuste Version der <a href="http://msbuildtasks.tigris.org/">MSBuildCommunity Tasks runtergeladen</a>. Kleiner Tipp am Rande: Der MSI Installer wollte nicht, daher habe Zip mit Source runtergeladen. Dort gibt es folgende Datein, die für uns interessant sind:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1070.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb252.png" width="244" height="71" /></a> </p>  <p>Im MSBuild Script muss folgende Referenz rein:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5efa5aaa-7063-43b1-bba1-3a0022bd7f96" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Import Project="$(MSBuildStartupDirectory)\Lib\MSBuild.Community.Tasks.Targets"/&gt;</pre></div>

<p>Damit holen wir uns quasi die verschiedenen Tasks in unser Buildfile mit rein und können sie verwenden.</p>

<p><strong>Das Zippen oder das Problem mit der Doku</strong></p>

<p>Das MSBuildCommunity Task Projekt ist recht groß, aber leider irgendwie scheint es für mich recht undokumentiert. In <a href="http://blog.benhall.me.uk/2008/09/using-msbuild-to-create-deployment-zip.html">diesem Post</a> hab ich den Aufruf des ZipTasks gefunden.</p>

<p><strong>Hier mein ganzes MSBuild Script, wichtig ist das Target "Zip”</strong></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5da490d4-89b6-4cb1-8002-50cbbfb9226c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Build"&gt;
&lt;Import Project="$(MSBuildStartupDirectory)\Lib\MSBuild.Community.Tasks.Targets"/&gt;
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
	&lt;Target Name="RunTests"&gt;
		&lt;Exec Command='"C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\mstest.exe" /testcontainer:"$(MSBuildStartupDirectory)\OutDir\MsBuildSample.WebApp.Tests.dll" /testcontainer:"$(MSBuildStartupDirectory)\OutDir\AnotherTestProject.dll"' /&gt;
	&lt;/Target&gt;
	&lt;ItemGroup&gt;
	  &lt;!-- All files from build --&gt;
	  &lt;ZipFiles Include="$(OutDir)_PublishedWebsites\**\*.*" /&gt;
  &lt;/ItemGroup&gt;
	&lt;Target Name="Zip"&gt;
		&lt;Zip Files="@(ZipFiles)"
			 WorkingDirectory="$(OutDir)_PublishedWebsites\" 
			 ZipFileName="$(OutDir)Package.zip"/&gt; 
	&lt;/Target&gt;
&lt;/Project&gt;
 </pre></div>

<p>Das Item "ZipFiles” umfasst alle Webseiten in meinem "OutDir”. In dem Zip Target zippe ich diese Files und gebe noch an, von welchem Ordner aus gezippt werden soll. Als letztes geb ich noch ein Namen und fertig.</p>

<p>Der Aufruf erfolgt wie in meinen letzten Posts schon über eine .bat Datei:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:156c499b-cbf3-4fad-857e-6a565c5eb524" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Buildsolution.targets /t:Build,RunTests,Zip</pre></div>

<p>Damit hat man recht einfach und effektiv eine Art "Deployment-Package”, auch wenn man mit MSDeploy und anderen Dingen noch viel mehr Voodoo treiben kann. Ein Zip machen, kann nie schaden ;)</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/msbuildsamplezip/msbuildsample.zip"><strong>[ Download Democode ]</strong></a></p>
