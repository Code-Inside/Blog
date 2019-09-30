---
layout: post
title: "Enforce Administrator mode for builded dotnet exe applications"
description: "... hello UAC!"
date: 2019-09-30 18:00
author: Robert Muehsig
tags: [.NET, .NET Core, Windows]
language: en
---

{% include JB/setup %}

# The problem

Let's say you have a .exe application builded from Visual Studio and the application always needs to be run from an administrator account. Windows Vista introduced the "User Account Control" (UAC) and such applications are marked with a special "shield" icon like this:

![x]({{BASE_PATH}}/assets/md-images/2019-09-30/uac.png "UAC")
 
__TL;DR-version:__
 
To build such an .exe you just need to add a __"application.manifest" and request the needed permission like this: 

    <requestedExecutionLevel  level="requireAdministrator" uiAccess="false" />
 
# Step by Step for .NET Framework apps

Create your WPF, WinForms or Console project and add a application manifest file:

![x]({{BASE_PATH}}/assets/md-images/2019-09-30/application-manifest.png "application manifest")

The file itself has quite a bunch of comments in it and you just need to replace 

    <requestedExecutionLevel level="asInvoker" uiAccess="false" />
	
with

    <requestedExecutionLevel  level="requireAdministrator" uiAccess="false" />
	
... and you are done.	

# Step by Step for .NET Core apps

The same approach works more or less for .NET Core 3 apps:

Add a "application manifest file", change the requestedExecutionLevel and it should "work"

*Be aware:* For some unkown reasons the default name for the application manifest file will be "app1.manifest". If you rename the file to "app.manifest", make sure your .csproj is updated as well:


    <Project Sdk="Microsoft.NET.Sdk">
    
      <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>netcoreapp3.0</TargetFramework>
        <ApplicationManifest>app.manifest</ApplicationManifest>
      </PropertyGroup>
    
    </Project>



Hope this helps!

View the [__source code on GitHub__](https://github.com/Code-Inside/Samples/tree/master/2019/NetCoreAdminTest).