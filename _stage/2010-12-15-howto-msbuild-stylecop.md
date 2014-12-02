---
layout: post
title: "HowTo: MSBuild & StyleCop"
date: 2010-12-15 18:27
author: antje.kilian
comments: true
categories: [HowTo]
tags: [MSBuild, StyleCop]
---
{% include JB/setup %}
<p>&#160;</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="http://code-inside.de/blog/wp-content/uploads/image_thumb280.png" width="189" height="157" />Code Quality is a big issue. <a href="http://stylecop.codeplex.com/">StyleCop</a> is a tool from Microsoft (an open Source Tool btw.) to analyse the Source Code. In contrast to FxCop or Code Analysis from VSTS it controls the code for observation the Codeing Conventions etc. Here a <a href="http://blogs.msdn.com/b/bharry/archive/2008/07/19/clearing-up-confusion.aspx">blogpost</a> to show you the diference. Anyway it´s quite easy to integrate StyleCop into your MSBuild and use it this way in your Build Process. </p>  <p>&#160;</p>  <!--more-->  <p><b>Conditions</b></p>  <p><b></b></p>  <p>StyleCop - I installed Version <a href="http://stylecop.codeplex.com/releases/view/44839">4.4.0.14 RTW</a>.</p>  <p>The Installation-directory for StyleCop:</p>  <p>C:\Program Files (x86)\Microsoft StyleCop 4.4.0.14</p>  <p>During the installation the Build Files have to be installed too:</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb281.png" width="421" height="327" /></p>  <p>You have the opportunity to open Stylecop in MSBuild without any other tools but in my opinion that´s not the classy way and you don´t have so many options. Take a look on <a href="http://blogs.msdn.com/b/sourceanalysis/archive/2008/05/24/source-analysis-msbuild-integration.aspx">this post</a> from the StyleCop Team. </p>  <p>It´s more interesting if you use <b>MSBuild.Extension.Pack</b></p>  <p>I´ve downloaded <a href="http://msbuildextensionpack.codeplex.com/releases/view/46020">MSBuild Extension Pack</a> August 2010 Files. In this Zip directory we only use the "MSBuild.ExtensionPack.Binaries 4.0.1.0".</p>  <p><b>Our Demoapplication</b><b> </b></p>  <p><b></b></p>  <p>Now we need to copy some files from both folders.</p>  <p>That´s what my solution looks like:</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="http://code-inside.de/blog/wp-content/uploads/image_thumb282.png" width="244" height="207" /></p>  <p>&#160;</p>  <p>In the folder "Lib" you will find 3 dlls from the StyleCop folder and the other 2 Files are from the ExtensionPack,Binaries folder. Please copy these files into one directory. </p>  <p>&#160;</p>  <p>&#160;</p>  <p>The Settings.StyleCop file, where the "Rules" for StyleCop are included, are able to be generated with Visual Studio:</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://code-inside.de/blog/wp-content/uploads/image_thumb283.png" width="244" height="237" /></p>  <p>Click on "run StyleCop" and the StyleCop file is passed to the project directory. </p>  <p><b>Let´s talk about MSBuild</b></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4bdb5f89-5a3f-4617-8aa1-b5221091969b" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Measure"&gt;
  &lt;!--&lt;Import Project="$(MSBuildStartupDirectory)\Lib\MSBuild.ExtensionPack.tasks"/&gt;--&gt;
  &lt;UsingTask AssemblyFile="$(MSBuildStartupDirectory)\Lib\MSBuild.ExtensionPack.StyleCop.dll" TaskName="MSBuild.ExtensionPack.CodeQuality.StyleCop"/&gt;
  &lt;PropertyGroup&gt;
    &lt;OutDir&gt;$(MSBuildStartupDirectory)&lt;/OutDir&gt;
  &lt;/PropertyGroup&gt;
  &lt;Target Name="Measure"&gt;
    &lt;Message Text="Measure called." /&gt;

    &lt;CreateItem Include="$(MSBuildStartupDirectory)\**\*.cs"&gt;
      &lt;Output TaskParameter="Include" ItemName="StyleCopFiles"/&gt;
    &lt;/CreateItem&gt;

    &lt;MSBuild.ExtensionPack.CodeQuality.StyleCop
          TaskAction="Scan"
          ShowOutput="true"
          ForceFullAnalysis="true"
          CacheResults="false"
          SourceFiles="@(StyleCopFiles)"
          logFile="$(OutDir)\StyleCopLog.txt"
          SettingsFile="$(MSBuildStartupDirectory)\Settings.StyleCop"
          ContinueOnError="false"&gt;
          &lt;Output TaskParameter="Succeeded" PropertyName="AllPassed"/&gt;
          &lt;Output TaskParameter="ViolationCount" PropertyName="Violations"/&gt;
          &lt;Output TaskParameter="FailedFiles" ItemName="Failures"/&gt;
    &lt;/MSBuild.ExtensionPack.CodeQuality.StyleCop&gt;
    &lt;Message Text="Succeeded: $(AllPassed), Violations: $(Violations)" /&gt;
  &lt;/Target&gt;

&lt;/Project&gt;
</pre></div>

<p>There is a Target "Measure" in the MsBuild File and we are going to import the MSBuild Extension Pack File. After this we copy all .cs files from line 10. At least we open the MSBuild Extension Pack Stylecop.</p>

<p>For return there is a bool named "Succeded" and a counter. With the help of a .bat file we open the MSBuild file.</p>

<p>As result we have a logfile+XML file with all the warnings. It´s easy to attend this file afterwards. </p>

<p>Actually I just tested this "local" but there exist integrations in <a href="http://redsolo.blogspot.com/2008/05/hudson-adds-support-for-stylecop.html">Hudson</a> and <a href="http://msmvps.com/blogs/rfennell/archive/2008/10/15/using-stylecop-in-tfs-team-build.aspx">TFS</a>.</p>

<p>Two more links about the subject:</p>

<p><a href="http://social.msdn.microsoft.com/Forums/en/msbuild/thread/016e4856-ec53-4406-8897-29908d32e905">Forumlink</a></p>

<p><a href="http://blog.newagesolution.net/2008/07/how-to-use-stylecop-and-msbuild-and.html">Blogpost</a></p>

<p>&#160;<a href="http://code-inside.de/files/democode/msbuildcodequalitystylecop/msbuildcodequalitystylecop.zip">[download democode]</a></p>
