---
layout: post
title: "HowTo: MSTest mit MSBuild aufrufen"
date: 2010-10-05 23:32
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, MSBuild, MSTest]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1066.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb248.png" width="134" height="90" /></a>Angelehnt an meinen letztes <a href="{{BASE_PATH}}/2010/09/30/howto-mit-msbuild-solutions-bauen/{{BASE_PATH}}/2010/09/30/howto-mit-msbuild-solutions-bauen/">"HowTo: Mit MSBuild Solutions bauen”</a> zeig ich hier in einem kurzen Beispiel wie man MSTests aufrufen kann. Für die NUnit User: Wenn am die Vorgehensweise verstanden hat, kann man auch jedes andere Tool über MSBuild aufrufen ;)</p> <!--more-->  <p></p>  <p><strong>Szenario</strong></p>  <p>Der Aufbau ist genau so, wie bei <a href="{{BASE_PATH}}/2010/09/30/howto-mit-msbuild-solutions-bauen/">dem letzten Blogpost</a>. Als kleine Erweiterung hab ich noch ein zusätzliches Test Projekt erstellt:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1067.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb249.png" width="197" height="94" /></a> </p>  <p>Meine BuildSolutions.target Datei, welches mein MSBuild Script enthält, hab ich noch um ein "RunTests” Target erweitert:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5e8bba96-df43-46c7-9538-3b03625a776f" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Build"&gt;
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
&lt;/Project&gt;</pre></div>

<p>Über das MSBuild Command "<a href="http://msdn.microsoft.com/en-us/library/x8zx72cd.aspx">Exec</a>” ruf ich die <a href="http://msdn.microsoft.com/en-us/library/ms182489(VS.80).aspx">MSTest.exe mit den entsprechenden Parametern</a> auf. In diesem Fall der "testcontainer”. Da ich zwei Testprojekte habe, welche beide mit in das OutDir als Assembly landen, habe ich auch zwei testcontainer definiert. Ich könnte hier auch noch x-andere Tests dran hängen. </p>

<p><strong>Der Aufruf des Scripts</strong></p>

<p>Um den Aufruf etwas zu vereinfachen, habe ich dies in einer .bat Datei wieder gespeichert:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a5ca1786-78be-47d6-bb94-ccd07d357747" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Buildsolution.targets /t:Build,RunTests</pre></div>

<p>Über den "t” Parameter kann ich bestimmen, welche Targets aufgerufen werden. Erst ruf ich "Build”, dann "RunTests” auf. In dem Consolen Output seh ich auch die wesentlichen Sachen:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1068.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb250.png" width="180" height="225" /></a> </p>

<p><strong>Geht auch mit X-anderen Tools</strong></p>

<p>Wenn man die Grundzüge von MSBuild verstanden hat, dann kann man alles, was irgendwie über die CMD ansprechbar ist auch aufrufen. Bei der MSTest Sache muss ich mir nur noch überlegen, wie ich die Tests besser in das Buildfile hinterlegen kann. Bei vielen Tests verliert man bei so einer Zeile schon den Überblick:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:012e157b-c528-437e-aff7-ec72c6a617d0" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Exec Command='"C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\mstest.exe" /testcontainer:"$(MSBuildStartupDirectory)\OutDir\MsBuildSample.WebApp.Tests.dll" /testcontainer:"$(MSBuildStartupDirectory)\OutDir\AnotherTestProject.dll"' /&gt;</pre></div>

<p>Vielleicht hat ja jemand hier eine gute Idee ;)</p>

<p>Der Blogpost beschreibt keine Raketenwissenschaft, aber ich musste Google anwerfen, daher hab ich das mal hier kurz zusammengeschrieben :)</p>

<p><strong><a href="http://{{BASE_PATH}}/assets/files/democode/msbuildsamplemstest/msbuildsamplemstest.zip">[ Download Democode ]</a></strong></p>
