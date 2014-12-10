---
layout: post
title: "HowTo: detect code depending’s with NDepend & TeamCity"
date: 2011-03-02 21:57
author: antje.kilian
comments: true
categories: [HowTo]
tags: [NDepend, TeamCity]
language: en
---
{% include JB/setup %}
<p>&#160;</p>  <p><b></b></p>  <p><a href="{{BASE_PATH}}/assets/wp-images-en/image129.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; display: inline; float: left; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb38.png" width="240" height="66" /></a><a href="http://www.ndepend.com/">NDepend</a> is a tool which is created to detect depending´s between .NET components. The whole thing exists as Fatclient, which is perfect to integrate in Visual Studio. And there is a console application which you are able to integrate into your Buildprocess to <a href="http://www.ndepend.com/SampleReports.aspx">create Reports</a>. How this works I´m going to tell you now....</p>  <p>&#160;</p>  <!--more-->  <p><b></b></p>  <p><b>What do we need? </b></p>  <p><b></b></p>  <p>For the first step of creation of NDepent files and a better analysis a Fatclient is a Must-Have. But in fact, I don´t think that everyone needs to install the tool. I focus on NDepend in the Buildprocess so:</p>  <p>More important is to install it on the Buildserver <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile5.png" /></p>  <p>A little hint for NDepend: You need to license this tool for every developer and for every Build machine. More details you will find on the <a href="http://www.ndepend.com/Purchase.aspx">NDepend web page</a>.</p>  <p><strong>NDepend Quickstart</strong></p>  <p>A nice declaration about how to quickstart NDepend you will find in <a href="http://www.ndepend.com/GettingStarted.aspx">this video</a>. </p>  <p>What we need now is the .ndproj file. This is what we should have in the end as result. On our <a href="http://www.bizzbingo.de/">BizzBingo.com</a> project (<a href="http://businessbingo.codeplex.com/">Codeplex</a>) we´ve integrated it into the SLN:</p>  <p><img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; padding-left: 0px; padding-right: 0px; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb363.png" width="244" height="243" />The ndproj describes all of the adjustments NDepend has made for this project. It´s an XML file. </p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>To get a feeling for this file here is a very very short view into it:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:fdfc488d-5cd6-4322-8956-f0f0f108f30d" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;?xml version="1.0" encoding="utf-8" standalone="yes"?&gt;
&lt;NDepend AppName="BusinessBingo" Platform="DotNet"&gt;
  &lt;OutputDir KeepHistoric="True" KeepXmlFiles="True"&gt;C:\TFS\bb\Main\Source\NDependOut&lt;/OutputDir&gt;
  &lt;Assemblies&gt;
    &lt;Name&gt;BusinessBingo.Data&lt;/Name&gt;
    &lt;Name&gt;BusinessBingo.Model&lt;/Name&gt;
	&lt;Name&gt;ASSEMBLIES...&lt;/Name&gt;
	...
  &lt;/Assemblies&gt;
  &lt;FrameworkAssemblies /&gt;
  &lt;Dirs&gt;
	&lt;Dir&gt;INPUT DIRs&lt;/Dir&gt;
    &lt;Dir&gt;C:\Windows\Microsoft.NET\Framework\v4.0.30319&lt;/Dir&gt;
  &lt;/Dirs&gt;
  ...
  &lt;CQLQueries...&gt;
&lt;/NDepend&gt;</pre></div>

<p>- Assemblies: All .NET Assemblies, which are recognized by NDepend for the addictions </p>

<p>- Dirs: This one describes the folders where the assemblies are in</p>

<p>- Than we have some more adjustments but they are not important at the moment</p>

<p>- The CQLQueries define the codemetrics and if they should be handled as "warnings" or "errors". But this doesen´t matter anyway <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile14.png" />&#160;</p>

<p><b></b></p>

<p><b>Team City </b></p>

<p><b></b></p>

<p>At the moment NDepend runes by Night Build in our BizzBingo project. The Nightly Build is parted into four different steps</p>

<p>1. Build SLN</p>

<p>2. NUnit </p>

<p>3. NDepend</p>

<p>4. Duplicate Finder</p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb364.png" width="485" height="285" /></p>

<p>For Ndepend the main important things are a) building and b) running the console program. For the analyses I need the assemblies <strong>and build the SLN</strong>. I know, that´s not the easiest way but it is okay:</p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb365.png" width="491" height="375" /></p>

<p>Now NDepend is involved. If you install the version for your build machine you will also receive the console program. You are able to pass some adjustments to the console program as parameters like for example the "source directory" for the assemblies or the "target directory" for the generated report. In TeamCity it will look like that:</p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb366.png" width="507" height="287" /></p>

<p>Command: (depending on where you install it)</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9b93967d-e52b-4ec0-9ec8-82ca63ec1d8e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">"C:\NDepend\NDepend.Console.exe"</pre></div>

<p>Parameters:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a487b72d-e3a9-4775-a076-e83262998e06" class="wlWriterEditableSmartContent"><pre name="code" class="c#">"%system.teamcity.build.checkoutDir%\Main\Docs\CodeQuality\BusinessBingo.ndproj" /OutDir "%system.teamcity.build.checkoutDir%\NDependOut" /InDirs "%system.teamcity.build.checkoutDir%\Main\Source\BusinessBingo\Source\BusinessBingo.Web\bin\"</pre></div>

<p>- The first parameter shows you where .ndproj is localised %system.teacity.build.checkoutDir% takes the place before TeamCity is going to replace it during the building process. </p>

<p>- As OutDir I enter "NDependOut" into the checkoutDir </p>

<p>- As InDir I enter the bin directory of the web application - of course it´s possible to link to several other folders </p>

<p><b>TeamCity artifacts and integrating the NDepend report</b></p>

<p>After we have finished the attachment we are going to talk about the artifacts in TeamCity. An artifact could be nearly everything: an assembly, a picture, an HTML template and so on...</p>

<p><a href="{{BASE_PATH}}/assets/wp-images-en/image130.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb39.png" width="431" height="282" /></a></p>

<p>&#160;</p>

<p>On BizzBingo.com we´ve integrated the following artifacts for the Nightliybuild:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:50506e52-03f8-4d00-ad6d-2602ad6e7d6a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">%system.teamcity.build.checkoutDir%\Main\Source\BusinessBingo\Source\BusinessBingo.Web\bin\BusinessBingo.*.dll =&gt; Assemblies
%system.teamcity.build.checkoutDir%\Main\Source\BusinessBingo\Source\BusinessBingo.Web\bin\BusinessBingo.*.pdb =&gt; Assemblies
%system.teamcity.build.checkoutDir%\NDependOut\**\* =&gt; Reports\NDepend
%system.teamcity.build.checkoutDir%\Main\Docs\HtmlTemplate\**\* =&gt; HtmlTemplate.zip</pre></div>

<p>The first and the second are the Dlls/Pdbs - the " =&gt;" shows in which artifact folder it should be copied. For this you could use Wildcards ore, like in line 4, you let the file zip automatically.</p>

<p>Result:</p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb368.png" width="458" height="560" /></p>

<p>The most important one is line 3. Here we took the generated report files from the build step from "NdependOut" Dir and pass them to the artifact path Reports\NDepend.</p>

<p><b>Integrate NDepend Reports Tab</b></p>

<p><b></b></p>

<p>At least we want the HTML report to be shown in TeamCity. For this you need to configure the following in the server configurations:</p>

<p>&#160;<a href="{{BASE_PATH}}/assets/wp-images-en/image132.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb40.png" width="470" height="147" /></a></p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb370.png" width="463" height="195" /></p>

<p>&#160;</p>

<p>For every build the report will be searched. If the file is found on the artifacts in the build the Report Tab will be shown either:</p>

<p>&#160;<a href="{{BASE_PATH}}/assets/wp-images-en/image133.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-en/image_thumb41.png" width="489" height="275" /></a></p>

<p>That´s it.</p>

<p><strong>TL;DR</strong></p>

<p><u>Most important steps:</u></p>

<p>- Create .ndproj files</p>

<p>- Install NDepend on the Buildserver</p>

<p>- The Assemblies, which are in the .ndproj file, should be built somehow or be there as an artifact </p>

<p>- Save the report as an artifact into TeamCity</p>

<p>- Introduce the "NDepend Report" in the server administration to TeamCity</p>

<p>- Take a look on it <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-smile" alt="Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-smile5.png" /></p>

<p><a href="http://www.troyhunt.com/2010/12/continuous-code-quality-measurement.html">Troy Hunts blogpost</a> was a big help for me with this. The NDepend analyses is based on an other artifact in his example - this would be a bigger challenge for TeamCity functions - but my way should be working as well <img style="border-bottom-style: none; border-right-style: none; border-top-style: none; border-left-style: none" class="wlEmoticon wlEmoticon-winkingsmile" alt="Zwinkerndes Smiley" src="{{BASE_PATH}}/assets/wp-images-en/wlEmoticon-winkingsmile14.png" /></p>
