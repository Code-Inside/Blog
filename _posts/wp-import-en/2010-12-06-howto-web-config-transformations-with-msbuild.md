---
layout: post
title: "HowTo: Web.config Transformations with MSBuild"
date: 2010-12-06 10:49
author: CI Team
comments: true
categories: [HowTo]
tags: [MSBuild, Transformations, Web.config]
language: en
---
{% include JB/setup %}
<p><img title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb271.png" width="90" height="131"> With Asp.NET 4.0 a new feature named "<a href="http://blogs.msdn.com/b/webdevtools/archive/2009/05/04/web-deployment-web-config-transformation.aspx">Web.config Transformations</a>" was released. During my latest MSBuild Posts I showed you how to for example build a solution with pure MSBuild. Usually the web.config isn´t triggered and the WebApp works in debug Mod (worst case!). Because of this we need to trigger it manual in MSBuild.</p> <p>&nbsp;</p> <p>&nbsp;</p> <p><strong>[Update] With Visual Studio 2012 many problems are gone…</strong></p> <p>I wrote this blogpost using VS2010 and at that time there was one strange behaviour: All files used by the TransformXml Tasks were “locked”. So you couldn´t just override the original web.config with the transformed one. My workaround was to do some copy work but with VS2012 it should work “as expected”.</p> 
<!--more-->
 <p><b>How the output looks like till now</b></p> <p><b></b></p> <p>Take a look on <a href="{{BASE_PATH}}/2010/11/12/howto-build-msbuild-solutions/">this post</a> to find out how to create a _PublishedWebsites folder where the WebApp. could be founded. But here you will find the Transformation-files too:</p> <p>&nbsp;</p> <p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb272.png" width="244" height="226"></p> <p>The main problem: The transformation of the mainly web.config doesn´t happen - the application runs with debug:</p> <div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:81764bbf-f2bb-4930-8cb9-fd10052229a5" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">    &lt;compilation debug="true" targetFramework="4.0"&gt;</pre></div>
<p>and then the call will look like this:</p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b4389ddb-a895-431b-bdeb-9ea994d5b740" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">	&lt;TransformXml Source="Web.config"
				  Transform="Web.Release.config"
				  Destination="Web.transformed.config" /&gt;
</pre></div>
<p><b>BUT: that sucks! Am I right?</b></p>
<p><b></b></p>
<p>In the end I want the transformed file with the name "web.config". the problem: TransformXml is buggy. During the build the task <a href="http://connect.microsoft.com/VisualStudio/feedback/details/562200/transformxml-task-locks-config-file-identified-in-source-attribute">locked these 3 files</a>. Anyway: We don´t want to change our web.config file in our solution. Because of this we need to create a copy of our sources and change them.</p>
<p><b>Scheme</b>:</p>
<p><a href="{{BASE_PATH}}/assets/wp-images-en/image98.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb7.png" width="491" height="80"></a></p>
<p><b>CopySource:</b></p>
<p><b></b></p>
<p>We copy our whole sources to another place for example one folder back in our own directory. I named it "ClientTemp".</p>
<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb274.png" width="244" height="232"></p>
<p><b>BeforeCompile:</b></p>
<p><b></b></p>
<p>Here in the BeforeCompile targets, which are located in Clienttemp, I´m able to do some changes like for example changing the AssemblyVersion while opening. At this place I´m used to open the TransformXml Task as well:</p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2f718de8-0ac8-4770-9586-ce056ccb8d1f" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">	&lt;TransformXml Source="..\MsBuildSample.WebApp\Web.config"
				  Transform="..\MsBuildSample.WebApp\Web.$(Configuration).config"
				  Destination="$(BuildDirFullName)MsBuildSample.WebApp\Web.config" /&gt;
</pre></div>
<p>Source&amp;Transform are from the original branch and because of this we don´t need to take care of the lock.</p>
<p>Just the destination could be founded in our "cloned" folder. After this the "web.config" is transformed.</p>
<p><b>Build:</b></p>
<p>Here the mainly building process begins. The standard behavior is going to build the solution and pass the WebApp into the _PublishedWebsites OutDir.</p>
<p>---</p>
<p>Some other actions are able to follow. I´m going to delete the unused transformation files from the OutDir. (web.release.config / web.debug.config).</p>
<p><b>Result</b></p>
<p>It becomes a little bit trickier but the structure has her advantages as well. With this I´m able to work on my code during the building process (and before the compile) without changing the Source Code. It reminds me ( a little, little bit ;) of the functionality of TFS.</p>
<p><b>Complete buildscript: </b></p>
<div id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:22b1ef51-a504-4498-b0dd-13c90231cd62" class="wlWriterSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px"><pre class="c#" name="code">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Run"&gt;
&lt;Import Project="$(MSBuildStartupDirectory)\Lib\MSBuild.Community.Tasks.Targets"/&gt;
&lt;Import Project="$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v10.0\WebApplications\Microsoft.WebApplication.targets" /&gt;
   &lt;PropertyGroup&gt;
	&lt;!-- After Compile: Result will be saved in OutDir --&gt;
		&lt;OutDir&gt;$(MSBuildStartupDirectory)\..\..\ClientTemp\OutDir\&lt;/OutDir&gt;

	&lt;!-- Name of the BuildDir with the whole source code before the compile begins --&gt;
		&lt;BuildDirName&gt;BuildDir&lt;/BuildDirName&gt;

	&lt;!-- Relativ part of the BuildDir --&gt;
	&lt;BuildDirRelativePart&gt;..\..\ClientTemp\$(BuildDirName)&lt;/BuildDirRelativePart&gt;

	&lt;!-- Absolute part of the BuildDir--&gt;
	&lt;BuildDirFullName&gt;$(MSBuildStartupDirectory)\$(BuildDirRelativePart)\&lt;/BuildDirFullName&gt;

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
		&lt;Solution Include="$(BuildDirFullName)MsBuildSample.sln"&gt;
			&lt;Properties&gt;
				$(SolutionProperties)
			&lt;/Properties&gt;
		&lt;/Solution&gt;
	&lt;/ItemGroup&gt;
	&lt;Target Name="Run"&gt;
	&lt;Message Text="Run called." /&gt;

	&lt;CallTarget Targets="CopyToBuildDir" /&gt;
	&lt;CallTarget Targets="BeforeBuild" /&gt;
	&lt;CallTarget Targets="Build" /&gt;
	&lt;CallTarget Targets="Cleanup" /&gt;
	&lt;CallTarget Targets="Zip" /&gt;
  &lt;/Target&gt;
  &lt;Target Name="CopyToBuildDir"&gt;
	&lt;Message Text="CopyToBuildDir called." /&gt;
	&lt;Exec Command="robocopy .. $(BuildDirRelativePart) /s /z /purge /a-:r" ContinueOnError="true" /&gt;
  &lt;/Target&gt;
	&lt;Target Name="BeforeBuild"&gt;
	&lt;Message Text="BeforeBuild called." /&gt;

	&lt;Message Text="Transform Xml" /&gt;
	&lt;TransformXml Source="..\MsBuildSample.WebApp\Web.config"
									Transform="..\MsBuildSample.WebApp\Web.$(Configuration).config"
									Destination="$(BuildDirFullName)MsBuildSample.WebApp\Web.config" /&gt;
  &lt;/Target&gt;

  &lt;Target Name="Build"&gt;
	&lt;Message Text="Build called." /&gt;
	&lt;MSBuild Projects="@(Solution)"/&gt;
	&lt;/Target&gt;

	&lt;Target Name="Cleanup"&gt;
		&lt;Delete Files="$(OutDir)_PublishedWebsites\MsBuildSample.WebApp\Web.Release.config" /&gt;
		&lt;Delete Files="$(OutDir)_PublishedWebsites\MsBuildSample.WebApp\Web.Debug.config" /&gt;

	&lt;/Target&gt;
  &lt;ItemGroup&gt;
	&lt;ZipFiles Include="$(OutDir)_PublishedWebsites\**\*.*" /&gt;
  &lt;/ItemGroup&gt;
  &lt;Target Name="Zip"&gt;
	&lt;Zip Files="@(ZipFiles)"
			 WorkingDirectory="$(OutDir)_PublishedWebsites\"
			 ZipFileName="$(OutDir)Package.zip"/&gt;
  &lt;/Target&gt;
&lt;/Project&gt;
 </pre></div>
<p><b>Democode:</b></p>
<p><b></b></p>
<p>In my demosolution I work with some help variables of MSBuild - don´t be scared ;)</p>
<p>If you open the Samplecode:</p>
<p>D:\Samples\MsBuildSample ablegt findet Ihr das "BuildVerzeichnis" in D:\Samples\ClientTemp</p>
<p><a href="{{BASE_PATH}}/assets/files/democode/msbuildsamplexmltransform/msbuildsamplexmltransform.zip">[Download Democode]</a></p>
