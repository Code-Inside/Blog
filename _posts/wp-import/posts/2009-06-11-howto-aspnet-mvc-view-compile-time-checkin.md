---
layout: post
title: "HowTo: ASP.NET MVC View compile-time checkin"
date: 2009-06-11 01:06
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [ASP.NET MVC, Build, HowTo, View]
language: de
---
{% include JB/setup %}
<p><a href="{{BASE_PATH}}/assets/wp-images/image762.png"><img style="border-right: 0px; border-top: 0px; margin: 0px 10px 0px 0px; border-left: 0px; border-bottom: 0px" height="112" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb740.png" width="180" align="left" border="0"></a>Wer etwas mit ASP.NET MVC rumspielt wird feststellen, dass man in den View reinschreiben kann was man will, es wird meistens gebaut. Erst wenn man die Seite dann betritt kommt ein Fehler. Mit einem kleinen Trick kann man Views auch zur Kompilierzeit checken.</p><p><strong>Im View</strong></p> <p>Wenn man in einem <a href="http://asp.net/mvc">ASP.NET MVC View</a> irgendwas verkehrt macht, warnt zwar Visual Studio (obwohl man diesen Tipp nicht immer trauen kann), aber bauen lässt sich dies schon:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image763.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="55" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb741.png" width="244" border="0"></a> </p> <p><strong>Exceptions erst zur Laufzeit: HttpCompileException</strong></p> <p>Wenn man dies nun ausführt bekommt man diesen tollen <a href="http://msdn.microsoft.com/de-de/library/system.web.httpcompileexception.aspx">Fehler</a>:</p> <p><a href="{{BASE_PATH}}/assets/wp-images/image764.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="191" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb742.png" width="398" border="0"></a> </p> <p>Bei einer etwas größeren Seite wird dies allerdings sehr mühsam.</p> <p><strong>Problemlösung:</strong></p> <p>Um auch zur Kompilierzeit die View mit einzubeziehen muss man mit einem Texteditor die .csproj Projektdatei öffnen und dort folgende Änderungen machen:</p> <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c8c95118-841d-48f8-b163-ab45c40143bf" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">&lt;PropertyGroup&gt;
  &lt;OutputType&gt;Library&lt;/OutputType&gt;
  ...

  &lt;TargetFrameworkVersion&gt;v3.5&lt;/TargetFrameworkVersion&gt;
  &lt;!--&lt;MvcBuildViews&gt;false&lt;/MvcBuildViews&gt;--&gt;
&lt;/PropertyGroup&gt;

&lt;PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' "&gt;
  &lt;DebugSymbols&gt;true&lt;/DebugSymbols&gt;
  &lt;DebugType&gt;full&lt;/DebugType&gt;
  &lt;Optimize&gt;false&lt;/Optimize&gt;
  &lt;OutputPath&gt;bin\&lt;/OutputPath&gt;
  &lt;DefineConstants&gt;DEBUG;TRACE&lt;/DefineConstants&gt;
  &lt;ErrorReport&gt;prompt&lt;/ErrorReport&gt;
  &lt;WarningLevel&gt;4&lt;/WarningLevel&gt;
  &lt;MvcBuildViews&gt;true&lt;/MvcBuildViews&gt;
&lt;/PropertyGroup&gt;
&lt;PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' "&gt;
  &lt;DebugType&gt;pdbonly&lt;/DebugType&gt;
  &lt;Optimize&gt;true&lt;/Optimize&gt;
  &lt;OutputPath&gt;bin\&lt;/OutputPath&gt;
  &lt;DefineConstants&gt;TRACE&lt;/DefineConstants&gt;
  &lt;ErrorReport&gt;prompt&lt;/ErrorReport&gt;
  &lt;WarningLevel&gt;4&lt;/WarningLevel&gt;
  &lt;MvcBuildViews&gt;true&lt;/MvcBuildViews&gt;
&lt;/PropertyGroup&gt;</pre></div>
<p>Wichtig hier ist "<strong>MvcBuildViews</strong>". Dies wird per Default im oberen Abschnitt auf false gesetzt. Dieses könnt ihr entfernen. In den jeweiligen PropertyGroups könnt ihr dann entweder für Debug und Release die Option mit aktivieren.</p>
<p><strong>Ergebnis:</strong></p>
<p><a href="{{BASE_PATH}}/assets/wp-images/image765.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="167" alt="image" src="{{BASE_PATH}}/assets/wp-images/image-thumb743.png" width="471" border="0"></a> </p>
<p>Allerdings kommt man mit einem Doppelklick (leider) nicht in den View, sondern man springt in den Code der kompilierten Assembly. Allerdings kann man es nun einigermaßen zurückverfolgen.</p>
<p><strong>Performance:</strong></p>
<p>Man sollte allerdings sich überlegen ob man die Option beim Debug aktiviert. Dadurch dauert der Build Prozess um einiges Länger. Vor einem Release ist es aber jedenfall praktisch.</p>
<p>An der Stelle möchte ich mich bei Daniel Richter für den Tipp danken. Im Web bin ich bereits auf <a href="http://devermind.com/linq/aspnet-mvc-tip-turn-on-compile-time-view-checking">diesen Post</a> gestoßen der dasselbe vorschlägt, falls meine Erklärung nicht verständlich ist ;)</p>
