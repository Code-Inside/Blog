---
layout: post
title: "HowTo: AssemblyInfos – Keep it DRY!"
date: 2010-11-02 00:23
author: robert.muehsig
comments: true
categories: [HowTo]
tags: [Assembly, HowTo]
---
<p><a href="{{BASE_PATH}}/assets/wp-images/image1085.png"><img style="border-bottom: 0px; border-left: 0px; margin: 0px 10px 0px 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images/image_thumb267.png" width="176" height="146" /></a> </p>  <p>Wer mal auf eine DLL ein Rechtsklick macht und auf die Detailseite der Eigenschaft schaut wird wahrscheinlich die diversen Einträge wie Versionsinfo usw. kennen. Für diese Sachen wird bei jedem Projekt eine <a href="http://msdn.microsoft.com/en-us/library/microsoft.visualbasic.applicationservices.assemblyinfo.aspx">AssemblyInfo Datei</a> generiert. Aber auch hier kann man das Prinzip: <a href="http://de.wikipedia.org/wiki/Don%E2%80%99t_repeat_yourself">"DonÂ´t repeat yourself” (DRY)</a> anwenden.</p> <!--more-->  <p><strong>Typische Projektstruktur</strong></p>  <p>Wir haben mehrere Projekte in einer Solution, welche auch untereinander irgendwie verlinkt sind. In jedem Projekt gibt es eine AssemblyInfo Datei:</p>  <p><a href="{{BASE_PATH}}/assets/wp-images/image1086.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb268.png" width="224" height="244" /></a> </p>  <p><strong>Was steht in so einer AssemblyInfo?</strong></p>  <p>Genau sowas:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c545bd01-50ff-4709-b386-3b20670ad7b2" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

// General Information about an assembly is controlled through the following 
// set of attributes. Change these attribute values to modify the information
// associated with an assembly.
[assembly: AssemblyTitle("AssemblyInfoKeepItDry.Service")]
[assembly: AssemblyDescription("")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("Microsoft")]
[assembly: AssemblyProduct("AssemblyInfoKeepItDry.Service")]
[assembly: AssemblyCopyright("Copyright Â© Microsoft 2010")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]

// Setting ComVisible to false makes the types in this assembly not visible 
// to COM components.  If you need to access a type in this assembly from 
// COM, set the ComVisible attribute to true on that type.
[assembly: ComVisible(false)]

// The following GUID is for the ID of the typelib if this project is exposed to COM
[assembly: Guid("ee7c20b8-30dc-4143-bf9c-59f2d53acd85")]

// Version information for an assembly consists of the following four values:
//
//      Major Version
//      Minor Version 
//      Build Number
//      Revision
//
// You can specify all the values or you can default the Build and Revision Numbers 
// by using the '*' as shown below:
// [assembly: AssemblyVersion("1.0.*")]
[assembly: AssemblyVersion("1.0.0.0")]
[assembly: AssemblyFileVersion("1.0.0.0")]
</pre></div>

<p><strong>Redundanzen... überall!</strong></p>

<p>Dabei steht dann in jeder AssemblyInfo zum Teil redundaten Daten drin, wie z.B.</p>

<ul>
  <li>Company</li>

  <li>Product</li>

  <li>Copyright</li>
</ul>

<p>Je nachdem ob man ein Produkthaus oder ein Projekthaus ist, wird man unterschiedliche Anforderungen haben. Ich bin im Projektgeschäft tätig und bis auf Titel, Description und die Guid steht überall dasselbe drin, weil ich immer alles auf einmal ausliefere und auch sonst kein Hexenwerk mit den DLLs mache.</p>

<p><strong>Was kann man machen? Lösung!</strong></p>

<p>1. Eine "GlobalAssemblyInfo” Datei anlegen: Rechtsklick auf die Solution und neues Item anlegen.</p>

<p>2. "Globale” Sachen (das ist aber je nach Anforderung vll. verschieden) in die Datei schreiben:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:818cf608-d4e4-4662-b327-cce4f2dc1479" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;


[assembly: AssemblyCompany("Code Inside")]
[assembly: AssemblyProduct("Demoblogpost")]
[assembly: AssemblyCopyright("Copyright Â© Code-Inside")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]
[assembly: ComVisible(false)]
[assembly: AssemblyVersion("1.0.0.0")]
[assembly: AssemblyFileVersion("1.0.0.0")]
</pre></div>

<p>3. "Globale” Sachen aus den ursprünglichen AssemblyInfos entfernen. So sieht z.B. meine AssemblyInfo aus der Service DLL aus:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4e91fc1e-e240-4e4a-9581-b3868aa44c17" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

[assembly: AssemblyTitle("AssemblyInfoKeepItDry.Service")]
[assembly: AssemblyDescription("")]
[assembly: Guid("ee7c20b8-30dc-4143-bf9c-59f2d53acd85")]
</pre></div>

<p>4. Die "GlobalAssembly” verlinken über "Add Existing Item” und zur Datei navigieren und dort explizit auf "Add as Link” drücken! (ansonsten wird eine Kopie erstellt - was den Effekt zunichte machen würde)<a href="{{BASE_PATH}}/assets/wp-images/image1087.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb269.png" width="459" height="406" /></a></p>

<p><a href="{{BASE_PATH}}/assets/wp-images/image1088.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images/image_thumb270.png" width="470" height="305" /></a> </p>

<p><strong>Fertig</strong></p>

<p>Damit haben wir nun die Daten an einer Stelle. Dies kann z.B. besonders nützlich sein wenn man die Versionsnummer zentral verwalten will. So kann man die Versionsnummer an einer Stelle ändern und alle DLLs werden mit derselben Versionsnummer gebaut. Einfach, aber wirkungsvoll.</p>

<p><a href="http://{{BASE_PATH}}/assets/files/democode/assemblyinfokeepitdry/assemblyinfokeepitdry.zip"><strong>[ Download Democode ]</strong></a></p>
