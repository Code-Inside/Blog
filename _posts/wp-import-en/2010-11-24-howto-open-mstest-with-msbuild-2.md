---
layout: post
title: "HowTo: Open MSTest with MSBuild"
date: 2010-11-24 10:42
author: CI Team
comments: true
categories: [HowTo]
tags: [HowTo ; MSBuild ; MSTest]
language: en
---
{% include JB/setup %}


<p><img title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb248.png" width="134" height="90" />According to the blogpost about "žHowTo: build solutions with MSBuild" I´m going to show you a little example about how to call MSTests. </p>  
  
  

<p><b>Scenario</b></p>  

<p>The structure is nearly the same like in <a href="{{BASE_PATH}}/2010/11/12/howto-build-msbuild-solutions/">this blogpost</a>. As a little add-on I created a new test project:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image97.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb6.png" width="201" height="98" /></a></p>
<p>I´ve added one more "RunTests" target to my BuildSolutions.target file where the MSBuild Script is included:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:517b6026-376b-4cbb-b5f3-5cd2af91ab16" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Build"&gt;
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

<p>With the MSBuild command "<a href="http://msdn.microsoft.com/en-us/library/x8zx72cd.aspx">Exec</a>" I open the MSTest.exe with the <a href="http://msdn.microsoft.com/en-us/library/ms182489(VS.80).aspx">adequate parameter</a>. In this case the "testcontainer". Because we have to test-projects and both are loading into the OutDir as Assembly, we also need two testcontainer. Of course it´s possible to have numerous other tests.</p>

<p><b>Call the Script</b></p>




<p>To make the call a little easier I saved it in a .bat file:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e2001e7c-3b8c-4f82-a3f7-076272233afc" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Buildsolution.targets /t:Build,RunTests</pre></div>

<p>With the "t" parameter I´m able to decide which target should be opened. First I call "Build" and then "RunTests". I see the main things in the output:</p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb250.png" width="180" height="225" /></p>

<p><b>Works with several other tools too</b></p>




<p>Once you understand the basics of MSBuild you are able to call everything working with CMD. I just need to think about a better way how to integrate the Tests into the Buildfile. With many tests you are going to lose the overview with a line like this:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:089a6206-1300-45a3-944b-9d407f72fccb" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Exec Command='"C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\mstest.exe" /testcontainer:"$(MSBuildStartupDirectory)\OutDir\MsBuildSample.WebApp.Tests.dll" /testcontainer:"$(MSBuildStartupDirectory)\OutDir\AnotherTestProject.dll"' /&gt;</pre></div>

<p>If someone has a good idea, please let me now! <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile3.png" /></p>

<p>I know I´m not writing about something new but I had to google it so I thought you might be interested in it too. </p>

<p>[ <a href="{{BASE_PATH}}/assets/files/democode/msbuildsamplemstest/msbuildsamplemstest.zip">Download Democode</a> ]</p>
