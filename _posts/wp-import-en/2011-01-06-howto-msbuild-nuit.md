---
layout: post
title: "HowTo: MsBuild &NUit"
date: 2011-01-06 00:01
author: CI Team
comments: true
categories: [Uncategorized]
tags: [MSBuild, NUnit]
language: en
---
{% include JB/setup %}

  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb284.png" width="144" height="82" />Because I'm using NUnit instead of MSTest in my actual project I want to run the <a href="http://www.nunit.org/">NUnit</a> Tests in my build as well. If you want to find out how to compare MSTest with MSBuild click here. It's not that more difficult with NUnit.</p>  
  <!--more-->  <p><b>Assumption</b></p>  <p><b></b></p>  <p>At the moment I work with NUnit Version <a href="http://nunit.org/downloads/snapshots/NUnit-2.5.9.10308.msi">2.5.9 (actually in development)</a>. In <a href="https://bugs.launchpad.net/nunitv2/+bug/602761">Version 2.5.8 exists a bug</a> which makes you unable to close the NUnit Agent. Probably the problem belongs to .NET 4.0 so please try to get the newest version.</p>  <p>After the installation you will find the Nunit file here:</p>  <p>C:\Program Files (x86)\NUnit 2.5.9</p>  <p><b>copy NUnit 2.5.9 /Runner /Files into the project directory</b></p>  <p><b></b></p>  <p>One possibility is to replace the NUnit Test Runner (in this case the nunit-console.exe) with a system path or another way is to copy all the files into the project directory.</p>  <p>Everything beneath "C:\Program Files (x86)\NUnit 2.5.9\bin\net-2.0" should be saved in the project directory or beneath.</p>  <p>I saved the file here: "PROJEKTNAME\Tools\NUnit\"</p>  <p><b>MsBuild Community Pack</b></p>  <p><b></b></p>  <p>Like in some other MSBuild blogposts I´ve used the <a href="http://msbuildtasks.tigris.org/">MSBuild Community Pack</a> because there is a nice "NUnit" task included.</p>  <p><b>Demo solution</b></p>  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image610.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image6_thumb.png" width="240" height="173" /></a></p>  <p>Exapt the NUnit Test Runner files you see everything thats important at the picture on the left. In Build\Lib you will find the MSBuild Community Pack and we also have a .bat file for easier achievement and of course our MsBuild file. The "MSBuildNUnit. Tests project is my "Demo" test project. Here is the link for the nunit.framework situated and one test.</p>  <p><b>The MSBuild File</b></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6f6b5010-29f1-4724-86d4-d48658f9263c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8"?&gt;
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

<p><b></b></p>

<p>Between Line 32 and 43 you can see the NUnit integration. In OutDir I pick up all assemblies including a "test" and call them with the NUnit Task. I also need to define the ToolPath for the runner because otherwise the script won't find the runner.</p>

<p>As result we have a TestResults.xml at the end of the build in the build directory.</p>

<p>All in all: A good and easy thing.</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/msbuildnunit/msbuildnunit.zip">[download democode]</a></p>
