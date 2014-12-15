---
layout: post
title: "HowTo: Zipping with MSBuild"
date: 2010-11-29 10:40
author: CI Team
comments: true
categories: [HowTo]
tags: [HowTo, MSBuild, MSTest, Zip]
language: en
---
{% include JB/setup %}
<img title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb251.png" width="113" height="150" />  
<p>In my last Blogpost I talked about howto integrate tests into the Buildscript. Today I´m going to write down an easy way how to zipp the build automatical. </p>
<p>You will find the magic trick in the <a href="http://msbuildtasks.tigris.org/">MSBuildCommunity Tasks project.</a> </p>  <!--more-->  
<p><b>Szenario </b></p>
<p>I just continued the solution from my last blogpost and by the way I downloaded the latest version of MSBuild Community Tasks. </p>
<p>As a side note: The MSI installer doesn´t work so I downloaded Zip with source. These files are from interest: </p> 

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb252.png" width="244" height="71" /></p>
<p>The following reference should be included into the MSBuild Script:</p>  

<pre name="code" class="c#">
&lt;Import Project="$(MSBuildStartupDirectory)\Lib\MSBuild.Community.Tasks.Targets"/&gt;
</pre>

<p><b>Zipping or the problem with the documentation </b></p>


<p>The MSBuildCommunity Task Project is really huge but in my eyes it´s kind of undocumented. With the help of this post I found out how to open the ZipTasks.</p>

<p>Here you can see my entire MSBuild Script. Take a look at the target "zip"</p>

<pre name="code" class="c#">
&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Build"&gt;
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
 </pre>

<p>The item "ZipFiles" includes all websites in my "OutDir". In the zip target I zipp all the files and deside from which folder they should be zipped. Last but not least: enter a name.</p>

<p>The call workes the same way like in my last posts with a .bat file:</p>

<pre name="code" class="c#">C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Buildsolution.targets /t:Build,RunTests,Zip</pre>

<p>Thats the easy but effective way to create a kind of "deployment-package". Even if there is a lot of more stuff you can make with the help of Msdeploy, never say no to a little zip. ;) </p>
