---
layout: post
title: "HowTo: build MSBuild Solutions"
date: 2010-11-12 18:20
author: CI Team
comments: true
categories: [HowTo]
tags: []
language: en
---
{% include JB/setup %}
<p><img title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb241.png" width="212" height="108" />Those of you who are already experts in the usage of MSBuild will be just smiling about my Blogspot but for someone who hasn't worked with MSBuild till today (like me) I thought this howto would be very helpful. <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile.png" /></p>  <!--more-->  <p><b>Introduction to MSBuild</b></p>  <p><b></b></p>  <p>At this point I won't give you a great introduction into MSBuild. MSBuild is the basic for the development process of .NET Projects. There is another great Tutorial from <a href="http://dotnet-forum.de/blogs/thorstenhans/pages/das-msbuild-universum.aspx">Thorsten Hans</a>. Please take a look on it if you would like to have a deeper few into the whole MSBuild problem.</p>  <p><b>Whats my problem </b></p>  <p>I had a specific problem for me. At our enterprise we use the TFS 2010 including the Teambuilds. Now I want to have a Buildscript on the client who is able to build every solutions local (we have a lot of - big project) and pass it to a folder. The TFS works quite similar and pass everything after the successful build into the droplocation. Thats what I want to build after.</p>  <p><b>Demoproject</b></p>  <p>I know my demo is very thin and includes just an ASP.NET MVC project with Unit Tests - unchanged standard:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image91.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb.png" width="237" height="54" /></a></p>  <p><b>MSBuild</b></p>  <p><b></b></p>  <p>Now we are going to talk about the very simple but very effective MSBuild:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:2ee4d827-d921-4efe-8586-0a71efa23a8c" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Build"&gt;
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

<p>At the top you will find a PropertyGroup with the description about where to copy the solution into. Instead of searching the solution in the bin\release folder I want to find it in my "<strong>OutDir</strong>". I use the <a href="http://msdn.microsoft.com/en-us/library/ms164309.aspx">MSBuild Property MSBuild StartupDirectory</a> to find the right Buildfiles.</p>

<p>In the "SolutionProperties" you will find a description the Solutions will be build after. Now I'm going to write over the OutDir with my own Property.</p>

<p>Now we need a <strong>Itemgroup</strong>. Of course it it possible to have more <strong>solutions </strong>into here.</p>

<p>At the end my target "build" follows which is my default target as well (look into line 1) With this I give MSBuild the order to build every selected project into the chosen solution.</p>

<p>I named the whole thing "BuildSolution.build". I think if you name it ".target"</p>

<p>than the Visual Studio IntelliSense will work as well but anyway you can name it what ever you want. I didn't recognize any restrictions.</p>

<p><b>Open the Buildscript</b></p>

<p>This is very easy. For example you could use the command prompt from Visual Studio 2010: "msbuild BuildSolution.build"</p>

<p>After building everything will be pasted into my OutDir.</p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb243.png" width="520" height="34" /></p>

<p><b>Everything in one directory?</b></p>

<p>Thats not how it works. If I build class libraries then the .dlls will be pasted to the directory. But of course if I build several Windows Applications I don't want them to end as a mess. Good news: this isn't a problem on web sites:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image92.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb1.png" width="244" height="133" /></a></p>

<p>In the folder _PublishedWebSites you will find every files you need:</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image93.png"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb2.png" width="244" height="129" /></a></p>

<p><b>fine-tuning: a batch file</b></p>

<p><b></b></p>

<p>As a little fine-tuning I created a batch file for not being forced to use the Visual Studio Command Prompt at every time:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:d98e8867-f59c-4233-9b77-3b36db29d844" class="wlWriterEditableSmartContent"><pre name="code" class="c#">C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Buildsolution.build</pre></div>

<p>The whole thing will work with another .Net version number as well.</p>

<p><b></b></p>

<p><b>What do we have now?</b></p>

<p><b></b></p>

<p>We have a script which will help us to build 1+n solutions and save them in a folder. With the help of the batch file it it also possible to open other stuff like for example MSDeploy. But in fact I'm not sure how MSBuild and MSDeploy will work together. A first sign would be <a href="http://raquila.com/software/using-ms-deploy-instead-of-copy-command-in-msbuild/">this.</a></p>

<p><b>For what will this help?</b></p>

<p><b></b></p>

<p>My main thought was to rebuild the process local which the TFS creates on the</p>

<p>Buildserver with the help of TeamBuild. As soon as the compiled files are at the folder (DropLocation/OutDir) I start to build my deployment packages. As soon as I finished this I promise to blogg about it. ;)</p>

<p><b>Fine-tuning 2, open the batch file with visual stuido:</b></p>

<p>I included the Buildscript with the batch file into the solution. To get mark one it should be possible to run the batch in the solution explorer with a right click:</p>

<p>Alternative you could use this <a href="http://www.rickglos.com/post/How-to-run-windows-batch-files-from-Visual-Studio-2010-Solution-Explorer.aspx">trick</a>.</p>
