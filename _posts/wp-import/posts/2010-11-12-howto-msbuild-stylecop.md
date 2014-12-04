---
layout: post
title: "HowTo: MSBuild & StyleCop"
date: 2010-11-12 23:15
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [HowTo, MSBuild, StyleCop]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image1098.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb280.png" width="189" height="157" /></a> </p>  <p>Code Quality ist ein großes Thema. <a href="http://stylecop.codeplex.com/">StyleCop</a> ist ein Tool von Microsoft (ein Open Source Tool btw. !) um den Source Code zu analysieren. Im Gegensatz zu FxCop oder gar der Code Analysis von VSTS prüft es den Code auf Einhaltung auf Codeing Conventions etc.. Hier <a href="http://blogs.msdn.com/b/bharry/archive/2008/07/19/clearing-up-confusion.aspx">ein Blogpost</a> der die Unterschiede etwas mehr aufzeigt. Nichts desto trotz kann man recht einfach StyleCop mit in sein MSBuild integrieren und so evtl. sogar in sein Build Prozess zu nutze machen.</p>  <p><strong>Vorraussetzugen</strong></p>  <p><strong>StyleCop</strong> - ich hab Version <a href="http://stylecop.codeplex.com/releases/view/44839">4.4.0.14 RTW</a> bei mir installiert.</p>  <p>Das Installationsverzeichnis von StyleCop:    <br />C:\Program Files (x86)\Microsoft StyleCop 4.4.0.14</p>  <p>Bei der Installation müssen die Build Files mit installiert werden:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1099.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb281.png" width="421" height="327" /></a> </p>  <p>Es gäbe nun noch die Möglichkeit Stylecop ohne weitere Tools in MSBuild aufzurufen, das ist aber irgendwie nicht ganz so elegant und bietet nicht so viele Möglichkeiten. <a href="http://blogs.msdn.com/b/sourceanalysis/archive/2008/05/24/source-analysis-msbuild-integration.aspx">Siehe diesen Post vom StyleCop Team</a>.</p>  <p>Etwas interessanter wird es mit dem <strong>MSBuild.Extension.Pack</strong></p>  <p>Ich habe die <a href="http://msbuildextensionpack.codeplex.com/releases/view/46020">MSBuild Extension Pack August 2010 Files</a> mir runtergeladen. In diesem Zip Verzeichnis ist für uns eigentlich nur der "MSBuild.ExtensionPack.Binaries 4.0.1.0” Ordner von Interesse. </p>  <p><strong>Unsere Demoanwendung</strong></p>  <p>Jetzt müssen wir ein paar Files von den beiden Ordnern zusammenkopieren.</p>  <p>Meine Solution sieht so aus:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1100.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb282.png" width="244" height="207" /></a> </p>  <p>Im "Lib” Ordner sind 3 dlls aus dem StyleCop Ordner und die restlichen zwei Files stammen aus dem ExtensionPack.Binaries Ordner. Diese bitte in ein Verzeichnis kopieren.</p>  <p>&#160;</p>  <p>&#160;</p>  <p>&#160;</p>  <p>Das Settings.StyleCop File, welches die "Rules” von StyleCop inne hat, kann man über das Visual Studio generieren:</p>  <p></p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1101.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb283.png" width="244" height="237" /></a> </p>  <p>Nach dem "Run StyleCop” befindet sich nun im Projekt Verzeichnis die StyleCop Datei. </p>  <p><strong>Nun zum MSBuild</strong></p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:589e34b3-8d27-452d-96b9-4f69ccca1fc1" class="wlWriterEditableSmartContent"><pre name="code" class="c#">&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Measure"&gt;
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

<p></p>

<p>In dem MSBuild File gibt es ein Target "Measure” und wir importieren das MSBuild Extension Pack File. Danach holen wir uns in Zeile 10 alle .cs Dateien. Dann kommt der eigenltiche Aufruf von dem MSBuild Extension Pack Stylecop Aufruf. </p>

<p>Als Rückgabe gibt es ein Bool namens "Succeeded” sowie einen Zähler. Über ein .bat File rufen wir einfach das MSBuild File auf.</p>

<p>Rauskommt ein Logfile + ein XML File, wo alle Warnungen drin sind. Dieses File lässt sich auch leicht weiterverarbeiten.</p>

<p>Momentan habe ich dies nur "lokal” getestet, aber es gibt Integrationen in <a href="http://redsolo.blogspot.com/2008/05/hudson-adds-support-for-stylecop.html">Hudson</a> und in den <a href="http://msmvps.com/blogs/rfennell/archive/2008/10/15/using-stylecop-in-tfs-team-build.aspx">TFS</a>.</p>

<p>Noch zwei weitere Links zum Thema:</p>

<ul>
  <li><a href="http://social.msdn.microsoft.com/Forums/en/msbuild/thread/016e4856-ec53-4406-8897-29908d32e905">Forumslink</a></li>

  <li><a href="http://blog.newagesolution.net/2008/07/how-to-use-stylecop-and-msbuild-and.html">Blogpost</a></li>
</ul>

<p><strong>[</strong><a href="{{BASE_PATH}}/assets/files/democode/msbuildcodequalitystylecop/msbuildcodequalitystylecop.zip"><strong>Download Democode</strong></a><strong>]</strong></p>
