---
layout: post
title: "HowTo: MSBuild & NUnit"
date: 2010-11-13 23:33
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, MSBuild, NUnit]
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1102.png"><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb284.png" width="144" height="82" /></a>Da ich aktuell in einem Projekt statt MSTest <a href="http://www.nunit.org/">NUnit</a> einsetze, möchte ich natürlich die <a href="http://www.nunit.org/">NUnit</a> Tests auch in meinem Build abspielen. Wie man MSTest und MSBuild miteinander bekannt macht, habe <a href="http://code-inside.de/blog/2010/10/05/howto-mstest-mit-msbuild-aufrufen/">ich hier gebloggt</a>. Mit NUnit ist es nicht wesentlich schwerer.</p> <!--more-->  <p><strong>Voraussetzungen</strong></p>  <p>Ich habe bei mir NUnit in der Version <a href="http://nunit.org/downloads/snapshots/NUnit-2.5.9.10308.msi">2.5.9 (momentan im Entwicklungszweig)</a> geladen. In <a href="https://bugs.launchpad.net/nunitv2/+bug/602761">Version 2.5.8 gab/gibt es einen Bug</a>, sodass der NUnit Agent sich nie beendet und der Prozess hängt. Dies hängt wohl mit .NET 4.0 zusammen, daher lieber eine neue Version laden.</p>  <p>Nach der Installation findet man die NUnit Dateien hier:</p>  <p>C:\Program Files (x86)\NUnit 2.5.9</p>  <p><strong>NUnit 2.5.9 / Runner / Files in das Projektverzeichnis kopieren</strong></p>  <p>Entweder man setzt für den NUnit Test Runner (in dem Fall die nunit-console.exe) einen Systempfad, oder man kopiert die Dateien alle mit in das Projektverzeichnis.</p>  <p>Alles unter&quot; "C:\Program Files (x86)\NUnit 2.5.9\bin\net-2.0” muss in das Projektverzeichnis bzw. unterhalb gespeichert werden.</p>  <p>Ich hab die Dateien unter "PROJEKTNAME\Tools\NUnit\” gespeichert.</p>  <p><strong>MSBuild Community Pack</strong></p>  <p>Wie bereits in manch anderen MSBuild Blogposts nutz ich auch hier das <a href="http://msbuildtasks.tigris.org/">MSBuild Community Pack,</a> weil es dort einen netten Tasks "NUnit” gibt.</p>  <p>Demo Solution</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1103.png"><img style="border-right-width: 0px; margin: 0px 10px 0px 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb285.png" width="244" height="176" /></a> </p>  <p>Bis auf die NUnit Test Runner Files sehr ihr das wesentliche im Build. Unter Build\Lib findet sich das MSBuild Community Pack und ansonsten gibt es eine .bat Datei zur leichteren Ausführung sowie unser MSBuild File. Das MSBuildNUnit.Tests Projekt ist mein "Demo” Test Projekt - hier ist das nunit.framework verlinkt und 1 Test enthalten.</p>  <p><strong>Das MSBuild File</strong></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e81d9156-8faf-45d5-9ed5-e88e18ded3dc" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Run"&gt;
&lt;Import Project="$(MSBuildStartupDirectory)\Lib\MSBuild.Community.Tasks.Targets"/&gt;
	&lt;PropertyGroup&gt; 
    &lt;!-- After Compile: Result will be saved in OutDir --&gt;
		&lt;OutDir&gt;$(MSBuildStartupDirectory)\OutDir\&lt;/OutDir&gt;
    
    &lt;!-- Configuration --&gt;
    &lt;Configuration&gt;Release&lt;/Configuration&gt;
    
    &lt;!-- Solutionproperties--&gt;
		&lt;SolutionProperties&gt;
      OutDir=$(OutDir);
      Platform=Any CPU;
      Configuration=$(Configuration)
    &lt;/SolutionProperties&gt;
	&lt;/PropertyGroup&gt;
	&lt;ItemGroup&gt;
		&lt;Solution Include="..\MSBuildNUnit.sln"&gt;
			&lt;Properties&gt;
				$(SolutionProperties)
			&lt;/Properties&gt;
		&lt;/Solution&gt;
	&lt;/ItemGroup&gt;
	&lt;Target Name="Run"&gt;
    &lt;Message Text="Run called." /&gt;
    
    &lt;CallTarget Targets="BuildSolution" /&gt;
    &lt;CallTarget Targets="RunTests" /&gt;
  &lt;/Target&gt;

  &lt;Target Name="BuildSolution"&gt;
    &lt;Message Text="BuildSolution called." /&gt;
    &lt;MSBuild Projects="@(Solution)"/&gt;
	&lt;/Target&gt;

  &lt;Target Name="RunTests"&gt;
    &lt;!-- Run Unit tests --&gt;
    &lt;CreateItem Include="$(OutDir)*.Tests.dll"&gt;
      &lt;Output TaskParameter="Include" ItemName="TestAssembly" /&gt;
    &lt;/CreateItem&gt;
    &lt;NUnit ToolPath="..\Tools\NUnit" DisableShadowCopy="true" Assemblies="@(TestAssembly)" /&gt;
  &lt;/Target&gt;

&lt;/Project&gt;
</pre></div>

<p>Zwischen Zeile 32 und 43 ist die NUnit Integration zu finden. Im OutDir hole ich mir alle Assemblies die ein "Tests” enthalten und kann diese über den NUnit Tasks aufrufen. Dort gebe ich zudem noch den ToolPath zun den Runnern an, ansonsten würde das Script den Runner nicht finden.</p>

<p>Zudem kommt am Ende des Builds noch eine TestResults.xml raus, welche im Build Verzeichnis liegt.</p>

<p>Alles in allem: Eine einfache Sache.</p>

<p><a href="http://{{BASE_PATH}}/assets/files/democode/msbuildnunit/msbuildnunit.zip"><strong>[Download Democode]</strong></a></p>
