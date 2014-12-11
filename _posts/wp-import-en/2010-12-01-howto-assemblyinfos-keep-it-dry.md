---
layout: post
title: "HowTo: AssemblyInfos – Keep it DRY!"
date: 2010-12-01 14:52
author: CI Team
comments: true
categories: [HowTo]
tags: [assembly info, DLL, Don't repeat yourself]
language: en
---
{% include JB/setup %}
<p>&#160;</p> <img title="image" border="0" alt="image" align="left" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb267.png" width="176" height="146" />  <p>Click right on a DLL and take a look on the detail-list of the characteristics and you will find all the different entries about the version and other stuff. For those thinks we are used to create an <a href="http://msdn.microsoft.com/en-us/library/microsoft.visualbasic.applicationservices.as">assembly info file</a> during every project. But while you are doing so don't forget about the DRY principle: <a href="http://en.wikipedia.org/wiki/Don't_repeat_yourself">"Don't repeat yourself"</a></p>  <p>&#160;</p>  <!--more-->  <p><b>typical project structure</b></p>  <p><b></b></p>  <p>We have several projects in one solution and they are linked with each other in some way. In every Project we will find an Assemblyinfo file:</p>  <p>&#160;</p> <img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb268.png" width="224" height="244" />  <p><b>What's written in such an Assemblyinfo file?</b></p>  <p><b></b></p>  <p>Something like this:</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:904622e2-48be-4e3f-948e-aa975efb1f00" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System.Reflection;
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

<p><b>Redundancy... everywhere!!</b></p>

<p><b></b></p>

<p>In every Assemblyinfo we find redundancy files like for example</p>

<p>- company</p>

<p>- product</p>

<p>- copyright</p>

<p>Depending if you are a product- or a project-firm you have different needs. I only work with projects and except the title, description and guid it's the same thing anyway because I deliver everything at once and don't want to make magic stuff with the DLL.</p>

<p><b>So what can I do? Solution!</b></p>

<p>1. Create a "GlobalAssemblyInfo" file: click right on the solution and create a new item.</p>

<p>2. Write "global" things into the solution (depending on the need):</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:44670d8e-243c-4960-b524-a99c70564942" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System.Reflection;
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

<p>3. Remove "global" tings from the original Assemblyinfo. For example: this is how my Assemblyinfo from the service DLL looks like:</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:52bbae41-f6ad-42d4-8124-997d9008c386" class="wlWriterEditableSmartContent"><pre name="code" class="c#">using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

[assembly: AssemblyTitle("AssemblyInfoKeepItDry.Service")]
[assembly: AssemblyDescription("")]
[assembly: Guid("ee7c20b8-30dc-4143-bf9c-59f2d53acd85")]
</pre></div>

<p>4. link the "GlobalAssembly" with "Add Existing Item" and navigate to the file. Press "Add a Link"!!! (otherwise a copy will be created and that´s not what we want)</p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb269.png" width="459" height="406" /></p>

<p><img title="image" border="0" alt="image" src="{{BASE_PATH}}/assets/wp-images-de/image_thumb270.png" width="470" height="305" /></p>

<p><b>Thats it!</b></p>

<p><b></b></p>

<p>Now we have just one location for our file. This could be very useful if you want to, for example, administrate the version-number. You are able to change the number at one location and every DLL will be created with the same. Easy but effective.</p>

<p><a href="{{BASE_PATH}}/assets/files/democode/assemblyinfokeepitdry/assemblyinfokeepitdry.zip">[Download Democode]</a></p>
