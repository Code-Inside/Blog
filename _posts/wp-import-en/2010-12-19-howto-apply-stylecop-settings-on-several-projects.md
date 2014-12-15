---
layout: post
title: "HowTo: apply StyleCop Settings on several projects"
date: 2010-12-19 14:22
author: CI Team
comments: true
categories: [HowTo]
tags: [MSBuild, Settings, StyleCop]
language: en
---
{% include JB/setup %}


<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 10px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb286.png" width="141" height="60" />I´ve already blogged about how to use <a href="{{BASE_PATH}}/2010/12/15/howto-msbuild-stylecop/">StyleCop in an MSBuild Script</a>. Today I´m going to show you how to create a <a href="http://code.msdn.microsoft.com/sourceanalysis">StyleCop</a> Settings file and apply them in every build with visual studio. Here is an easy solution.</p>  
  

<p><b>Point of origin </b></p>  

<p>As point of origin we take the solution from the last blogpost. The stylecop file is already situated outside of the project. </p>
<p><i>Hint: To create a "default-stylecop" file just install Stylecop and click right on a project and after that click "run stylecop". After that a Settings.Stylecop file will be created into the project directory. </i></p>  

<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb287.png" width="244" height="239" /></p>
<p><i></i></p>
<p><b>Link the StyleCop file</b></p>  

<p>Click right on a project and StyleCop settings and you will be able to link a StyleCop file:</p>
<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb288.png" width="493" height="177" /></p>
<p>Here it´s possible to link our Settings.Stylecop:</p>
<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb289.png" width="385" height="348" /></p>
<p>If you done with this a file will be created in the project directory but it won´t be referenced into the project. So click on "Show all files" and copy the file into the project:</p>
<p><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb290.png" width="229" height="136" /></p>
<p>That´s the content of the file:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5d8168ae-8151-49f8-bf6d-462bc8fd117a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;StyleCopSettings Version="4.3"&gt;
  &lt;GlobalSettings&gt;
    &lt;StringProperty Name="LinkedSettingsFile"&gt;..\Settings.StyleCop&lt;/StringProperty&gt;
    &lt;StringProperty Name="MergeSettingsFiles"&gt;Linked&lt;/StringProperty&gt;
  &lt;/GlobalSettings&gt;
&lt;/StyleCopSettings&gt;
</pre>
</div>


<p><b>Repeat this in every project....</b></p>




<p><b>And now, to activate the StyleCop while building: edit project files</b></p>




<p>To check the code after every building process you need to edit the project file. The StyleCop Target should be added. </p>

<p>If you, like in my example, copy all Stylecop files from the installation directory into the solution, it will work for all project members, <b>doesn´t matter if they installed Stylecop or not. </b></p>




<p>The StyleCop file could be founded here (if you did not deselect the MSBuild files during the installation):</p>

<p>C:\Program Files (x86)\MSBuild\Microsoft\StyleCop\v4.4</p>

<p>I copied the whole folder into the solution directory.</p>

<p>Now adjust the csproj file:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:e008bfb5-b32d-44e9-bd06-91620b48ea17" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;Project ToolsVersion="4.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003"&gt;
  ...
  &lt;Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets" /&gt;
  &lt;Import Project="..\Lib\Microsoft.StyleCop.targets"/&gt;
  ...
&lt;/Project&gt;
</pre>
</div>


<p>The second import statement is responsible for the activation of StyleCop. Also the position is important. After I wrote the import statement into the first line, there was no result visible.</p>

<p>After the import of the target file in every project it´s done.</p>

<p>This course of action is from the StyleCop teamblog:</p>

<p>- <a href="http://blogs.msdn.com/b/sourceanalysis/archive/2008/05/24/source-analysis-msbuild-integration.aspx">Setting Up StyleCop MSBuild Integration</a></p>

<p>- <a href="http://blogs.msdn.com/b/sourceanalysis/archive/2008/05/25/sharing-source-analysis-settings-across-projects.aspx">Sharing StyleCop Settings Across Projects</a></p>

<p>If you want the StyleCop results to appear as Error instead of Warning than you need to define this in the csproj file. Therefore enter this parameter in the several Build Konfiguration:</p>

<p>&lt;StyleCopTreatErrorsAsWarnings&gt;false&lt;/StyleCopTreatErrorsAsWarnings&gt;</p>

<p><b>Result:</b></p>




<p>It may be helpful to integrate StyleCop into your projects. But depending on the needs of every project you need to decide which rules are helpful. The rules are easy to manage with a central StyleCop file and it will be helpful after initiation of the project / solution because you will be reminded after every build - doesn´t matter from MSBuild or via Visual Studio.</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/msbuildsharedcodequality/msbuildsharedcodequality.zip">[Download Democode]</a></p>
